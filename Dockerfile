FROM alpine:latest

RUN apk add --no-cache curl busybox-extras

RUN curl -Lo /usr/local/bin/hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 \
    && chmod +x /usr/local/bin/hysteria

COPY config.yaml /etc/hysteria/config.yaml
COPY hysteria/hysteria.crt /etc/hysteria/hysteria.crt
COPY hysteria/hysteria.key /etc/hysteria/hysteria.key

EXPOSE 443
EXPOSE 80

CMD busybox httpd -f -p 80 & \
    hysteria server -c /etc/hysteria/config.yaml
