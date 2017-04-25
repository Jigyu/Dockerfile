#
# Postil: Dockerfile for building mongodb images
#

FROM            docker.io/centos:latest
MAINTAINER      Renyf <renyongfanemail@sina.com>

ENV AUTH yes
ENV JOURNALING yes

RUN yum -y install epel-release && \
    yum -y install pwgen mongodb mongodb-server && \
    yum clean all

RUN mkdir -p /data/db

ADD scripts /scripts
RUN chmod 755 /scripts/*.sh

EXPOSE 27017 28017

VOLUME ["/data/db"]

CMD ["/scripts/run.sh"]
