#!/bin/sh

# Define default value for app container hostname and port
APP_HOST=${APP_HOST:-app}
APP_PORT_NUMBER=${APP_PORT_NUMBER:-8000}

# Check if SSL should be enabled (if certificates exists)
if [ -f "/cert/cert.pem" -a -f "/cert/key-no-password.pem" ]; then
  echo "found certificate and key, linking ssl config"
  ssl="-ssl"
else
  echo "linking plain config"
fi
# Linking Nginx configuration file
ln -s /etc/nginx/sites-available/mattermost$ssl /etc/nginx/conf.d/mattermost.conf

# Setup app host and port on configuration file
sed -i "s/{%APP_HOST_1%}/${APP_HOST_1}/g" /etc/nginx/conf.d/mattermost.conf
sed -i "s/{%APP_PORT_1%}/${APP_PORT_1}/g" /etc/nginx/conf.d/mattermost.conf

sed -i "s/{%APP_HOST_2%}/${APP_HOST_2}/g" /etc/nginx/conf.d/mattermost.conf
sed -i "s/{%APP_PORT_2%}/${APP_PORT_2}/g" /etc/nginx/conf.d/mattermost.conf

sed -i "s/{%APP_HOST_3%}/${APP_HOST_3}/g" /etc/nginx/conf.d/mattermost.conf
sed -i "s/{%APP_PORT_3%}/${APP_PORT_3}/g" /etc/nginx/conf.d/mattermost.conf


cleanup() {
    curl ${SNMP_MANAGER_HOST}:${SNMP_MANAGER_PORT}/detach
}

#Trap SIGTERM
trap 'true' TERM QUIT

# Run Nginx
openresty -g 'daemon off;' &

curl ${SNMP_MANAGER_HOST}:${SNMP_MANAGER_PORT}/attach

#Wait
wait $!

#Cleanup
cleanup
