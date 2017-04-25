#
# Postil: Dockerfile for building redis images
#

FROM            docker.io/centos:latest
MAINTAINER      Renyf <renyongfanemail@sina.com>

ENV REDIS_PASS yes
ENV REDIS_DIR /data

RUN yum -y install epel-release && \
    yum -y install redis pwgen && \
    yum clean all

ADD scripts /scripts
RUN chmod +x /scripts/*.sh

VOLUME ["/data"]

CMD ["/scripts/run.sh"]
