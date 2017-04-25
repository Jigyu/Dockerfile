#
# Postil: Dockerfile for building mongodb images
#

FROM            docker.io/centos:latest
MAINTAINER      Renyf <renyongfanemail@sina.com>
ENV AUTH yes
ENV STORAGE_ENGINE wiredTiger
ENV JOURNALING yes

ADD mongodb-enterprise.repo /etc/yum.repos.d/mongodb-enterprise.repo

RUN yum -y install epel-release && \
    yum -y install pwgen net-snmp* cyrus* mongodb-enterprise && \
    yum clean all

ADD scripts /scripts
RUN chmod +x /scripts/*.sh

EXPOSE 27017 28017

VOLUME ["/data/db"]

CMD ["/scripts/run.sh"]
