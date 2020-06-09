FROM openresty/openresty:1.15.8.3-2-buster-fat-nosse42

# Remove default configuration and add our custom Nginx configuration files
RUN apt-get update &&  apt-get install -y curl wget tar && rm -rf /var/lib/apt/lists/*

RUN wget -c https://github.com/nginxinc/nginx-prometheus-exporter/releases/download/v0.7.0/nginx-prometheus-exporter-0.7.0-linux-amd64.tar.gz -O - | tar -xz

RUN opm get knyar/nginx-lua-prometheus
ENV LUA_PATH=/usr/local/openresty/site/lualib

COPY nginx.conf /usr/local/openresty/nginx/conf
COPY ["./mattermost", "./mattermost-ssl", "/etc/nginx/sites-available/"]
COPY ./security.conf /etc/nginx/conf.d/
RUN rm /etc/nginx/conf.d/default.conf

# Add and setup entrypoint
COPY entrypoint.sh /

#Healthcheck to make sure container is ready
HEALTHCHECK CMD curl --fail http://localhost:80 || exit 1

ENTRYPOINT ["/entrypoint.sh"]

VOLUME ["/var/run", "/etc/nginx/conf.d/", "/var/cache/nginx/"]

