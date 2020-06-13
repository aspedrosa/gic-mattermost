ARG ARCH="amd64"
ARG OS="linux"
FROM quay.io/prometheus/busybox-${OS}-${ARCH}:latest
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com>"

ARG ARCH="amd64"
ARG OS="linux"

RUN wget -c "https://github.com/prometheus/snmp_exporter/releases/download/v0.18.0/snmp_exporter-0.18.0.${OS}-${ARCH}.tar.gz" -O - | tar -xz
RUN mv snmp_exporter-0.18.0.${OS}-${ARCH}/snmp_exporter /bin/snmp_exporter

COPY snmp.yml /etc/snmp_exporter/snmp.yml

EXPOSE      9116
ENTRYPOINT  [ "/bin/snmp_exporter" ]
CMD         [ "--config.file=/etc/snmp_exporter/snmp.yml" ]
