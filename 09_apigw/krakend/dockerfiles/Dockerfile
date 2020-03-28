FROM registry.lab.local/base/centos:7.7.1908

LABEL maintainer="-veldrane"

RUN yum update -y && \
	yum install -y ca-certificates && \
	update-ca-trust && \
        useradd -u 998 -r -c "KrakenD user" -U krakend

ADD krakend /usr/bin/krakend

USER krakend

ENTRYPOINT [ "/usr/bin/krakend" ]
CMD [ "run", "-c", "/etc/krakend/krakend.json" ]

EXPOSE 8000 8090
