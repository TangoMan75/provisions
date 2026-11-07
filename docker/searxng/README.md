# SearXNG Docker Setup

This project provides a Dockerized setup for deploying SearXNG, a private and hackable metasearch engine.
SearXNG aggregates results from various search services and presents them to the user without tracking or profiling.

## Reference

- https://docs.searxng.org
- https://github.com/searxng/searxng

## Project Structure

- `compose.yaml`: Defines the Docker services for SearXNG.
- `Makefile`: Provides convenient commands to manage the SearXNG instance (e.g., start, stop, build).
- `searxng.sh`: A shell script that encapsulates the core logic for managing the SearXNG Docker container.
- `config/`: Contains configuration files for SearXNG.
- `data/`: Stores persistent data for the SearXNG instance.

## Getting Started

Refer to the `Makefile` and `searxng.sh` script for commands to build, start, and manage your SearXNG instance.
This setup is designed to integrate with a Traefik reverse proxy for handling incoming traffic.

## Configuration

- **Enable the JSON output format for SearXNG:**
  - Open `config/settings.yml`
  - Find `formats:` section
  - add `- json` under `- html` format
  - Or use the following `sed` command:
    ```bash
    sed -i '/    - html/a \    - json' config/settings.yml
    ```

```diff
   # remove format to deny access, use lower case.
   # formats: [html, csv, json, rss]
   formats:
     - html
+    - json
```
