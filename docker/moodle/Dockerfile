FROM ubuntu:16.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -y \
    curl \
    locales \
    nginx \
    php \
    php-bcmath \
    php-cli \
    php-curl \
    php-fpm \
    php-gd \
    php-intl \
    php-ldap \
    php-mbstring \
    php-mysql \
    php-pgsql \
    php-soap \
    php-xdebug \
    php-xml \
    php-xmlrpc \
    php-zip \
    vim 

RUN locale-gen en_AU.UTF-8

RUN cd /usr/local/lib/ && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN mkdir /var/lib/sitedata \
    && chmod 0777 /var/lib/sitedata \
    && mkdir /var/lib/testsitedata \
    && chmod 0777 /var/lib/testsitedata

COPY nginx-site /etc/nginx/sites-available/default
COPY nginx.conf /etc/nginx/nginx.conf
COPY xdebug.ini /etc/php/7.0/mods-available/xdebug.ini
COPY php.ini /etc/php/7.0/fpm/php.ini

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /siteroot

ENTRYPOINT ["/entrypoint.sh"]