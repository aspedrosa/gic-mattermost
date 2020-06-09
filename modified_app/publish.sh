#!/bin/sh

set -x

previous_docker_host=$DOCKER_HOST

export DOCKER_HOST="tcp://10.2.0.1:2375"

docker build -t 10.2.0.1:5000/mattermost-84921-85098-app .

docker push 10.2.0.1:5000/mattermost-84921-85098-app

export DOCKER_HOST=$previous_docker_host
