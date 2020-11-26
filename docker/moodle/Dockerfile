FROM ubuntu:14.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y \
    && apt-get install -y \
    curl \
    locales \
    nginx \
    php-soap \
    php5 \
    php5-cli \
    php5-curl \
    php5-fpm \
    php5-gd \
    php5-intl \
    php5-ldap \
    php5-pgsql \
    php5-xdebug \
    php5-xmlrpc \
    vim 

RUN locale-gen en_AU.UTF-8

RUN cd /usr/local/lib/ && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN mkdir /var/lib/sitedata \
    && chmod 0777 /var/lib/sitedata \
    && mkdir /var/lib/testsitedata \
    && chmod 0777 /var/lib/testsitedata

COPY nginx-site /etc/nginx/sites-available/default
COPY nginx.conf /etc/nginx/nginx.conf
COPY xdebug.ini /etc/php5/mods-available/xdebug.ini
COPY php.ini /etc/php5/fpm/php.ini

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /siteroot

ENTRYPOINT ["/entrypoint.sh"]