FROM nginx:1.12.0

COPY ["./nginx-conf/nginx.conf", "/etc/nginx/conf.d/default.conf"]
COPY ["./index.html", "/var/www/html/index.html"]

# RUN which nginx
RUN /usr/sbin/nginx -t

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]