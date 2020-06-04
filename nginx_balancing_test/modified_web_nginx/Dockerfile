FROM nginx:mainline-alpine

# Remove default configuration and add our custom Nginx configuration files
RUN rm /etc/nginx/conf.d/default.conf \
    && apk add --no-cache curl wget tar

RUN wget -c https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.7.0/nginx-prometheus-exporter-0.7.0-linux-amd64.tar.gz -O - | tar -xz

COPY ["./mattermost", "./mattermost-ssl", "/etc/nginx/sites-available/"]
COPY ./security.conf /etc/nginx/conf.d/

# Add and setup entrypoint
COPY entrypoint.sh /

#Healthcheck to make sure container is ready
HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1

ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/var/run", "/etc/nginx/conf.d/", "/var/cache/nginx/"]

