# nsd-alpine

Alpine edge-based Docker image for NLnetLabs NSD authoritative DNS server.

## Why alpine:edge

NSD 4.12+ introduced native Prometheus metrics. Alpine stable (3.21) ships
NSD 4.11.x; only edge has 4.14.x. The weekly rebuild cron picks up NSD
updates automatically.

## Image published to

`tsarna/nsd-alpine` on Docker Hub — tag: `latest`

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
