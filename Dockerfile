FROM debian

MAINTAINER Ganesha <reekoheek@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV APT_PROXY http://192.168.1.10:3128

RUN \
  echo "\n\
Acquire::HTTP::Proxy \"$APT_PROXY\";\n\
Acquire::HTTPS::Proxy \"$APT_PROXY\";\n\
" > /etc/apt/apt.conf.d/01proxy && \
 echo " \n\
deb http://kambing.ui.ac.id/debian/ jessie main\n\
deb http://kambing.ui.ac.id/debian/ jessie-updates main\n\
deb http://kambing.ui.ac.id/debian-security/ jessie/updates main\n\
" > /etc/apt/sources.list && \
# apt-get -o Acquire::Check-Valid-Until=false update -y
  apt-get update -y

RUN apt-get install -y \
  haproxy

COPY haproxy.cfg /etc/haproxy/haproxy.cfg
COPY errors/ /etc/haproxy/errors/

RUN apt-get install -y vim net-tools

CMD ["/usr/sbin/haproxy", "-f", "/etc/haproxy/haproxy.cfg"]

# /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -D -p /var/run/haproxy.pid

