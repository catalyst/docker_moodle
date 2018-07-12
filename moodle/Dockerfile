FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -y nginx \
    php-fpm \
    php-pgsql \
    php-xdebug \
    curl \
    php-curl \
    php-gd \
    php-soap \
    php-intl \
    php-xmlrpc \
    php-ldap \
    php-xml \
    php-mbstring \
    php-zip \
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

COPY 99-xdebug.ini /etc/php/7.2/mods-available/xdebug.ini

CMD service php7.2-fpm start && nginx
