# Tutorials

[Swarmprom - Prometheus Monitoring for Docker Swarm](https://www.weave.works/blog/swarmprom-prometheus-monitoring-for-docker-swarm)

# Prometheus
[Repo](https://github.com/prometheus/prometheus)

# Exporters

## nginx
[nginx-prometheus-exporter](https://github.com/nginxinc/nginx-prometheus-exporter)

1. actvivate [stub-status](https://nginx.org/en/docs/http/ngx_http_stub_status_module.html#stub_status)

2. download [exporter binary](https://github.com/nginxinc/nginx-prometheus-exporter/releases) on nginx dockerfile
using [wget](https://www.tecmint.com/download-and-extract-tar-files-with-one-command/) (`wget -c https://....tar.gz -O - | tar -xz`)

3. launch in background on `entrypoint.sh` (`./nginx-prometheus-exporter -nginx.scrape-uri http://localhost:80/stub_status &`)

## snmp
[snmp_exporter](https://github.com/prometheus/snmp_exporter)