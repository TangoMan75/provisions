# Neko

Browser in a Docker container with remote desktop.

- https://github.com/m1k1o/neko
- https://hub.docker.com/r/m1k1o/neko

## Usage

Start the container:

```bash
docker compose up -d
```

Access the web interface:

- HTTP: http://neko.localhost
- HTTPS: https://neko.localhost

Default credentials:

- Username: neko
- Password: neko
- Admin password: admin

## Configuration

Environment variables:

| Variable | Description |
|----------|-------------|
| `NEKO_PASSWORD` | User password |
| `NEKO_PASSWORD_ADMIN` | Admin password |
| `NEKO_EPR` | WebRTC EPR port range (UDP) |

The container uses Traefik for routing. Access is available via HTTP/HTTPS on `neko.localhost`.

### Ports

| Port | Protocol | Description |
|------|----------|-------------|
| 52000-52100 | UDP | WebRTC media ports |

The HTTP port (8080) is not exposed to the host since Traefik handles routing.

## Volumes

- `./data`: Downloads directory (`/home/neko/Downloads`)
- `./config`: Configuration files (`/etc/neko`)

## Troubleshooting

View logs:

```bash
docker logs neko
```

Restart the container:

```bash
docker compose restart neko
```
