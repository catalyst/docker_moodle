# docker_moodle

## Requirements

- Docker
- Docker-compose

## Usage

1. Clone this repository

```
git clone git@github.com:catalyst/docker_moodle.git docker_moodle
```

2. Clone Moodle code into siteroot

```
cd docker_moodle
git clone git@github.com:moodle/moodle.git siteroot
```

3. Copy site config across

```
cp moodle-config siteroot/config.php
```

4. (Optional) Edit config.php to enable mailcatcher

```
vim siteroot/config.php
```

Uncomment the following line
```
// $CFG->smtphosts = "mailcatcher:25";
```
And comment out the line:
```
$CFG->noemailever = true;
```

5. Start containers

```
docker-compose up
```

## Self-Signed Certificates and Multiple Docker Environments

1. Stop/Destroy containers

```
docker-compose down
```

2. Decide on hostname, method and ports for HTTP, HTTPS and MAILCATCHER

e.g.
```
DOCKER_PORT=81
DOCKER_PORT_SSL=44381
DOCKER_PORT_MAILCATCHER=1081
WWWROOT_HOSTNAME=docker-01-44381.local
WWWROOT_METHOD=https
WWWROOT_PORT=44381
```

3. Overwrite docker files from template using script (and generate self-signed SSL cert):

```
./apply-template.sh 81 44381 1081 docker-01-44381.local https 44381
```
Or, if you've copied/pasted the variable above into a terminal/environment variables:
```
./apply-template.sh $DOCKER_PORT $DOCKER_PORT_SSL $DOCKER_PORT_MAILCATCHER $WWWROOT_HOSTNAME $WWWROOT_METHOD $WWWROOT_PORT
```


4. Add WWWROOT_HOSTNAME as an additional entry in your host PC's /etc/hosts file

```
sudo vim /etc/hosts
```

Add WWWROOT_HOSTNAME to end of 127.0.0.1 line, like so:

```
127.0.0.1   localhost docker-01-44381.local
```

5. Start containers

```
docker-compose up
```

6. Access container in browser

https://docker-01-44381.local (will redirect to https://docker-01-44381.local:44381). 

After typing it in once, now you can use your browser's autocomplete awesome bar by typing "docker-01-" ... or "docker-02-" ... and you don't need to remember custom port numbers.


## Utility Commands

Use the following command to enter the bash shell of each container.
Replaces using the docker exec function.

To change container names, change name in yaml file and control file.

Enter web container:

```
./control web
```

Enter db container:

```
./control db
```

Enter test database container:

```
./control testdb
```

Restore db locally:

```
./control dbrestore <filename.gz>
```

## Running Tests

To setup the testing environment run:

```
./control web
composer install
php admin/tool/phpunit/cli/init.php
```

To run tests:

```
./control web
./vendor/bin/phpunit
```
