# Laya

This directory provides a Docker Compose setup for [Laya](https://github.com/NandhaKishorM/laya), a self-hosted decision-model API, with Traefik reverse proxy integration.

The `laya-serve` image is built from the upstream repository (CPU by default) and exposed on `https://laya.localhost` with TLS.

## Reference

- https://github.com/NandhaKishorM/laya
- https://nandhakishorm.github.io/laya/docker/

## Project Structure

- `compose.yaml`: Defines the `laya` service (build, Traefik labels, healthcheck, model cache).
- `.env.dist`: Environment variable template, copy it to `.env`.

## Prerequisites

- Docker
- Docker Compose
- [Traefik](https://github.com/TangoMan75/traefik) (should be running, with the `traefik` Docker network)

The external `traefik` network must exist before starting:

```bash
docker network create traefik
```

## Getting Started

1. **Prepare environment variables:**
   ```bash
   cp .env.dist .env
   # Edit .env and set LAYA_API_KEY (required): openssl rand -hex 32
   ```

2. **Start the service:**
   ```bash
   docker compose up -d --build --wait
   ```
   The first build installs PyTorch (several minutes), and the first boot downloads the selected checkpoints into the `model-cache` volume. `--wait` returns once `/health` answers.

3. **Check it is up:**
   ```bash
   curl -s https://laya.localhost/health
   ```

## Usage

Every endpoint except `GET /health` requires the bearer token set in `LAYA_API_KEY`.

```bash
curl -s https://laya.localhost/v1/systemone \
  -H "authorization: Bearer ${LAYA_API_KEY}" \
  -H 'content-type: application/json' \
  --data '{
    "state": {"body": "I was charged twice for my subscription. Please refund the duplicate charge."},
    "questions": {
      "department": {
        "type": "choice",
        "instructions": "Which department should handle this request?",
        "criteria": {
          "billing": "invoices, payments, refunds",
          "technical": "bugs, outages, system errors",
          "sales": "pricing, new contracts"
        }
      },
      "urgency": {
        "type": "score",
        "instructions": "How urgent is this request?",
        "criteria": ["not urgent", "needs attention soon", "critical deadline or blocking issue"]
      },
      "refund_requested": {
        "type": "noul",
        "instructions": "Does the user explicitly request a refund?"
      }
    }
  }'
```

Plain HTTP on the loopback entrypoint works too: `http://laya.localhost/health`.

## Configuration

Set values in `.env` (see `.env.dist` for the full annotated list):

| Variable | Default | Description |
|----------|---------|-------------|
| `LAYA_API_KEY` | *(required)* | Bearer token for every request except `/health` |
| `LAYA_MODEL` | `auto` | Router alias: `auto`, `english`, `multilingual`, `typed-decisions` |
| `LAYA_PORT` | `8000` | Port Traefik reaches the service on inside the network |
| `LAYA_DEVICE` | `cpu` | `cpu` or `cuda` (GPU needs the upstream CUDA build args) |
| `LAYA_PRELOAD` | `0` | `1` builds every checkpoint at startup instead of on first request |
| `LAYA_MODELS` | *(all)* | Comma list to preload: `english,multilingual,typed-decisions` |
| `OMP_NUM_THREADS` | `4` | CPU threads, keep at or below physical cores |
| `LAYA_ROOT_PATH` | *(empty)* | URL prefix when published under a sub-path (proxy must strip it) |
| `HF_HUB_OFFLINE` | `0` | `1` uses only already-cached checkpoints |
| `LAYA_TORCH_INDEX` | `cpu` | PyTorch wheel index at build time: `cpu` or `cu130` |
| `LAYA_TORCH_VERSION` | `2.14.0` | Pinned PyTorch version at build time |

Changing `LAYA_TORCH_INDEX` or `LAYA_TORCH_VERSION` requires a rebuild: `docker compose up -d --build`.

## Services

- **laya**: Jev-compatible inference API (`POST /v1/systemone`, `GET /health`).
  - Image: built from `https://github.com/NandhaKishorM/laya.git` as `laya:local`
  - Port: `8000` (internal only, reached through Traefik)
  - Volume: `model-cache` → `/home/laya/.cache/huggingface`
  - Network: `traefik`

## Traefik Integration

- Routes: `https://laya.localhost` (websecure, TLS) and `http://laya.localhost` (web)
- Middlewares: `security@file`, `compression@file`
- Ensure the `traefik` Docker network exists and Traefik is running.

## Data Persistence

Downloaded checkpoints live in the named `model-cache` volume and survive `docker compose down`.

```bash
# Remove the container but keep the weights
docker compose down

# Delete the downloaded weights (next request downloads them again)
docker compose down --volumes
```

## Useful Commands

| Command | Description |
|---------|-------------|
| `docker compose up -d --build --wait` | Build and start, wait for `/health` |
| `docker compose logs -f laya` | Follow the server logs |
| `docker compose stop` | Stop the container |
| `docker compose down` | Stop and remove, keep weights |
| `docker compose down --volumes` | Stop and remove, delete weights |
| `docker compose build --no-cache laya` | Rebuild the image from scratch |

---

For advanced configuration (CUDA, secret files, request files, MCP server), see the [upstream documentation](https://nandhakishorm.github.io/laya/docker/).
