#!/bin/sh

git clone https://github.com/mattermost/mattermost-load-test

cp Dockerfile mattermost-load-test
cp loadtestconfig.json mattermost-load-test

docker build -t 10.2.0.1:5000/mattermost-tests mattermost-load-test
docker push 10.2.0.1:5000/mattermost-tests
