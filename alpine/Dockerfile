#
# Postil: Dockerfile for building alpine images
#

FROM            docker.io/alpine:latest
MAINTAINER      Renyf <renyongfanemail@sina.com>

ENV TZ "Asia/Shanghai"

RUN echo "https://mirrors.ustc.edu.cn/alpine/v3.4/main/" > /etc/apk/repositories && \
    echo "https://mirrors.ustc.edu.cn/alpine/v3.4/community/" >> /etc/apk/repositories && \
    apk update && \
    apk add tzdata