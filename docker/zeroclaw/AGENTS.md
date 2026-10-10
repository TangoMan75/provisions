# Project Overview

This directory contains "ZeroClaw", a project that leverages Docker and Docker Compose to provision and manage a service. Based on the `compose.yaml` and `.env.dist` files, this service appears to be a gateway for various AI models, indicated by the presence of `API_KEY`, `PROVIDER`, and numerous AI provider-specific API key placeholders.

The `zeroclaw.sh` script acts as a command-line interface (CLI) to interact with and manage this Docker-based setup. It provides functionalities to streamline the deployment, execution, and maintenance of the ZeroClaw service.

The project utilizes a "TangoMan Shoe Shell Microframework" within `zeroclaw.sh` to provide common shell scripting utilities such as colored output, compatibility functions, Docker Compose command wrappers, and help documentation generation.

# Building and Running

The core of this project is a Docker container orchestrated via `docker compose`. The `zeroclaw.sh` script is the primary entry point for managing the service.

## Prerequisites

- Docker
- Docker Compose (or Docker CLI with `compose` plugin)

## Basic Usage

1.  **Prepare Environment Variables:**
  Copy the `.env.dist` file to `.env` and populate it with your specific API keys and other configuration values.

  ```bash
  cp .env.dist .env
  # Edit .env with your values
  ```

2.  **Start the ZeroClaw Service:**
  Use the `zeroclaw.sh` script to bring up the Docker stack. This will build the image (if not already built), create the container, and start the service.

  ```bash
  ./zeroclaw.sh up
  ```

3.  **Stop the ZeroClaw Service:**

  ```bash
  ./zeroclaw.sh stop
  ```

4.  **Open the Gateway in Browser:**
  This command will attempt to open the configured gateway URL in your default web browser.

  ```bash
  ./zeroclaw.sh open
  ```

5.  **Get Help:**
  To see a list of available commands and their descriptions:

  ```bash
  ./zeroclaw.sh help
  ```

## Installation (Optional)

The `zeroclaw.sh` script can be self-installed to your system for easier access and autocompletion.

1.  **Install the script:**

  ```bash
  ./zeroclaw.sh self_install
  ```

2.  **Uninstall the script:**

  ```bash
  ./zeroclaw.sh self_uninstall
  ```

# Development Conventions

- **Shell Scripting:** The project heavily relies on shell scripts (`.sh` files) for automation and command-line interactions.
- **TangoMan Shoe Shell Microframework:** The `zeroclaw.sh` script is built upon this framework, providing a consistent structure for functions, colored output (`_echo_info`, `_alert_primary`, etc.), and metadata annotations for help generation.
- **Docker-centric:** The application's runtime environment is entirely containerized using Docker and Docker Compose.
- **Environment Configuration:** Environment variables are managed through a `.env` file (derived from `.env.dist`), which is used by `docker compose`.
- **Dependency Checks:** The `zeroclaw.sh` script includes checks to ensure Docker and Docker Compose are installed before executing commands.
- **File Permissions:** The `permissions` function in `zeroclaw.sh` sets the `data` directory to `777` to ensure proper container access.
- **Autocompletion:** The `zeroclaw.sh` script supports generating shell autocompletion for both `bash` and `zsh` shells upon installation.
