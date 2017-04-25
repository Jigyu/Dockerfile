#
# Postil: Dockerfile for building mysql5.6 images
#

FROM            docker.io/centos:latest
MAINTAINER      Jingy <jy_whale@163.com>

ENV DATA_DIR /var/lib/mysql

# Install mysql 
ADD mysql.repo /etc/yum.repos.d/
RUN yum -y install epel-release && \
    yum -y install mysql mysql-server && \
    yum -y install expect && \
    yum clean all

ADD my.cnf /etc/my.cnf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

CMD ["/docker-entrypoint.sh"]

