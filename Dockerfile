# Dockerfile (custom-ngnix)
FROM nginx:latest

# Copy login page to NGINX html directory
COPY index.html  /usr/share/nginx/html/index.html


COPY default.conf /etc/nginx/conf.d/default.conf
