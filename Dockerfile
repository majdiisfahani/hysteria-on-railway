FROM ghcr.io/apernet/hysteria:latest
COPY config.yaml /etc/hysteria/config.yaml
CMD ["server", "-c", "/etc/hysteria/config.yaml"]
