---
description: Scaffold a new remove_*.sh script by reading its matching install_*.sh, picking the right remove template, and adding cleanup steps for config/cache/desktop files
agent: build
---

# Create Remove Script

Scaffolds `remove_<app>.sh` for the TangoMan Provisions package by locating the matching `install_<app>.sh`, inferring the install method, metadata, and category, then picking the appropriate remove template and adding cleanup steps for any leftover state (config, cache, data directories, desktop shortcuts).

It reads the install script as the source of truth, adapts the remove template (or hand-rolls for methods without one), writes the file, `chmod +x`, and lints with `shellcheck`. It refuses to overwrite existing files and never runs the generated script.

Invoke the `create_remove_script` skill with the user's request: $ARGUMENTS
