FROM debian:wheezy
MAINTAINER Marius Bergmann <marius@yeai.de>

ADD assets/config/apt/no-recommends-or-suggests /etc/apt/apt.conf.d/

RUN apt-get update \
    && apt-get install -y rsyslog supervisor \
    && rm -rf /var/lib/apt/lists/*


# Fix rsyslog xconsole bug. This will comment out the lines following the
# xconsole explanation until the line containing |/dev/xconsole
RUN awk '/^# +\$ xconsole/,/\|\/dev\/xconsole/ { if($1 !~ /^#/) $0="#"$0}{print}' \
        /etc/rsyslog.conf > /etc/rsyslog.conf.tmp \
    && mv /etc/rsyslog.conf.tmp /etc/rsyslog.conf \
    # Disable kernel logging
    && sed -i 's/$ModLoad imklog/#$ModLoad imklog/' /etc/rsyslog.conf

# Add rsyslog supervisor config file
ADD assets/config/supervisor/rsyslog.conf /etc/supervisor/conf.d/
