FROM debian:wheezy
MAINTAINER Marius Bergmann <marius@yeai.de>

ADD assets/config/apt/no-recommends-or-suggests /etc/apt/apt.conf.d/

RUN apt-get update \
    && apt-get install -y rsyslog supervisor \
    && rm -rf /var/lib/apt/lists/*
