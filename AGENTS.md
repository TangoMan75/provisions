# Provisions Repository Guidelines and Overview

## Project Overview

This directory contains "TangoMan Provisions," a collection of shell scripts designed to automate the setup and provisioning of a development machine. The scripts are organized into categories (e.g., `dev`, `ide`, `devops`) and can be executed individually or through "recipe" scripts that group related installations and configurations.

## Building and Running

The core of this project is a set of shell scripts. There is no "build" process. You run the scripts directly from your terminal.

The main entry points are the `recipe_*.sh` files. These files chain together other scripts to provision a specific environment. For example, to set up a basic development environment, you would run:

```bash
./recipe_dev_essentials.sh
```

To install a specific application, you can run the corresponding script directly:

```bash
./dev/install_git.sh
```

## Development Conventions

- **Structure:** Scripts are organized into folders based on their purpose (e.g., `dev`, `ide`, `devops`, `network`).
- **Recipes:** `recipe_*.sh` scripts are used to orchestrate the execution of other scripts, creating a full provisioning process.
- **Configuration:** `config_*.sh` scripts are used to apply specific configurations to tools.
- **Installation:** `install_*.sh` scripts are used to install applications and tools.
- **Shell:** All scripts are written in `bash`.
- **Error Handling:** The scripts use `set -e` to exit immediately if a command fails.
- **Output:** The scripts use a common `colors.sh` library to provide colored output for better readability.

## Build/Lint/Test Commands

### Linting
- **Full lint**: `./entrypoint.sh lint`
- **Single file**: `shellcheck path/to/file.sh`

### Testing
- **All tests**: `./tools/entrypoint.sh tests`
- **Single test file**: `./tools/tests/bash_unit tools/tests/test_specific.sh`
- **Test with pattern**: `./tools/tests/bash_unit -p "pattern" tools/tests/test_file.sh`

### CI/CD
- **GitHub Actions**: Triggered on push/PR to main branch, runs shellcheck via `./entrypoint.sh lint`

## Test Structure
- **Framework**: bash_unit (https://github.com/pgrange/bash_unit)
- **Assertions**: `assert`, `assert_fails`, `assert_status_code`, `assert_equals`, `assert_not_equals`
- **Test naming**: `test_function_name_should_do_something()`
- **Setup/Teardown**: Optional `setup()` and `teardown()` functions

## Code Style Guidelines

### Script Structure
- **Shebang**: `#!/bin/bash` at line 1.
- **Header**:
  - Copyright and MIT license notice.
  - Package reference: "This file is part of TangoMan Provisions package."
  - Optional module metadata (`@link`, `@category`).
- **Path bootstrap**:
  - `CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")`
  - Source shared libs with `# shellcheck source=/dev/null`.
  - Colors: `. "${CURDIR}/../tools/src/colors/colors.sh"`
  - Git util (when releases are involved): `. "${CURDIR}/../tools/src/git/get_latest_release.sh"`

### Dependencies and Guards
- **Hard deps check**: Guard required commands explicitly with `command -v`, exit with `_echo_danger` on missing tools.
  - Example: `wget`, `tar`, `unzip` (and `curl` if used).
- **No implicit install**: Only instruct the user with an apt hint in the error message, do not run package installs automatically.
- **Exit on error for missing deps**: `exit 1` immediately after the danger message.

### Naming and Variables
- **Project metadata**:
  - `PROJECT`, `AUTHOR`, `REPOSITORY="${AUTHOR}/${PROJECT}"`.
  - `APP_NAME="${PROJECT}"`, `DESKTOP="${APP_NAME}.desktop"`.
- **Versioning**:
  - `DEFAULT_VERSION=<semver>`
  - `VERSION=$(get_latest_release "${REPOSITORY}")` with fallback to `DEFAULT_VERSION` if empty.
- **Artifacts**:
  - Prefer platform-aware names: `"${PROJECT}_${VERSION}_$(uname -s)_$(uname -m).tar.gz"`.
  - Use `mktemp -d` for `ARCHIVE` directory and extraction `TEMP`.
- **Destinations**:
  - Default `DESTINATION=/usr/bin`.
  - Create destination if absent: `mkdir -p "${DESTINATION}"`.

### Downloads
- **Primary source**: GitHub releases:
  - `URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"`
- **Downloader selection**:
  - Prefer `curl -L` when available; fallback to `wget -nv`.
- **Logging**:
  - Always surface the exact command with `_echo_info` before execution.

### Extraction and Install
- **Archive detection**:
  - For `.tar.gz`: `sudo tar -C ${DESTINATION} -xvzf "${ARCHIVE}" "${APP_NAME}"`
  - For `.zip`: `unzip "${ARCHIVE}" -d "${TEMP}"`, then copy binary out with `sudo cp -f`.
- **Permissions**:
  - `sudo chmod uga+x "${DESTINATION}/${APP_NAME}"`

### Desktop Shortcuts (Optional)
- When relevant, copy desktop entry to user's Desktop from:
  - `/usr/share/applications/${DESKTOP}`
  - `/var/lib/snapd/desktop/applications/${DESKTOP}`
  - `/var/lib/flatpak/app/${APP_NAME}/current/active/export/share/applications/${DESKTOP}`
- Always log with `_echo_info` before `cp -p`.

### Logging Conventions
- **Use color helpers** from `colors.sh`:
  - `_alert_primary` for main action titles.
  - `_echo_info` for commands being executed.
  - `_echo_danger` for errors.
- **Show commands** before running them; include `\n` at end for readability.
- **Finish with**:
  - `_echo_info 'sync\n'`
  - `sync`

### Error Handling
- Guard all operations and exit on prerequisites
- No silent failures - surface errors with appropriate messages
- Use `_echo_danger` for errors, `exit 1` for failures

### Formatting & Syntax
- **Quoting**: Double-quote all variable expansions
- **Commands**: Use `$(...)` instead of backticks

### Shellcheck and Style
- **shellcheck**: Add `# shellcheck source=/dev/null` when sourcing relative paths.
- **No unguarded globs**: Reference explicit paths and filenames.
- **No inline imports after code starts**: Source libraries at the top, after `CURDIR` is defined.

### Idempotency and Safety
- **Create directories only if missing**.
- **Overwrite binaries safely** with `sudo cp -f` when intended.
- **No silent failures**: guard steps and exit on missing prerequisites.
- **Avoid changing user environment** beyond the scope of the install (no implicit `cd`, no profile modification unless explicit to the script's goal).

### Scope
- **Target files**: `**/*.sh` (installers, config scripts, recipes).
- **Primary references**: `templates/*.sh`.
- **Goal**: Consistent structure, safe behavior, predictable UX/logging.

### GitHub Release Pattern (When Applicable)
- Compute `VERSION` via `get_latest_release`.
- Build `URL` for `v${VERSION}` tag.
- Construct `REMOTE_FILE` consistently using `PROJECT`, `VERSION`, `uname -s`, `uname -m`.

### Command Echo Pattern
- Before each significant operation, print the exact command with `_echo_info`.
- Keep the execution line immediately after the echo for visual pairing.

### Expected Script Flow (Checklist)
- **Header + licensing**
- **CURDIR and sources** (`colors.sh`, optional `get_latest_release.sh`)
- **Deps checks** (`wget`, `tar`, `unzip`, optional `curl`)
- **Metadata** (`PROJECT`, `AUTHOR`, `REPOSITORY`, `APP_NAME`, `DESKTOP`)
- **Version resolution** (`DEFAULT_VERSION`, `VERSION` with fallback)
- **Artifact names/paths** (`REMOTE_FILE`, `ARCHIVE`, `DESTINATION`, `TEMP`)
- **URL build** and download (log + run)
- **Ensure destination exists**
- **Extract/copy** based on archive type
- **Desktop entries** copy (if applicable)
- **chmod** target binary
- **sync** at end

### Don'ts
- **Don't** auto-install apt packages.
- **Don't** write to arbitrary system locations without logging and intent.
- **Don't** rely on unspecified environment state; compute paths from `CURDIR`.

## Templates

The following template scripts are available in the `templates/` folder to serve as starting points for creating new installation scripts:

- `install_template_apt.sh`: Template for installing applications via APT package manager, with optional PPA and GPG keyring support.
- `install_template_debian.sh`: Template for downloading and installing .deb packages directly.
- `install_template_flatpak.sh`: Template for installing Flatpak applications.
- `install_template_github.sh`: Template for downloading and installing binaries from GitHub releases.
- `install_template_npm_global_package.sh`: Template for installing Node.js packages globally via npm.
- `install_template_snap.sh`: Template for installing Snap packages.
- `remove_template_apt.sh` Template for removing applications via APT package manager.
- `remove_template_debian.sh` Template for removing .deb packages.
- `remove_template_flatpak.sh`: Template for removing flatpak packages.
- `remove_template_npm_global_package.sh`: Template for removing globally installed npm packages.

Use the appropriate template based on the installation method required for the application.
