#
# Postil: Dockerfile for building CentOS images
#

FROM            docker.io/centos:latest
MAINTAINER      Renyf <renyongfanemail@sina.com>

ENV TZ "Asia/Shanghai"
ENV TERM xterm

ADD aliyun-mirror.repo /etc/yum.repos.d/CentOS-Base.repo
ADD aliyun-epel.repo /etc/yum.repos.d/epel.repo

RUN yum -y install epel* && \
    yum -y install curl wget tar bzip2 unzip vim-enhanced passwd sudo yum-utils hostname net-tools rsync man systemd systemd-libs && \
    yum -y install gcc gcc-c++ git make automake cmake patch logrotate python-devel libpng-devel libjpeg-devel && \
    yum -y install supervisor && \
    yum clean all

ADD supervisord.conf /etc/supervisord.conf

RUN mkdir -p /etc/supervisor.conf.d && \
    mkdir -p /var/log/supervisor

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
