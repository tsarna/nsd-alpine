FROM alpine:3.23

RUN apk add --no-cache nsd

# Alpine's nsd package creates user/group nsd. Recreate with explicit numeric
# UID/GID 993 so Kubernetes runAsNonRoot can verify the user is non-root.
# NSD is started as this user directly (no setuid), so nsd.conf should have
# username: "" to skip the privilege-drop attempt.
RUN deluser nsd 2>/dev/null || true && \
    delgroup nsd 2>/dev/null || true && \
    addgroup -S -g 993 nsd && \
    adduser -S -u 993 -G nsd -H -s /sbin/nologin nsd

EXPOSE 53/tcp 53/udp

USER 993

ENTRYPOINT ["/usr/sbin/nsd", "-d", "-c", "/etc/nsd/nsd.conf"]
