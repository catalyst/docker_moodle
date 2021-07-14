#!/bin/bash
#

DOCKER_PORT=$1
DOCKER_PORT_SSL=$2
DOCKER_PORT_MAILCATCHER=$3
WWWROOT_HOSTNAME=$4
WWWROOT_METHOD=$5
WWWROOT_PORT=$6

# ==================================
# ===== TEMPLATED DOCKER FILES =====
# ==================================

# docker-compose.yml
cp -a docker-compose-template.yml docker-compose.yml
sed -i "s/%%DOCKER_PORT%%/$DOCKER_PORT/g" docker-compose.yml
sed -i "s/%%DOCKER_PORT_SSL%%/$DOCKER_PORT_SSL/g" docker-compose.yml
sed -i "s/%%DOCKER_PORT_MAILCATCHER%%/$DOCKER_PORT_MAILCATCHER/g" docker-compose.yml


# docker/moodle/nginx-site
cp -a docker/moodle/nginx-site-template docker/moodle/nginx-site
sed -i "s/%%DOCKER_PORT%%/$DOCKER_PORT/g" docker/moodle/nginx-site
sed -i "s/%%DOCKER_PORT_SSL%%/$DOCKER_PORT_SSL/g" docker/moodle/nginx-site
sed -i "s/%%WWWROOT_HOSTNAME%%/$WWWROOT_HOSTNAME/g" docker/moodle/nginx-site
sed -i "s/%%WWWROOT_METHOD%%/$WWWROOT_METHOD/g" docker/moodle/nginx-site
sed -i "s/%%WWWROOT_PORT%%/$WWWROOT_PORT/g" docker/moodle/nginx-site

# moodle-config to siteroot/config.php
mkdir -p siteroot
cp -a moodle-config-template siteroot/config.php
sed -i "s/%%WWWROOT_HOSTNAME%%/$WWWROOT_HOSTNAME/g" siteroot/config.php
sed -i "s/%%WWWROOT_METHOD%%/$WWWROOT_METHOD/g" siteroot/config.php
sed -i "s/%%WWWROOT_PORT%%/$WWWROOT_PORT/g" siteroot/config.php
sed -i "s/%%DOCKER_PORT_MAILCATCHER%%/$DOCKER_PORT_MAILCATCHER/g" siteroot/config.php

# moodle/docker/Dockerfile
cp -a docker/moodle/Dockerfile-template docker/moodle/Dockerfile
sed -i '/^ENTRYPOINT .*/i COPY nginx-selfsigned.key /etc/ssl/private/nginx-selfsigned.key\nCOPY nginx-selfsigned.crt /etc/ssl/certs/nginx-selfsigned.crt\nCOPY dhparam.pem /etc/ssl/certs/dhparam.pem\nCOPY self-signed.conf /etc/nginx/snippets/self-signed.conf\nCOPY ssl-params.conf /etc/nginx/snippets/ssl-params.conf\n\n' docker/moodle/Dockerfile

# ======================================
# ===== SELF-SIGNED SSL CERTIFICATE ====
# ======================================

# Generate private key and cert with WWWROOT_HOSTNAME
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./docker/moodle/nginx-selfsigned.key -out ./docker/moodle/nginx-selfsigned.crt \
    -subj "/CN=$WWWROOT_HOSTNAME\/emailAddress=admin@$WWWROOT_HOSTNAME/C=AU/ST=/L=/O=Catalyst IT/OU=" 

# Generate strong Diffie-Hellman group
openssl dhparam -out ./docker/moodle/dhparam.pem 2048

# Generate/overwrite any ssl-params.conf (already packaged, but hey):
cat << 'EOF' > ./docker/moodle/ssl-params.conf
# from https://cipherli.st/
# and https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html

ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
ssl_prefer_server_ciphers on; 
ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";
ssl_ecdh_curve secp384r1;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off;
ssl_stapling on; 
ssl_stapling_verify on; 
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s; 
# Disable preloading HSTS for now.  You can use the commented out header line that includes
# the "preload" directive if you understand the implications.
#add_header Strict-Transport-Security "max-age=63072000; includeSubdomains; preload";
add_header Strict-Transport-Security "max-age=63072000; includeSubdomains";
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;

ssl_dhparam /etc/ssl/certs/dhparam.pem;

EOF

