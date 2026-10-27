# Project Overview

This project provides a Dockerized setup for deploying SearXNG, a private and hackable metasearch engine.
It uses Docker Compose to define the `searxng` service and a `Makefile` and a `searxng.sh` script to manage its lifecycle.
The setup is designed to work with a Traefik reverse proxy for handling HTTP/HTTPS traffic.

The directory is structured to separate concerns:
- `compose.yaml`: Defines the Docker services.
- `searxng.sh`: Contains the core logic for starting, stopping, and managing the SearXNG instance.
- `config/`: Holds the SearXNG configuration files.
- `data/`: Stores persistent data for the SearXNG instance.

# Building and Running

The primary way to interact with this project is through the `Makefile` or the `searxng.sh` script.

## Using Shell Script

The `searxng.sh` script provides the same commands:

- **Start the service:**
  ```bash
  ./searxng.sh up
  ```

- **Start the Docker container:**
  ```bash
  ./searxng.sh start
  ```

- **Stop the Docker container:**
  ```bash
  ./searxng.sh stop
  ```

# Development Conventions

- **Management:** The project is managed via `make` and a custom shell script (`searxng.sh`), which is a common pattern for Dockerized applications to simplify `docker-compose` commands.
- **Configuration:** SearXNG is configured via files in the `./config` directory, which are mounted into the container.
- **Networking:** The `compose.yaml` is configured to use an external Traefik network, indicating it's part of a larger Docker setup managed by Traefik.
- **Self-Installation:** The `searxng.sh` script includes `self_install` and `self_uninstall` commands, allowing the script to be installed on the system for easier access.
