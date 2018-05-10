FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -y nginx \
                            php \
                            php-fpm \
                            php-pgsql \
                            php-xdebug \
                            php-cli \
                            curl \
                            php-xml \
                            php-curl \
                            php-zip \
                            php-gd \
                            php-mbstring \
                            php-soap \
                            php-intl \
                            php-xmlrpc

RUN cd /usr/local/lib/ && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN mkdir /siteroot

RUN mkdir /var/lib/sitedata && chmod 0777 /var/lib/sitedata

RUN rm /etc/nginx/sites-available/default
COPY nginx-site.conf /etc/nginx/sites-available/default

RUN rm /etc/nginx/nginx.conf
COPY nginx.conf /etc/nginx/nginx.conf

COPY 99-xdebug.ini /etc/php/7.0/mods-available/xdebug.ini
# This port is needed for xdebug


CMD service php7.0-fpm start && nginx
