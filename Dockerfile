# Service image
#
# VERSION 0.2.0

FROM debian:wheezy
MAINTAINER Marius Bergmann <marius@yeai.de>

ADD assets/apt/no-recommends-or-suggests /etc/apt/apt.conf.d/

RUN apt-get update \
    && apt-get install -y runit \
    && rm -rf /var/lib/apt/lists/*

ADD assets/runit/ /etc/runit
ADD assets/service_init /usr/local/sbin/service_init

RUN chmod -R +x /etc/runit/1 /etc/runit/2 /etc/runit/3 \
                /etc/runit/1.d/ /etc/runit/3.d/ \
    && chmod +x /usr/local/sbin/service_init

ENTRYPOINT ["/usr/local/sbin/service_init"]
