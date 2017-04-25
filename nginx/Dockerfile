#
# Postil: Dockerfile for building nginx images
#

FROM            alpine:3.4
MAINTAINER      Renyf <renyongfanemail@sina.com>

RUN apk --update add nginx && \
    rm -rf /var/cache/apk/*

ADD nginx.conf /etc/nginx/nginx.conf
RUN chmod 644 /etc/nginx/nginx.conf

RUN mkdir /run/nginx
RUN mkdir /app && cp -p /var/lib/nginx/html/index.html /app

EXPOSE 80 443

VOLUME ["/app"]

CMD ["nginx", "-g", "daemon off;"]
