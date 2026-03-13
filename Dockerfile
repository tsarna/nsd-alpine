FROM alpine:edge

# Alpine edge has NSD 4.14.x which includes native Prometheus metrics support
# (introduced in NSD 4.12). nsd-control is included in the nsd package.
RUN apk add --no-cache nsd

# Alpine's nsd package creates user/group nsd. NSD is started as this user
# directly (no setuid), so nsd.conf should have username: "" to skip the
# privilege-drop attempt.

EXPOSE 53/tcp 53/udp

USER nsd

ENTRYPOINT ["/usr/sbin/nsd", "-d", "-c", "/etc/nsd/nsd.conf"]
