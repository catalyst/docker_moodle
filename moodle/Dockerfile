FROM ubuntu:14.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -y nginx \
    php5 \
    php5-fpm \
    php5-mysql \
    php5-xdebug \
    php5-cli \
    curl \
    php5-curl \
    php5-gd \
    php-soap \
    php5-intl \
    php5-xmlrpc \
    php5-ldap \
    locales

RUN locale-gen en_AU.UTF-8

RUN cd /usr/local/lib/ && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN mkdir /siteroot

RUN mkdir /var/lib/sitedata && chmod 0777 /var/lib/sitedata
RUN mkdir /var/lib/testsitedata && chmod 0777 /var/lib/testsitedata

RUN rm /etc/nginx/sites-available/default
COPY nginx-site.conf /etc/nginx/sites-available/default

RUN rm /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

COPY 99-xdebug.ini /etc/php5/mods-available/xdebug.ini

CMD service php5-fpm start && nginx
