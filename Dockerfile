FROM alpine:latest
COPY config.yaml /etc/hysteria/config.yaml
CMD ["server", "-c", "/etc/hysteria/config.yaml"]
