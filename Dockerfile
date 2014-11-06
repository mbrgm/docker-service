FROM debian:wheezy
MAINTAINER Marius Bergmann <marius@yeai.de>

RUN apt-get update \
    && apt-get install -y --no-install-recommends rsyslog supervisor \
    && apt-get clean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
