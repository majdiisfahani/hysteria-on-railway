FROM alpine:latest

# نصب ابزارهای لازم
RUN apk add --no-cache curl mini_httpd

# دریافت باینری hysteria
RUN curl -Lo /usr/local/bin/hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64 \
    && chmod +x /usr/local/bin/hysteria

# کپی فایل‌های پیکربندی
COPY config.yaml /etc/hysteria/config.yaml
COPY hysteria/hysteria.crt /etc/hysteria/hysteria.crt
COPY hysteria/hysteria.key /etc/hysteria/hysteria.key

# فقط برای باز بودن پورت‌ها (Render نیاز دارد یکی از پورت‌های 80 یا 443 دیده شود)
COPY htdocs /var/www/localhost/htdocs

# پورت‌های لازم
EXPOSE 80
EXPOSE 443/udp

# اجرای همزمان HTTP dummy و hysteria با یک اسکریپت
CMD sh -c "mini_httpd -d /var/www/localhost/htdocs -p 80 & hysteria server -c /etc/hysteria/config.yaml"
