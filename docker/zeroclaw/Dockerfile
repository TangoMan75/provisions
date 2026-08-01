# ZeroClaw Dockerfile
# Base image: Ubuntu Latest

FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV ZEROCLAW_VERSION=v0.1.7
ENV ZEROCLAW_GATEWAY_PORT=42617

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "https://github.com/zeroclaw-labs/zeroclaw/releases/download/${ZEROCLAW_VERSION}/zeroclaw-x86_64-unknown-linux-gnu.tar.gz" -o /tmp/zeroclaw.tar.gz \
    && tar -xzf /tmp/zeroclaw.tar.gz -C /tmp \
    && mv /tmp/zeroclaw /usr/local/bin/zeroclaw \
    && chmod +x /usr/local/bin/zeroclaw \
    && rm -rf /tmp/zeroclaw.tar.gz /tmp/zeroclaw

RUN mkdir -p /zeroclaw-data/workspace /zeroclaw-data/.zeroclaw

RUN printf '[provider]\napi_key = ""\ndefault_provider = "openrouter"\ndefault_model = "openrouter/free"\ndefault_temperature = 0.7\n\n[gateway]\nport = %s\nhost = "[::]"\nallow_public_bind = true\n' "${ZEROCLAW_GATEWAY_PORT}" > /zeroclaw-data/.zeroclaw/config.toml

WORKDIR /zeroclaw-data

EXPOSE ${ZEROCLAW_GATEWAY_PORT}

HEALTHCHECK --interval=60s --timeout=10s --start-period=10s --retries=3 \
    CMD zeroclaw status

ENTRYPOINT ["zeroclaw"]
CMD ["gateway", "--host", "0.0.0.0"]
