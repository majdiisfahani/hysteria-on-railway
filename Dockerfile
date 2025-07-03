FROM alpine:latest

RUN apk add --no-cache curl mini_httpd

RUN curl -Lo /usr/local/bin/hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 \
    && chmod +x /usr/local/bin/hysteria

COPY config.yaml /etc/hysteria/config.yaml
COPY hysteria/hysteria.crt /etc/hysteria/hysteria.crt
COPY hysteria/hysteria.key /etc/hysteria/hysteria.key
COPY htdocs /var/www/localhost/htdocs

EXPOSE 443
EXPOSE 80

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
