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

### Shell Script Structure
- **Shebang**: `#!/bin/bash` at line 1
- **Header**: Copyright notice, MIT license, package reference, optional metadata (@link, @category)
- **Bootstrap**: `CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")`
- **Imports**: Source libraries after CURDIR with `# shellcheck source=/dev/null`

### Dependencies & Guards
- Check required commands with `command -v` and exit with `echo_danger` on missing tools
- No implicit package installation - instruct user with apt hints in error messages
- Exit immediately after dependency errors

### Naming Conventions
- **Project metadata**: `PROJECT`, `AUTHOR`, `REPOSITORY="${AUTHOR}/${PROJECT}"`
- **Apps**: `APP_NAME="${PROJECT}"`, `DESKTOP="${APP_NAME}.desktop"`
- **Versioning**: `DEFAULT_VERSION=<semver>`, `VERSION=$(get_latest_release "${REPOSITORY}")`
- **Artifacts**: Platform-aware names like `"${PROJECT}_${VERSION}_$(uname -s)_$(uname -m).tar.gz"`
- **Directories**: `DESTINATION=/usr/bin`, create with `mkdir -p`

### Downloads & Extraction
- **GitHub releases**: `URL="https://github.com/${REPOSITORY}/releases/download/v${VERSION}/${REMOTE_FILE}"`
- **Downloaders**: Prefer `curl -L`, fallback to `wget -nv`
- **Archives**: `tar -C ${DESTINATION} -xvzf` for .tar.gz, `unzip` for .zip
- **Permissions**: `sudo chmod uga+x "${DESTINATION}/${APP_NAME}"`

### Logging Conventions
- **Colors**: Use helpers from `colors.sh` (alert_primary, echo_info, echo_danger, etc.)
- **Command logging**: Show exact commands with `echo_info` before execution
- **Finish**: `echo_info 'sync\n'` followed by `sync`

### Error Handling
- Guard all operations and exit on prerequisites
- No silent failures - surface errors with appropriate messages
- Use `echo_danger` for errors, `exit 1` for failures

### Formatting & Syntax
- **Quoting**: Double-quote all variable expansions
- **Commands**: Use `$(...)` instead of backticks
- **Shellcheck**: Add `# shellcheck source=/dev/null` for relative path sourcing
- **No unguarded globs**: Use explicit paths and filenames
- **No inline imports**: Source libraries at top after CURDIR definition

### Idempotency & Safety
- Create directories only if missing
- Overwrite binaries safely with `sudo cp -f` when intended
- Avoid changing user environment beyond script scope
- No implicit cd, profile modifications unless explicit

### Scope
- **Target files**: `**/*.sh` (installers, config scripts, recipes).
- **Primary reference**: `template_script.sh`.
- **Goal**: Consistent structure, safe behavior, predictable UX/logging.

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
- **Hard deps check**: Guard required commands explicitly with `command -v`, exit with `echo_danger` on missing tools.
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
  - Always surface the exact command with `echo_info` before execution.

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
- Always log with `echo_info` before `cp -p`.

### Logging Conventions
- **Use color helpers** from `colors.sh`:
  - `alert_primary` for main action titles.
  - `echo_info` for commands being executed.
  - `echo_danger` for errors.
- **Show commands** before running them; include `\n` at end for readability.
- **Finish with**:
  - `echo_info 'sync\n'`
  - `sync`

### Idempotency and Safety
- **Create directories only if missing**.
- **Overwrite binaries safely** with `sudo cp -f` when intended.
- **No silent failures**: guard steps and exit on missing prerequisites.
- **Avoid changing user environment** beyond the scope of the install (no implicit `cd`, no profile modification unless explicit to the script's goal).

### Shellcheck and Style
- **shellcheck**: Add `# shellcheck source=/dev/null` when sourcing relative paths.
- **Quoting**: Double-quote variable expansions; prefer `$(...)` over backticks.
- **No unguarded globs**: Reference explicit paths and filenames.
- **No inline imports after code starts**: Source libraries at the top, after `CURDIR` is defined.

### GitHub Release Pattern (When Applicable)
- Compute `VERSION` via `get_latest_release`.
- Build `URL` for `v${VERSION}` tag.
- Construct `REMOTE_FILE` consistently using `PROJECT`, `VERSION`, `uname -s`, `uname -m`.

### Command Echo Pattern
- Before each significant operation, print the exact command with `echo_info`.
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