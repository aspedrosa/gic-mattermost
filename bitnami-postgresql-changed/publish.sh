#!/bin/sh

set -x

previous_docker_host=$DOCKER_HOST

export DOCKER_HOST="tcp://10.2.0.1:2375"

docker build -t 10.2.0.1:5000/postgresql-repmgr-mattermost .

docker push 10.2.0.1:5000/postgresql-repmgr-mattermost

export DOCKER_HOST=$previous_docker_host
