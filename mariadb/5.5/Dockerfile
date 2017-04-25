#
# Postil: Dockerfile for building MariaDB images
#

FROM            docker.io/centos:latest
MAINTAINER      Jingy <jy_whale@163.com>

ENV DATA_DIR /var/lib/mysql

# Install Mariadb
ADD mariadb.repo /etc/yum.repos.d/
RUN yum -y install epel-release && \
    yum -y install mariadb mariadb-server && \
    yum -y install pwgen && \
    yum clean all

ADD my.cnf /etc/my.cnf

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

CMD ["/docker-entrypoint.sh"]
