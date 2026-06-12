# nsd-alpine

Alpine-based Docker image for the [NLnetLabs NSD](https://www.nlnetlabs.nl/projects/nsd/)
authoritative DNS server.

Built from `alpine:3.24` (NSD 4.14.x, with native Prometheus metrics) for
`linux/amd64` and `linux/arm64`. NSD runs directly as a non-root user
(UID/GID 993), so `nsd.conf` should set `username: ""` to skip the privilege
drop. Config is expected at `/etc/nsd/nsd.conf`.

## Image

`ghcr.io/tsarna/nsd-alpine`

Tags track the NSD version contained in the image:

| Tag | Meaning |
| --- | --- |
| `latest` | Latest build from `main` |
| `4`, `4.14`, `4.14.2` | NSD major / minor / full version |
| `4.14.2-alpine3.24` | NSD + Alpine, fully qualified |

## Usage

```sh
docker run --rm -p 53:53/udp -p 53:53/tcp \
  -v "$PWD/nsd.conf:/etc/nsd/nsd.conf:ro" \
  ghcr.io/tsarna/nsd-alpine:latest
```
