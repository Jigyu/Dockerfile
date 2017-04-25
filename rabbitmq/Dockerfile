#
# Postil: Dockerfile for building RabbitMQ images
#

FROM            docker.io/centos:latest
MAINTAINER      Renyf <renyongfanemail@sina.com>

RUN yum -y install epel-release wget pwgen && \
    yum -y install erlang && \
    yum clean all && \
    cd /usr/local/src/ ; wget https://www.rabbitmq.com/releases/rabbitmq-server/v3.6.2/rabbitmq-server-3.6.2-1.noarch.rpm && \
    yum -y install rabbitmq-server-3.6.2-1.noarch.rpm && \
    rabbitmq-plugins enable rabbitmq_management

ADD scripts /scripts
RUN chmod +x /scripts/*.sh  && touch /.firstrun

EXPOSE 5672 15672

ENTRYPOINT ["/scripts/run.sh"]
