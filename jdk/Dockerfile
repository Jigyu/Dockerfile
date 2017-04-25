#
# Postil: Dockerfile for building jdk images
#

FROM		alpine:3.4
MAINTAINER	Renyf <renyongfanemail@sina.com>

RUN apk --no-cache add openjdk8 && \
    rm -rf /tmp/*

CMD ["java", "-version"]
