FROM golang:1.14.2-stretch

RUN apt update \
    && apt -y install \
      vim \
      curl \
      jq \
      netcat \
      net-tools \
      iproute2 \
      dnsutils \
      graphviz


RUN go get github.com/mattermost/mattermost-load-test/cmd/loadtest && \
    go get github.com/mattermost/mattermost-load-test/cmd/ltparse


WORKDIR /app

COPY loadtestconfig.json /app

COPY testfiles /app/testfiles


CMD ["tail", "-f", "/dev/null"]
