#!/bin/sh

set -x

previous_docker_host=$DOCKER_HOST

export DOCKER_HOST="tcp://10.2.0.1:2375"

docker build -t 10.2.0.1:5000/mattermost-84921-85098-web .

docker publish 10.2.0.1:5000/mattermost-84921-85098-web

export DOCKER_HOST=$previous_docker_host
