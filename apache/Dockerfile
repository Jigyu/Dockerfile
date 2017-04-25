#
# Postil: Dockerfile for building apache images
#

FROM            alpine:3.4
MAINTAINER      Renyf <renyongfanemail@sina.com>

RUN apk --update add apache2 apache2-utils && \
    rm -rf /var/cache/apk/*

ADD httpd.conf /etc/apache2/httpd.conf
RUN chmod 644 /etc/apache2/httpd.conf

RUN mkdir /run/apache2
RUN mkdir /app && cp -p /var/www/localhost/htdocs/index.html /app/

EXPOSE 80 443

VOLUME ["/app"]

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
