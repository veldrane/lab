FROM registry.lab.local/base/centos:7.7.1908

LABEL maintainer="-veldrane"

RUN yum update -y && \
        useradd -u 999 -r -c "simpleapi user" -U simpleapi

ADD simpleapi /simpleapi

USER simpleapi

ENTRYPOINT [ "/simpleapi" ]

EXPOSE 8080
