FROM debian:wheezy
MAINTAINER Marius Bergmann <marius@yeai.de>

ADD assets/config/apt/no-recommends-or-suggests /etc/apt/apt.conf.d/

ADD assets/config/apt/rsyslog.pgp /tmp/rsyslog.pgp
ADD assets/config/apt/rsyslog.list /etc/apt/sources.list.d/
RUN apt-key add /tmp/rsyslog.pgp \
    && rm /tmp/rsyslog.pgp

RUN apt-get update \
    && apt-get install -y rsyslog supervisor \
    && rm -rf /var/lib/apt/lists/*

# Add supervisor config
ADD assets/config/supervisor/supervisord-global.conf \
    /etc/supervisor/supervisord.conf
ADD assets/config/supervisor/rsyslog.conf /etc/supervisor/conf.d/

# Add rsyslog config
ADD assets/config/rsyslog/rsyslog-global.conf /etc/rsyslog.conf
ADD assets/config/rsyslog/rsyslog.conf /etc/rsyslog.d/
ADD assets/config/rsyslog/supervisor.conf /etc/rsyslog.d/

# Add init script
ADD assets/init /app/init
RUN chmod 700 /app/init

VOLUME ["/data"]
