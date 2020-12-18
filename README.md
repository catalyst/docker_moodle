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

## Access the Environment

To access the environment, browse to:

http://localhost

To access the mailcatcher web UI, browse to:

http://localhost:1080


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
