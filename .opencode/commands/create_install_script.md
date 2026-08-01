---
description: Scaffold a new install_*.sh script (and matching remove_*.sh when a template exists) from a single free-form prompt
agent: build
---

# Create Install Script
Generate a new install script for the TangoMan Provisions package by **inferring** the right template, app metadata, and category from a single free-form prompt.
The agent uses `webfetch` to consult the upstream documentation, picks the most appropriate template, adapts it to the actual install procedure (without copying it verbatim), and lints the result with `shellcheck`.

## Arguments

The command accepts a **single argument**: a free-form prompt passed via `$ARGUMENTS` (whitespace-preserved). The prompt may take any of these forms:

| Form                       | Example                                                                |
|----------------------------|------------------------------------------------------------------------|
| Bare app name              | `bat`, `fzf`, `lazygit`, `acli`                                        |
| App name + intent          | `install ripgrep from source`                                          |
| Official docs URL          | `https://github.com/junegunn/fzf#installation`                         |
| GitHub repository URL      | `https://github.com/sharkdp/bat`                                       |
| Provider URL               | `https://pypi.org/project/black`, `https://flathub.org/apps/...`       |
| npm package name           | `@grinev/opencode-telegram-bot`, `typescript`                          |
| Mixed                      | `ripgrep https://github.com/BurntSushi/ripgrep`                        |

No positional parsing is performed. The agent must interpret the whole prompt.

## Inference flow

The agent must infer as much as possible from the prompt and from any fetched content.
Do **not** ask the user for fields that can be discovered automatically.

### 1. Parse the prompt

- Detect whether the prompt contains a URL (regex `https?://\S+`). If yes, record it as `PROMPT_URL`.
- Detect npm package names: check if the text (or a leading token before whitespace) matches the scoped pattern `@[a-z0-9-~][a-z0-9-._~]*/[a-z0-9-._~]+` or the unscoped pattern `[a-z0-9-][a-z0-9-._~]*`. If it does, set `IS_NPM_PACKAGE=true` and store the full name as `NPM_PACKAGE_NAME` (e.g. `@grinev/opencode-telegram-bot`). Use this name as the `APP_NAME` candidate directly.
- The remaining text (or the whole prompt if no URL and no npm package detected) becomes the `APP_NAME` candidate. Normalize to lowercase, strip whitespace, and strip the trailing `.com` / `.io` / `.app` / `.dev` TLD when the input looks like a bare domain.

### 2. Fetch the upstream (if available)

If a URL is present, use the `webfetch` tool to retrieve it (markdown by default).
If only a name is given, build a candidate URL in this order and `webfetch` the first that returns useful content:

**If `IS_NPM_PACKAGE=true` was set in step 1:**
1. `https://www.npmjs.com/package/<NPM_PACKAGE_NAME>` — the npm registry page (details, install command, links to repo).
2. `https://registry.npmjs.org/<NPM_PACKAGE_NAME>/latest` — the npm registry JSON API for version info and repo URL.
3. Extract the `repository.url` from the JSON response (or the GitHub link from the npm page) and fall back to `https://github.com/<author>/<name>` if the response strongly suggests a GitHub home.

**Otherwise (no npm package detected):**
1. `https://github.com/<name>` (most CLI tools live on GitHub).
2. `https://github.com/<guess-org>/<name>` when the name strongly suggests a known org (e.g. `fzf` → `junegunn/fzf`).
3. The project homepage (e.g. `https://ripgrep.rs`).
4. The package provider's docs page (PyPI, npm, Flathub, Snap Store, crates.io, pkg.go.dev).

When fetching, **prefer Debian/Ubuntu installation instructions** in the returned content (look for sections titled "Install", "Installation", "Debian", "Ubuntu", "Linux", "Getting Started").
Fall back to the generic install section only if no Debian-specific one is found.

From the fetched content, extract:

- Canonical `APP_NAME` (project name; the variable is always lowercase, the heading preserves the project casing when relevant).
- A short description (1-3 sentences, plain text — rephrase lightly if needed to match the style of existing scripts in the repo).
- Installation method hints: keywords like `apt`, `dpkg`, `snap`, `flatpak`, `npm install -g`, `pipx install`, `curl | sh`, `git clone`, GitHub release assets ending in `.tar.gz` / `.zip` / `.deb`, raw `raw.githubusercontent.com` URLs, etc.
- Upstream `URL`s (release artifact, install script, repository clone URL, homepage).
- Author / GitHub org when obvious.
- Any non-trivial post-install step (config file, shell alias, `PATH` change, git config, system service, ...).

### 3. Determine the install method

Map the upstream's documented install procedure to one of the supported methods:

| Method       | When to pick                                                                                  |
|--------------|------------------------------------------------------------------------------------------------|
| `apt`        | App is in the default Debian/Ubuntu repos, or has a documented APT repo / PPA.                 |
| `debian`     | App distributes an official `.deb` package with a direct download URL.                         |
| `github`     | App publishes prebuilt binaries on GitHub Releases (`.tar.gz` / `.zip`).                       |
| `snap`       | App is published on the Snap Store.                                                            |
| `flatpak`    | App is published on Flathub.                                                                   |
| `npm`        | App is a global Node CLI (`npm install -g <pkg>`).                                             |
| `pipx`       | App is a Python CLI tool meant to be installed via `pipx`.                                    |
| `curl`       | App is installed with a single `curl ... | sh` command from a raw `raw.githubusercontent.com` URL.  |
| `oneliner`   | App provides a one-line install (e.g. `curl -fsSL ... | bash`).                               |
| `git_clone`  | App must be cloned and built from source, or installed by placing the repo in a known path.   |

**npm package shortcut:** When `IS_NPM_PACKAGE=true` was set in step 1, default the method to `npm` without requiring upstream confirmation, unless the fetched npm page clearly documents a different primary install method (e.g. `npx` with no install step) — in that case, prefer the documented method.

If multiple methods apply, prefer the one closest to a stock Debian workflow, in this order:

```
apt > debian > snap > flatpak > github > curl > oneliner > git_clone > npm > pipx
```

If no method can be inferred with confidence, **ask the user once** with the `question` tool, listing the candidate methods as options.

### 4. Determine the category

Look at the existing category folders in the repo root:

```
ai  android  backups  browser  burning  cli  communication  crypto
dev  devops  docker  drivers  fonts  games  graphics  ide  kali
multimedia  network  productivity  security  servers  system  termux
```

Pick the closest match based on the app's purpose. If the user explicitly named a category in the prompt, use that.
If the best fit is missing from the list, ask the user once whether to create a new folder or pick from existing ones.
When creating a new folder, use `mkdir -p` before writing the script.

### 5. Compose the metadata block

Build an internal metadata record with at least:

- `APP_NAME` — lowercase, single token, used as the file name and the script variable.
- `SHORT_DESCRIPTION` — 1-3 sentences drawn from the upstream docs.
- `CATEGORY` — folder name from step 4.
- `METHOD` — chosen method from step 3.
- `UPSTREAM_URL` — homepage, repository, or release page used to source the install steps.
- Method-specific fields, populated from the upstream fetch:
  - `URL` — direct download URL (debian / github / oneliner / curl).
  - `REPOSITORY` — `<author>/<app>` slug (github / git_clone / curl).
  - `BINARY` — binary name inside the archive (github).
  - `DESTINATION` — install path (github: `${HOME}/.local/bin`; git_clone: `${HOME}/.local/share/${APP_NAME}`).
  - `VERSION` and `DEFAULT_VERSION` — for github / oneliner-style scripts, derive from `get_latest_release` with a hard-coded fallback matching the latest known release.
  - `REMOTE_FILE` / `ARCHIVE` — the release artifact name.
  - `PPA`, `KEYRING_URL`, `KEYRING` — for apt.
  - `PACKAGE_NAME` — for npm (`@<author>/<app>` by default).
  - `AUTHOR` — for npm packages, derive from the scope: `@scope/package` → `scope` as `AUTHOR`; for unscoped packages, set `AUTHOR` empty and use `PACKAGE_NAME=<app>`.

## Template selection (treat as reference, not source of truth)

Read the matching template (and remove template, when available) from `templates/`:

| Method       | Install template                                       | Remove template (if any)                                  |
|--------------|--------------------------------------------------------|-----------------------------------------------------------|
| `apt`        | `templates/install_template_apt.sh`                    | `templates/remove_template_apt.sh`                        |
| `debian`     | `templates/install_template_debian.sh`                 | `templates/remove_template_debian.sh`                     |
| `github`     | `templates/install_template_github.sh`                 | —                                                         |
| `snap`       | `templates/install_template_snap.sh`                   | —                                                         |
| `flatpak`    | `templates/install_template_flatpak.sh`                | `templates/remove_template_flatpak.sh`                    |
| `npm`        | `templates/install_template_npm_global_package.sh`     | `templates/remove_template_npm_global_package.sh`         |
| `pipx`       | `templates/install_template_pipx_global_package.sh`    | —                                                         |
| `curl`       | `templates/install_template_curl.sh`                   | —                                                         |
| `oneliner`   | `templates/install_template_oneliner.sh`               | —                                                         |
| `git_clone`  | `templates/install_template_git_clone.sh`              | —                                                         |

**Do not copy the template verbatim.** Treat it as a *reference*:

- Keep the license header, the `CURDIR` bootstrap, the `colors.sh` source line, and the `# shellcheck source=/dev/null` annotation as-is — they are non-negotiable repo conventions.
- Keep the section separators (`#--------------------------------------------------`).
- Drop template-only sections that are not relevant to the target app (e.g. drop the PPA / keyring block for an app that has no PPA; drop the GitHub release asset extraction when the app distributes a `.deb`; drop the desktop shortcut block for a headless CLI tool).
- Add steps that the upstream procedure requires but the template omits (e.g. `sudo apt-get install -f -y` after a manual `.deb`, `xdg-mime` default registration, a symlink for `PATH`, `git config` tweaks, ...). Follow the same logging style: `_echo_info` before the command, `_echo_warning` for section titles, `_echo_danger` for errors.
- Reorder sections to match the natural install flow of the target app (e.g. clone → build → install → symlink for a `git_clone` tool that needs `make`).
- Use real values (URLs, package names, repo slugs) **resolved from the upstream fetch**, not the placeholder strings from the template.

## Execution flow

### 1. Read the prompt

Read `$ARGUMENTS`. Strip leading/trailing whitespace. If empty, ask the user to provide a name or URL.

### 2. Detect URL and fetch upstream

- If a URL is present, `webfetch` it. Parse the returned markdown for `APP_NAME`, description, and install steps.
- If `IS_NPM_PACKAGE=true` was set in step 1, fetch the npm registry page at `https://www.npmjs.com/package/<NPM_PACKAGE_NAME>` and optionally the JSON API at `https://registry.npmjs.org/<NPM_PACKAGE_NAME>/latest`. Derive `AUTHOR` from the scope (or leave empty for unscoped packages), `PACKAGE_NAME` from `NPM_PACKAGE_NAME`, and `APP_NAME` from the package name portion (after the `/` for scoped packages).
- Otherwise, if only a name is present, build candidate URLs (see "Fetch the upstream" above) and `webfetch` the first that returns useful content. If every candidate fails, ask the user for a documentation URL.

### 3. Validate and infer

- Derive `APP_NAME`, `SHORT_DESCRIPTION`, `CATEGORY`, `METHOD`, `UPSTREAM_URL`, and any method-specific fields from the fetched content.
- If `CATEGORY` is missing from the repo root, ask the user (create new vs. pick existing).
- If `METHOD` is ambiguous, ask the user with the candidate list.
- Confirm `<category>/install_<app>.sh` does **not** already exist. If it does, abort without overwriting and tell the user to remove the file first.
- Confirm the corresponding template file(s) exist on disk.

### 4. Read the relevant template(s)

Use the `read` tool on the chosen install template (and remove template when applicable). Note the structure; you do not need to preserve it verbatim.

### 5. Compose the new file(s)

Generate the install script content:

- Start with the standard license header (use the current year as in existing scripts, e.g. `Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>`).
- Replace `## template` with `## <app_name>` (preserve the upstream's casing in the heading, lowercase in the `APP_NAME` variable).
- Replace the `## A short description` block with a real description drawn from the upstream fetch.
- Replace `## @category template` with `## @category <category>`. - Replace `## @link     https://github.com/TangoMan75/template` with the real upstream URL. Add additional `@link` annotations for any extra relevant pages (Flathub, npm registry, PyPI, official homepage).
- Fill in `APP_NAME` and any method-specific variables (`URL`, `BINARY`, `PPA`, `KEYRING`, `REPOSITORY`, `DESTINATION`, `VERSION`, `REMOTE_FILE`, `PACKAGE_NAME`, ...).
- Adapt the install body to the upstream procedure, keeping only the template sections that are actually needed and adding any extra steps required.
- Preserve logging style (`_echo_info`, `_echo_warning`, `_echo_danger`, `_alert_primary`) and the `#--------------------------------------------------` separators.
- Preserve quoted variable expansions and the `_echo_info "<command>"` pattern immediately before every `sudo` / install command.

For the remove script (only when a matching remove template exists in the table above), apply the same adaptation rules and use `_alert_danger "Remove <app>"` for the header.

### 6. Write the new file(s)

- Always write `<category>/install_<app>.sh`.
- If a matching remove template exists, also write `<category>/remove_<app>.sh`.
- Use the `write` tool to create each file.

### 7. Make executable

Print the command first, then run it:

```bash
chmod +x "<category>/install_<app>.sh"
```

If a remove script was generated:

```bash
chmod +x "<category>/remove_<app>.sh"
```

### 8. Lint with shellcheck

Print the command first, then run it:

```bash
shellcheck "<category>/install_<app>.sh"
```

If a remove script was generated:

```bash
shellcheck "<category>/remove_<app>.sh"
```

Surface any warnings or errors verbatim. If shellcheck is not available,
warn the user and point them to `sudo apt-get install -y shellcheck`.

### 9. Confirmation and reminders

Print a final summary:

- Absolute path of the generated file(s).
- The inferred `APP_NAME`, `CATEGORY`, `METHOD`, and `UPSTREAM_URL`.
- The upstream source(s) that were fetched.
- Shellcheck result (clean / N warnings / N errors).
- A reminder to:
  - Refine the description block if the inference was approximate.
  - Verify any `TODO:` placeholders left for steps that could not be resolved automatically.
  - If the method has no remove template (`github`, `snap`, `pipx`, `curl`, `oneliner`, `git_clone`), consider writing a `remove_<app>.sh` manually later.
  - Manually add the new script to the appropriate `recipe_*.sh` if desired.

## Conventions enforced (per `AGENTS.md`)

- `#!/bin/bash` on line 1.
- License header and "TangoMan Provisions package" comment block.
- `CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")` bootstrap.
- `colors.sh` sourced with `# shellcheck source=/dev/null`.
- `#--------------------------------------------------` section separators.
- `_echo_info "<command>"` echoed immediately before each `sudo` / install command.
- `_alert_primary "Install <app>"` for installs, `_alert_danger "Remove <app>"` for removals.
- Quoted variable expansions everywhere.

## Idempotency and safety

- Refuse to overwrite an existing `<category>/install_<app>.sh` or `<category>/remove_<app>.sh`. Abort with a clear message; do not delete or modify existing files.
- The command itself only writes files, runs `chmod +x`, and runs `shellcheck`. It does **not** execute the generated install script and does **not** require `sudo`.
- The generated install script may invoke `sudo` (intentionally, by design of the templates), but that is only triggered when the user runs the script manually.

## Out of scope

- Do **not** auto-add the new script to a `recipe_*.sh` file. Leave that to the user, matching the rest of the repo's manual workflow.
- Do **not** auto-generate a `.desktop` file. The install script handles that itself where appropriate.
- Do **not** auto-create tests. The repo's bash_unit tests are not per-script.
