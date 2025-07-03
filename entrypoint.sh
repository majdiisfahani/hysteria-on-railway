#!/bin/sh

# اجرای mini_httpd روی پورت 80 برای اینکه Render سرویس رو live تشخیص بده
mini_httpd -d /var/www/localhost/htdocs -p 80 &

# اجرای Hysteria در حالت foreground
exec hysteria server -c /etc/hysteria/config.yaml
