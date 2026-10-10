# MinIO

This directory provides a ready-to-use MinIO S3-compatible object storage setup using Docker Compose, with Traefik reverse proxy integration.

## Features
- MinIO server with persistent storage (`./data`)
- Traefik labels for S3 API and web console (HTTP/HTTPS)
- Easily configurable via environment variables
- Includes `minio.sh` helper script

## Usage

1. **Set environment variables (optional):**
   - `MINIO_ROOT_USER` (default: `minio`)
   - `MINIO_ROOT_PASSWORD` (default: `minio123`)
   - `MINIO_SERVER_URL` (default: `http://localhost:9000`)

2. **Start MinIO with Docker Compose:**
   ```sh
   docker compose up -d
   ```

3. **Access MinIO:**
   - S3 API: [http://localhost:9000](http://localhost:9000)
   - Console: [http://localhost:9001](http://localhost:9001)
   - With Traefik: [https://s3.minio.localhost](https://s3.minio.localhost), [https://minio.localhost](https://minio.localhost)

4. **Stop MinIO:**
   ```sh
   docker compose down
   ```

## Traefik Integration
- The `compose.yaml` includes Traefik labels for secure routing.
- Ensure the `traefik` Docker network exists and Traefik is running.

## Helper Script
- `minio.sh`: Utility script for MinIO management (see script for details).

## Data Persistence
- Data is stored in the `./data` directory (mounted to `/data` in the container).

---
For advanced configuration, see the official [MinIO documentation](https://min.io/docs/minio/linux/index.html).
