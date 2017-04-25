#
# Postil: Dockerfile for building mysql5.6 images
#

FROM            docker.io/centos:latest
MAINTAINER      Jingy <jy_whale@163.com>

ENV DATA_DIR /var/lib/mysql

# Install mysql 
RUN cd /tmp/ && \
    yum -y install epel-release && \
    yum -y install wget pwgen

RUN wget https://mirrors.tuna.tsinghua.edu.cn/mysql/downloads/MySQL-5.5/MySQL-client-5.5.54-1.el7.x86_64.rpm && \
    wget https://mirrors.tuna.tsinghua.edu.cn/mysql/downloads/MySQL-5.5/MySQL-server-5.5.54-1.el7.x86_64.rpm && \
    wget https://mirrors.tuna.tsinghua.edu.cn/mysql/downloads/MySQL-5.5/MySQL-devel-5.5.54-1.el7.x86_64.rpm && \
    yum -y localinstall *.rpm && \
    yum clean all

ADD my.cnf /etc/my.cnf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

CMD ["/docker-entrypoint.sh"]

