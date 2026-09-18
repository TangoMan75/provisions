# ConvertX

Self-hosted online file converter supporting 700+ formats.

- https://github.com/C4illin/ConvertX
- https://convertx.c4illin.cc
- https://ghcr.io/c4illin/convertx

## Usage

Start the container:

```bash
./convertx.sh up
```

or directly with Docker Compose:

```bash
docker compose up -d
```

Access the web interface:

- HTTP: http://convertx.localhost
- HTTPS: https://convertx.localhost
- Direct: http://localhost:3444

The first time you open the application, create an account (unless
`ALLOW_UNAUTHENTICATED` is set to `true`).

## Configuration

Copy the environment file and edit the values:

```bash
cp .env.dist .env
```

| Variable | Description |
|----------|-------------|
| `convertx_port` | Host port bound to the container (default `3444`) |
| `ACCOUNT_REGISTRATION` | Allow new users to register (default `false`) |
| `JWT_SECRET` | Long random secret used to sign sessions (required) |
| `HTTP_ALLOWED` | Allow plain HTTP access, required behind Traefik (default `true`) |
| `ALLOW_UNAUTHENTICATED` | Allow using the service without logging in, only for local use |
| `AUTO_DELETE_EVERY_N_HOURS` | Delete converted files after N hours (default `24`) |

The container uses Traefik for routing. Access is available via HTTP/HTTPS on `convertx.localhost`.

## Volumes

- `./data`: Application data and converted files (`/app/data`)

If the container fails to start because of permissions on `./data`, fix the
ownership with your own uid/gid (find them with `id`):

```bash
sudo chown 1000:1000 ./data -R
docker restart convertx
```

## Troubleshooting

View logs:

```bash
docker logs convertx
```

Restart the container:

```bash
docker compose restart convertx
```
