---
description: Scaffold a new remove_*.sh script by reading its matching install_*.sh, picking the right remove template, and adding cleanup steps for config/cache/desktop files
agent: build
---

# Create Remove Script
Generate a new remove script for the TangoMan Provisions package by **inferring** the install method, app metadata, and category from the matching `install_*.sh` (and optionally a free-form prompt), then picking the appropriate remove template and adding cleanup steps for any leftover state (config, cache, data directories, desktop shortcuts).
The agent uses `webfetch` only when needed to resolve ambiguous identifiers (e.g. a Flathub app id, an npm package scope), reads the existing install script as the source of truth, and lints the result with `shellcheck`.

## Arguments

The command accepts a **single argument**: a free-form prompt passed via `$ARGUMENTS` (whitespace-preserved). The prompt may take any of these forms:

| Form                       | Example                                                                |
|----------------------------|------------------------------------------------------------------------|
| Bare app name              | `bat`, `fzf`, `lazygit`, `acli`                                        |
| `category/app_name`        | `cli/acli`, `dev/composer`, `ai/opencode`                              |
| `app_name` + install path  | `remove ripgrep` (looks for `*/install_ripgrep.sh`)                    |
| Official docs URL          | `https://github.com/junegunn/fzf#installation`                         |
| GitHub repository URL      | `https://github.com/sharkdp/bat`                                       |
| Provider URL               | `https://pypi.org/project/black`, `https://flathub.org/apps/...`       |
| npm package name           | `@grinev/opencode-telegram-bot`, `typescript`                          |
| Mixed                      | `ripgrep https://github.com/BurntSushi/ripgrep`                        |

No positional parsing is performed. The agent must interpret the whole prompt and **always** find the matching `install_*.sh` before writing the remove script. The install script is the source of truth for the uninstall procedure.

## Inference flow

The agent must infer as much as possible from the prompt, from the matching `install_*.sh`, and from any fetched content.
Do **not** ask the user for fields that can be discovered automatically.

### 1. Parse the prompt

- Detect whether the prompt contains a URL (regex `https?://\S+`). If yes, record it as `PROMPT_URL`.
- Detect a `category/app_name` pattern: a leading `<word>/<word>` token where both segments are lowercase. If matched, use the first segment as `CATEGORY` candidate and the second as `APP_NAME` candidate.
- Detect npm package names: check if the text (or a leading token before whitespace) matches the scoped pattern `@[a-z0-9-~][a-z0-9-._~]*/[a-z0-9-._~]+` or the unscoped pattern `[a-z0-9-][a-z0-9-._~]*`. If it does, set `IS_NPM_PACKAGE=true` and store the full name as `NPM_PACKAGE_NAME` (e.g. `@grinev/opencode-telegram-bot`). Use this name as the `APP_NAME` candidate directly.
- The remaining text (or the whole prompt if no URL and no npm package detected) becomes the `APP_NAME` candidate. Normalize to lowercase, strip whitespace, and strip the trailing `.com` / `.io` / `.app` / `.dev` TLD when the input looks like a bare domain.

### 2. Locate the matching install script

A remove script only makes sense next to a paired install script. **Always** locate the install script first.

Search the repo for `**/install_<app>.sh` in this order:

1. If `CATEGORY` is known, look under `CATEGORY/install_<app>.sh`.
2. Otherwise run a `glob` for `**/install_<app>.sh` across the repo.
3. If multiple matches exist (e.g. `multimedia/install_freetube_debian.sh` and `multimedia/install_freetube_flatpak.sh`), list the candidates and ask the user to pick one.
4. If no match is found, fetch the upstream (see step 3) and **ask the user once** whether to:
   - Create a remove script for an app that has no install script in the repo (rare).
   - Or abort until the install script is created.

The matching install script is required. Do not synthesize a remove script for an app whose install procedure is unknown.

### 3. Fetch the upstream (only when needed)

If the install script does not expose enough information to identify the right uninstaller (e.g. it is a custom curl-pipe install and the script does not record the install URL, or the flatpak app id is missing), `webfetch` may be used to resolve the missing field. Most of the time the install script is enough.

**If `IS_NPM_PACKAGE=true` was set in step 1:**
1. `https://www.npmjs.com/package/<NPM_PACKAGE_NAME>` — the npm registry page.
2. `https://registry.npmjs.org/<NPM_PACKAGE_NAME>/latest` — the npm registry JSON API for the canonical package name and repo URL.

**Otherwise (no npm package detected):**
1. `https://github.com/<name>` (most CLI tools live on GitHub).
2. `https://github.com/<guess-org>/<name>` when the name strongly suggests a known org.
3. The project homepage.
4. The package provider's docs page (PyPI, npm, Flathub, Snap Store, crates.io, pkg.go.dev).

From the install script and any fetched content, extract:

- Canonical `APP_NAME` (lowercase, single token; matches the install script's `APP_NAME`).
- A short description (1-3 sentences, plain text — pulled from the install script's description block when present, rephrased lightly if needed).
- Install method (read from the install script's body or by the variables it sets: `apt`, `debian`, `snap`, `flatpak`, `npm`, `github`, `curl`, `oneliner`, `git_clone`, `pipx`).
- Method-specific uninstall identifiers:
  - `apt`: package name (usually `${APP_NAME}`), PPA repo id, keyring path, sources list path.
  - `debian`: `.deb` package name (`dpkg -l` lookup if needed).
  - `snap`: snap name (often equals `${APP_NAME}`).
  - `flatpak`: app id (e.g. `org.gimp.GIMP`); resolve via Flathub when the install script only stores a display name.
  - `npm`: `PACKAGE_NAME` (e.g. `@scope/name`).
  - `github` / `curl` / `oneliner` / `git_clone` / `pipx`: binary path (`DESTINATION`/`/usr/local/bin`/`${HOME}/.local/bin`), the clone or share directory (`${HOME}/.local/share/${APP_NAME}`), and any post-install state (config, cache, data).
- Any non-trivial post-install state that the install script created and the remove script must clean up: config directory (`~/.config/<app>`), cache directory (`~/.cache/<app>`), data directory (`~/.local/share/<app>`), state directory (`~/.local/state/<app>`), dotfiles (`~/.${app}`), shell rc fragments, PATH additions, desktop shortcut, systemd user service, etc.

### 4. Determine the uninstall method

Map the install procedure to one of the supported remove templates:

| Install method | Remove template (if any)                              | Hand-rolled pattern                                       |
|----------------|--------------------------------------------------------|-----------------------------------------------------------|
| `apt`          | `templates/remove_template_apt.sh`                     | —                                                         |
| `debian`       | `templates/remove_template_debian.sh`                  | —                                                         |
| `flatpak`      | `templates/remove_template_flatpak.sh`                | —                                                         |
| `npm`          | `templates/remove_template_npm_global_package.sh`     | —                                                         |
| `snap`         | —                                                      | `sudo snap remove <name>` + desktop shortcut cleanup      |
| `github`       | —                                                      | `rm` of the binary at `${DESTINATION}` and any cloned dir |
| `curl`         | —                                                      | `rm` of the binary dropped by the install script          |
| `oneliner`     | —                                                      | `rm` of the binary dropped by the install script          |
| `git_clone`    | —                                                      | `rm -rf` the clone dir, drop any symlink, revert PATH     |
| `pipx`         | —                                                      | `pipx uninstall <pkg>` + `rm -rf ~/.local/pipx/venvs/<pkg>` |

For methods with a dedicated remove template, use the template as a reference. For the other methods, hand-roll the remove script using the install script's exact `APP_NAME`, `DESTINATION`, binary name, and any directory paths it created.

If the install method is ambiguous or no install script could be located, **ask the user once** with the `question` tool, listing the candidate methods as options.

### 5. Determine the category

The category **must** match the existing install script. Do not invent a new category.

- If a matching `install_<app>.sh` was located, use its parent folder as `CATEGORY` verbatim.
- If the install script does not exist (user opted in step 2 to create a standalone remove script), infer the category from the existing folders in the repo root:
  ```
  ai  android  backups  browser  burning  cli  communication  crypto
  dev  devops  docker  drivers  fonts  games  graphics  ide  kali
  multimedia  network  productivity  security  servers  system  termux
  ```
  Pick the closest match based on the app's purpose. If the user explicitly named a category in the prompt, use that. If the best fit is missing from the list, ask the user once whether to create a new folder or pick from existing ones. When creating a new folder, use `mkdir -p` before writing the script.

### 6. Compose the metadata block

Build an internal metadata record with at least:

- `APP_NAME` — lowercase, single token, used as the file name and the script variable. **Must match** the install script's `APP_NAME`.
- `SHORT_DESCRIPTION` — 1-3 sentences, drawn from the install script's description block.
- `CATEGORY` — folder name from step 5.
- `METHOD` — chosen method from step 4.
- `UPSTREAM_URL` — homepage, repository, or release page (copied from the install script's `@link` annotations when available).
- Method-specific fields, populated from the install script and any upstream fetch:
  - `PACKAGE_NAME` — for npm (`@<author>/<app>` by default).
  - `AUTHOR` — for npm packages, derive from the scope: `@scope/package` → `scope` as `AUTHOR`; for unscoped packages, set `AUTHOR` empty and use `PACKAGE_NAME=<app>`.
  - `PPA` — for apt installs that added a PPA.
  - `KEYRING` / `SOURCES_LIST` — for apt installs that added a keyring or sources list.
  - `DESTINATION` — install path copied from the install script (`/usr/bin`, `/usr/local/bin`, `${HOME}/.local/bin`, `${HOME}/.local/share/${APP_NAME}`, ...).
  - `FLATPAK_ID` — for flatpak installs (e.g. `org.gimp.GIMP`).
  - `SNAP_NAME` — for snap installs (often `${APP_NAME}`).
  - `BINARY` — binary name inside the install destination (defaults to `${APP_NAME}`).
  - `DESKTOP` — desktop shortcut file name (defaults to `${APP_NAME}.desktop`).
  - `STATE_DIRS` — list of `rm -rf` targets: `~/.config/<app>`, `~/.cache/<app>`, `~/.local/share/<app>`, `~/.local/state/<app>`, `~/<dotfile>`, the install destination, etc.

## Template selection (treat as reference, not source of truth)

Read the matching remove template (when one exists) from `templates/`:

| Method       | Remove template                                       |
|--------------|--------------------------------------------------------|
| `apt`        | `templates/remove_template_apt.sh`                     |
| `debian`     | `templates/remove_template_debian.sh`                  |
| `flatpak`    | `templates/remove_template_flatpak.sh`                 |
| `npm`        | `templates/remove_template_npm_global_package.sh`      |

For the other methods, use the existing `remove_*.sh` scripts in the same category as a structural reference. Good starting points:

- `github` / `curl` / `oneliner` style → `ide/remove_jetbrains_toolbox.sh`, `dev/remove_composer.sh`, `dev/remove_uv.sh`
- `snap` style → `ide/remove_visualstudiocode.sh`, `network/remove_postman.sh`
- `git_clone` style → `ide/remove_jetbrains_toolbox.sh` (clone dir + binary + desktop shortcut)
- `pipx` style → none in the repo yet; hand-roll `pipx uninstall` + `~/.local/pipx/venvs` cleanup

**Do not copy the template verbatim.** Treat it as a *reference*:

- Keep the license header, the `CURDIR` bootstrap, the `colors.sh` source line, and the `# shellcheck source=/dev/null` annotation as-is — they are non-negotiable repo conventions.
- Keep the section separators (`#--------------------------------------------------`).
- Drop template-only sections that are not relevant to the target app (e.g. drop the `PPA` removal block for an app installed without a PPA; drop the desktop shortcut block for a headless CLI tool that has no `.desktop` file; drop the keyring/sources-list block for an apt install that used neither).
- **Add** cleanup steps that the install script's body implies but the remove template omits: `rm -rf` of any config / cache / data / state directories, `rm -f` of any dotfiles, undoing `sed`/`printf` edits to `~/.bashrc` / `~/.zshrc`, removing systemd user services (`systemctl --user disable ... && rm ~/.config/systemd/user/<app>.service`), etc. Match the install script's variable names verbatim so the cleanup targets are obvious.
- Use the install script's `_alert_primary "Install ${APP_NAME}"` pattern: the remove script's header is `_alert_danger "Remove ${APP_NAME}"`.
- Use real values (paths, package names, snap names, flatpak ids) **resolved from the install script and any fetch**, not the placeholder strings from the template.

## Execution flow

### 1. Read the prompt

Read `$ARGUMENTS`. Strip leading/trailing whitespace. If empty, ask the user to provide a name, a `category/app_name`, or a URL.

### 2. Locate the matching install script

- Run the search described in step 2 of "Inference flow". If multiple install scripts match, ask the user to pick one.
- If no install script is found, ask the user once whether to (a) create a standalone remove script anyway or (b) abort.

### 3. Read the install script

Use the `read` tool on the located install script. From it, extract:

- `APP_NAME`
- `CATEGORY` (its parent folder)
- The install `METHOD` (apt / debian / flatpak / npm / snap / github / curl / oneliner / git_clone / pipx)
- All `@link` URLs
- The description block (between the `## <name>` line and the `## @category` annotation)
- All paths the install script writes to: `DESTINATION`, share dir, config dir, cache dir, data dir, keyring path, sources list path, systemd unit, desktop shortcut location
- The package name (for apt / debian / flatpak / snap / npm / pipx)

### 4. Fetch the upstream (only when needed)

If any of the uninstall identifiers above are missing from the install script and cannot be inferred, `webfetch` the upstream to fill the gap. Do not fetch otherwise.

### 5. Validate and infer

- Derive `APP_NAME`, `SHORT_DESCRIPTION`, `CATEGORY`, `METHOD`, `UPSTREAM_URL`, and any method-specific fields from the install script (and the upstream fetch when needed).
- Confirm `<category>/remove_<app>.sh` does **not** already exist. If it does, abort without overwriting and tell the user to remove the file first.
- Confirm the corresponding remove template (when one applies) exists on disk.

### 6. Read the relevant remove template (when one applies)

Use the `read` tool on the chosen remove template. Note the structure; you do not need to preserve it verbatim.

For methods without a remove template, also read one or two existing `remove_*.sh` scripts in the same category (or in any category) to align with the house style for the same install method.

### 7. Compose the new file

Generate the remove script content:

- Start with the standard license header (use the current year as in existing scripts, e.g. `Copyright (c) 2026 "Matthias Morin" <mat@tangoman.io>`).
- Replace `## remove template` with `## remove <app_name>` (preserve the upstream's casing in the heading when the install script does, lowercase in the `APP_NAME` variable).
- Replace the description block with a real description copied (lightly rephrased if needed) from the install script.
- Replace `## @category template` with `## @category <category>`. Copy the `@link` annotations verbatim from the install script — they describe the same app, not the uninstaller.
- Fill in `APP_NAME` and any method-specific variables (`PACKAGE_NAME`, `AUTHOR`, `DESTINATION`, `BINARY`, `PPA`, `KEYRING`, `SOURCES_LIST`, `FLATPAK_ID`, `SNAP_NAME`, `DESKTOP`, ...).
- Reuse the install script's `APP_NAME`, `DESTINATION`, and `BINARY` names verbatim so that the remove script is the obvious mirror of the install script.
- Adapt the remove body to the actual install procedure: keep only the template sections that are actually needed and add every cleanup step implied by the install script.
- For hand-rolled methods (`github`, `snap`, `curl`, `oneliner`, `git_clone`, `pipx`):
  - Start with the right tool guard (`command -v snap`, `command -v flatpak`, `command -v pipx`, ...) using the install script's wording as a hint.
  - Remove the binary, the share/config/cache/data directories, and any rc-file fragments the install script added.
  - End with `rm` of the desktop shortcut when one was created.
- Preserve logging style (`_echo_info`, `_echo_warning`, `_echo_danger`, `_alert_danger`) and the `#--------------------------------------------------` separators.
- Preserve quoted variable expansions and the `_echo_info "<command>"` pattern immediately before every `sudo` / install command.

### 8. Write the new file

- Write `<category>/remove_<app>.sh` using the `write` tool.

### 9. Make executable

Print the command first, then run it:

```bash
chmod +x "<category>/remove_<app>.sh"
```

### 10. Lint with shellcheck

Print the command first, then run it:

```bash
shellcheck "<category>/remove_<app>.sh"
```

Surface any warnings or errors verbatim. If shellcheck is not available,
warn the user and point them to `sudo apt-get install -y shellcheck`.

### 11. Confirmation and reminders

Print a final summary:

- Absolute path of the generated file.
- The inferred `APP_NAME`, `CATEGORY`, `METHOD`, and `UPSTREAM_URL`.
- The matching install script that was used as the source of truth.
- Any upstream source(s) that were fetched.
- The list of cleanup targets that were added on top of the remove template.
- Shellcheck result (clean / N warnings / N errors).
- A reminder to:
  - Refine the description block if it was copied verbatim from the install script and could be tighter.
  - Verify any `TODO:` placeholders left for steps that could not be resolved automatically (e.g. shell rc fragments that were not parsed precisely).
  - Manually add the new remove script to the appropriate `recipe_*.sh` if desired.

## Conventions enforced (per `AGENTS.md`)

- `#!/bin/bash` on line 1.
- License header and "TangoMan Provisions package" comment block.
- `CURDIR=$(dirname "$(realpath "${BASH_SOURCE[0]}")")` bootstrap.
- `colors.sh` sourced with `# shellcheck source=/dev/null`.
- `#--------------------------------------------------` section separators.
- `_echo_info "<command>"` echoed immediately before each `sudo` / uninstall command.
- `_alert_danger "Remove <app>"` as the main header (never `_alert_primary`).
- Quoted variable expansions everywhere.
- Mirror the install script's variable names (`APP_NAME`, `DESTINATION`, `BINARY`, `DESKTOP`, ...) so the two scripts read as a pair.

## Idempotency and safety

- Refuse to overwrite an existing `<category>/remove_<app>.sh`. Abort with a clear message; do not delete or modify existing files.
- The command itself only writes files, runs `chmod +x`, and runs `shellcheck`. It does **not** execute the generated remove script and does **not** require `sudo`.
- The generated remove script may invoke `sudo` (intentionally, by design of the templates), but that is only triggered when the user runs the script manually.
- For `apt` and `debian` removes, the generated script does not call `apt-get purge` by default. If the user asks for a "purge" (e.g. to also drop config files under `/etc`), use `sudo apt-get purge -y "${APP_NAME}"` instead of `remove` and mention the change in the final summary.

## Out of scope

- Do **not** auto-add the new remove script to a `recipe_*.sh` file. Leave that to the user, matching the rest of the repo's manual workflow.
- Do **not** auto-generate a `.desktop` file. The install script handles that itself where appropriate, and the remove script only cleans it up.
- Do **not** auto-create tests. The repo's bash_unit tests are not per-script.
- Do **not** silently invent cleanup targets. When in doubt about a path (e.g. an undocumented config directory), leave a `TODO:` placeholder rather than guessing.
