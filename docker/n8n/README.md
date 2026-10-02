# n8n Companion

This project provides a convenient way to run an n8n instance using Docker and Docker Compose.
It includes a `compose.yaml` file that defines the n8n service, as well as a `Makefile` and a shell script for managing the application.

This configuration uses [Traefik](https://traefik.io/traefik/) as a reverse proxy to expose n8n on `https://n8n.localhost`.

## What is n8n?

n8n is an extendable workflow automation tool.
With a fair-code license, n8n will always have visible source code, be available to host on-prem, and allow you to add your own custom functions, logic and apps. Its node-based approach makes it highly versatile, enabling you to connect anything to everything.

## Prerequisites

- Docker
- Docker Compose
- [Traefik](https://github.com/TangoMan75/traefik) (should be running)

## Getting Started

1.  **Clone the repository:**
  ```bash
  git clone https://github.com/TangoMan75/n8n-companion.git
  cd n8n-companion
  ```

2.  **Start the application:**
  ```bash
  make up
  ```

3.  **Open n8n:**
    Open your browser and navigate to `https://n8n.localhost`.

## Available Commands

The `Makefile` provides a set of commands to manage the application:

|        Command        |                     Description                      |
|-----------------------|------------------------------------------------------|
| `make up`             | Builds and starts the n8n and PostgreSQL containers. |
| `make start`          | Starts the containers.                               |
| `make stop`           | Stops the containers.                                |
| `make open`           | Opens the n8n instance in a web browser.             |
| `make help`           | Displays a list of all available commands.           |
| `make self_install`   | Install n8n companion and enable autocompletion.     |
| `make self_uninstall` | Uninstall n8n companion from system.                 |

## Services

The `compose.yaml` file defines the following service:

- **n8n**: The n8n workflow automation tool.
  - Image: `n8nio/n8n:latest`
  - Ports: `5678:5678`
  - Volumes: `./n8n_data:/home/node/.n8n`
  - Networks: `traefik`

## Official Documentation

- [n8n.io](https://n8n.io/workflows)
- [n8n on GitHub](https://github.com/n8n-io/n8n)
- [n8n Docker Installation](https://docs.n8n.io/hosting/installation/docker/)
- [n8n Docker Image](https://hub.docker.com/r/n8nio/n8n)
