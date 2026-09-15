---
description: Scaffold a new install_*.sh script (and matching remove_*.sh when a template exists) from a single free-form prompt
agent: build
---

# Create Install Script

Scaffolds `install_<app>.sh` (and, when a template exists, a matching `remove_<app>.sh`) for the TangoMan Provisions package from a single free-form prompt — a bare app name, a docs/GitHub URL, an npm package, or a mixed description.

It infers the right template, app metadata, and category, fetches upstream docs when needed, adapts the template to the real install procedure, writes the file(s), `chmod +x`, and lints with `shellcheck`. It refuses to overwrite existing files and never runs the generated script.

Invoke the `create_install_script` skill with the user's request: $ARGUMENTS
