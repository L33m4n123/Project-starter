FROM alpine:latest as production_base

MAINTAINER Patrick Lehmann

RUN apk update &&\
    apk add apache2 bash apache2-utils

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

FROM production_base as development
# Need to figure out a dynamic way of ports?
EXPOSE 8321
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

FROM production_base as production
# Need to figure out a dynamic way of ports?
EXPOSE 80
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]