# Resque Web Docker Image

Docker container for [Resque](https://github.com/resque/resque) web UI with Redis/Valkey TLS and password support.

> **Note:** This repository is unmaintained and exists only to support legacy projects that require TLS and password authentication features not available in alternative Docker solutions.

## Quick Start

```bash
docker run -d -p 9292:9292 \
  -e REDIS_HOST=your-redis-host \
  -e REDIS_PASSWORD=your-password \
  rapita/resque-web:latest
```

Access at: http://localhost:9292

## Docker Compose

```yaml
services:
  resque-web:
    image: rapita/resque-web:latest
    ports:
      - "9292:9292"
    environment:
      - REDIS_HOST=redis
      - REDIS_PASSWORD=your-password
      - REDIS_NAMESPACE=resque
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `REDIS_HOST` | `127.0.0.1` | Redis/Valkey hostname |
| `REDIS_PORT` | `6379` | Port number |
| `REDIS_DB` | `0` | Database number |
| `REDIS_PASSWORD` | - | Password (optional) |
| `REDIS_NAMESPACE` | `resque` | Redis namespace |
| `REDIS_TLS` | `false` | Enable TLS (set to `true`) |
| `REDIS_SSL_VERIFY` | `true` | Verify SSL certs (set to `false` for self-signed) |

## Examples

**With TLS:**
```bash
docker run -d -p 9292:9292 \
  -e REDIS_HOST=valkey.example.com \
  -e REDIS_PASSWORD=secret \
  -e REDIS_TLS=true \
  rapita/resque-web:latest
```

**Custom namespace:**
```bash
docker run -d -p 9292:9292 \
  -e REDIS_HOST=redis \
  -e REDIS_NAMESPACE=myapp:resque \
  rapita/resque-web:latest
```

## Included Gems

- resque - Core library
- resque-scheduler - Job scheduling
- resque-status - Status tracking
- resque-cleaner - Failed job cleanup
- resque-lock - Duplicate prevention
