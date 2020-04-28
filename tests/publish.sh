#!/bin/sh

set -x

git clone https://github.com/mattermost/mattermost-load-test

cp Dockerfile mattermost-load-test
cp loadtestconfig.json mattermost-load-test

previous_docker_host=$DOCKER_HOST

export DOCKER_HOST="tcp://10.2.0.1:2375"

docker build -t 10.2.0.1:5000/mattermost-tests mattermost-load-test
docker push 10.2.0.1:5000/mattermost-tests

export DOCKER_HOST=$previous_docker_host
