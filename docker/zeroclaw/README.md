# ZeroClaw

Docker-based AI gateway service using Docker Compose.

## Overview

ZeroClaw is a gateway for various AI models. It leverages Docker and Docker Compose to provision and manage the service. Configuration is managed through environment variables.

## Prerequisites

- Docker
- Docker Compose (or Docker CLI with `compose` plugin)

## Quick Start

1. **Prepare environment variables:**
   ```bash
   cp .env.dist .env
   # Edit .env with your API keys and configuration
   ```

2. **Start the service:**
   ```bash
   ./zeroclaw.sh up
   ```

3. **Open gateway in browser:**
   ```bash
   ./zeroclaw.sh open
   ```

4. **View help:**
   ```bash
   ./zeroclaw.sh help
   ```

## Installation (Optional)

Install `zeroclaw.sh` to your system for easier access:
```bash
./zeroclaw.sh self_install
```

## .env Configuration

### Core Settings

|     Variable     |                        Description                        |     Your Value     |
|------------------|-----------------------------------------------------------|--------------------|
| `PROVIDER`       | Default AI provider (openrouter, anthropic, openai, etc.) | `openrouter`       |
| `API_KEY`        | Your API key for the default provider                     | OpenRouter key set |
| `ZEROCLAW_MODEL` | Default model to use                                      | `openrouter/free`  |

### Provider-Specific API Keys

Uncomment and fill in keys for providers you want to use:

- **OpenRouter**: `OPENROUTER_API_KEY` - Get from https://openrouter.ai/settings
- **Anthropic**: `ANTHROPIC_API_KEY` - Get from https://console.anthropic.com/
- **OpenAI**: `OPENAI_API_KEY` - Get from https://platform.openai.com/api-keys
- **Google/Gemini**: `GEMINI_API_KEY` or `GOOGLE_API_KEY`
- **Other providers**: Groq, Mistral, DeepSeek, xAI, Together, Fireworks, Perplexity, Cohere, Moonshot, GLM, Minimax, Qianfan, DashScope, Z.AI, etc.

### Optional Features

- **Web Search**: Enabled by default with DuckDuckGo (no key needed). For Brave Search, get an API key from https://brave.com/search/api and set `BRAVE_API_KEY`
- **Pushover Notifications**: Set `PUSHOVER_TOKEN` and `PUSHOVER_USER_KEY` for push notifications

