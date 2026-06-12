# nsd-alpine

Alpine-based Docker image for NLnetLabs NSD authoritative DNS server.

## Why alpine:3.24

NSD 4.12+ introduced native Prometheus metrics. The image was previously on
`alpine:edge` because stable lagged at NSD 4.13.x. Alpine 3.24 now ships NSD
4.14.x, so the image pins to `alpine:3.24` (minor tag — patch rebuilds pick up
security/NSD fixes within 3.24, without auto-jumping to 3.25).

There is no longer a scheduled rebuild cron. CI builds on push to `main` and can
be rebuilt on demand via the `workflow_dispatch` trigger to pick up upstream
package updates.

## Image published to

`ghcr.io/tsarna/nsd-alpine` on GHCR. Tags track the NSD version contained in the
image (rolling, like official Docker images), built on push to `main`:

- `latest`
- `4`, `4.14`, `4.14.2` — NSD major / minor / full version
- `4.14.2-alpine3.24` — NSD + Alpine, fully qualified

## Usage in kubical-gitops

Referenced in `clusters/awusoh02/nsd/values.yaml` as the NSD DaemonSet image.
NSD config is mounted from a ConfigMap at `/etc/nsd/`. nsd.conf must include
`username: ""` so NSD does not attempt a privilege drop (container already
runs as the `nsd` user set by the Alpine package).

## nsd-control

`nsd-control` is included in Alpine's `nsd` package. The `nsd-reload` sidecar
in kubical-gitops uses it to reload `dyn.sarna.org` from EFS every 30 seconds.

## Updating the NSD version tag in kubical-gitops

After a new version is built and pushed, update `image.tag` in
`clusters/awusoh02/nsd/values.yaml` if pinning to a specific version.
With `latest`, Reloader will restart the DaemonSet on each image push.
