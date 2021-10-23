#!/bin/bash

echo "env[MOODLE_NAME] = ${MOODLE_NAME}" >>  /etc/php/7.4/fpm/pool.d/custom-php-fpm.conf
echo "env[MOODLE_MAIL_HOST] = ${MOODLE_MAIL_HOST}" >>  /etc/php/7.4/fpm/pool.d/custom-php-fpm.conf

service php7.4-fpm start

exec "nginx"