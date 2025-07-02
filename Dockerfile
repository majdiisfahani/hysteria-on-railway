FROM alpine:latest

RUN apk add --no-cache curl

RUN curl -Lo /usr/local/bin/hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 \
    && chmod +x /usr/local/bin/hysteria

COPY config.yaml /etc/hysteria/config.yaml
COPY hysteria/hysteria.crt /etc/hysteria/hysteria.crt
COPY hysteria/hysteria.key /etc/hysteria/hysteria.key

EXPOSE 443

CMD ["hysteria", "server", "-c", "/etc/hysteria/config.yaml"]
