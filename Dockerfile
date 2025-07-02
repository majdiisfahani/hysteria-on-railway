FROM alpine:latest

# نصب ابزارهای موردنیاز
RUN apk add --no-cache curl socat

# دریافت Hysteria
RUN curl -Lo /usr/local/bin/hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 \
    && chmod +x /usr/local/bin/hysteria

# کپی فایل‌های پیکربندی و TLS
COPY config.yaml /etc/hysteria/config.yaml
COPY hysteria/hysteria.crt /etc/hysteria/hysteria.crt
COPY hysteria/hysteria.key /etc/hysteria/hysteria.key

# اعلام پورت‌ها (فقط برای اطلاع Render، نه الزامی)
EXPOSE 443
EXPOSE 80

# اجرای هم‌زمان socat و Hysteria
CMD socat TCP-LISTEN:80,fork EXEC:"echo OK" & hysteria server -c /etc/hysteria/config.yaml
