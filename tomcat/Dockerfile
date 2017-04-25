#
# Postil: Dockerfile for building tomcat images
#

FROM            alpine-jdk:1.8
MAINTAINER      Renyf <renyongfanemail@sina.com>

RUN wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.54/bin/apache-tomcat-7.0.54.tar.gz

RUN tar zxvf apache-tomcat-7.0.54.tar.gz && \
    rm -rf apache-tomcat-7.0.54.tar.gz && \
    mv apache-tomcat-7.0.54 /usr/local/tomcat7

ADD server.xml /usr/local/tomcat7/conf/server.xml
RUN chmod 644 /usr/local/tomcat7/conf/server.xml
RUN mkdir /app && cp -pr /usr/local/tomcat7/webapps/ROOT/* /app/ 

EXPOSE 8080 8443

VOLUME ["/app"]

ENTRYPOINT /usr/local/tomcat7/bin/catalina.sh run
