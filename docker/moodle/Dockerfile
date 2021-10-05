FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Replaced sh with bash.
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update -y \
    && apt-get install -y \
    curl \
    graphviz \
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
    php-soap \
    php-tideways \
    php-xdebug \
    php-xml \
    php-xmlrpc \
    php-zip \
    vim \
    php-pear \
    php-dev \
    gnupg \    
    gnupg2


# Microsoft ODBC driver.
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update -y
RUN ACCEPT_EULA=Y apt-get install -y msodbcsql17
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && source ~/.bashrc \
    && apt-get install -y unixodbc-dev \
    && pecl install sqlsrv \
    && pecl install pdo_sqlsrv
RUN printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/7.4/mods-available/sqlsrv.ini
RUN printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/7.4/mods-available/pdo_sqlsrv.ini
RUN phpenmod -v 7.4 sqlsrv pdo_sqlsrv

RUN locale-gen en_AU.UTF-8

RUN cd /usr/local/lib/ && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

RUN mkdir /var/lib/sitedata \
    && chmod 0777 /var/lib/sitedata \
    && mkdir /var/lib/testsitedata \
    && chmod 0777 /var/lib/testsitedata

COPY nginx-site /etc/nginx/sites-available/default
COPY nginx.conf /etc/nginx/nginx.conf
COPY xdebug.ini /etc/php/7.4/mods-available/xdebug.ini
COPY php.ini /etc/php/7.4/fpm/php.ini

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

WORKDIR /siteroot

ENTRYPOINT ["/entrypoint.sh"]