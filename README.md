# docker_moodle

## Requirements
* Docker
* Docker-compose

## Usage

1. Clone this repository
```
git clone git@github.com:kenneth-hendricks/docker_moodle.git docker_moodle
```

2. Clone Moodle code into siteroot
```
cd docker_moodle
git clone git@github.com:moodle/moodle.git siteroot
```

3. Copy site config across
```
cp moodle/moodle-config siteroot/config.php
```

4. Start containers
```
docker-compose up
```

## Support environments

| Ubuntu | PHP | LMS           | Database | Webserver | Branch                       |
| ------:| ---:| -------------:| --------:| ---------:| ----------------------------:|
| 14.04  | 5.5 | Moodle        | Postgres | Nginx     | trusty-moodle-postgres-nginx |
| 14.04  | 5.5 | Moodle        | Postgres | Apache    | Not supported (yet)          |
| 14.04  | 5.5 | Moodle        | Mysql    | Nginx     | trusty-moodle-mysql-nginx    |
| 14.04  | 5.5 | Moodle        | Mysql    | Apache    | Not supported (yet)          |
| 14.04  | 5.5 | Mahara        | Postgres | Nginx     | Not supported (yet)          |
| 14.04  | 5.5 | Mahara        | Postgres | Apache    | Not supported (yet)          |
| 14.04  | 5.5 | Mahara        | Mysql    | Nginx     | Not supported (yet)          |
| 14.04  | 5.5 | Mahara        | Mysql    | Apache    | Not supported (yet)          |
| 16.04  | 7.0 | Moodle        | Postgres | Nginx     | xenial-moodle-postgres-nginx |
| 16.04  | 7.0 | Moodle        | Postgres | Apache    | Not supported (yet)          |
| 16.04  | 7.0 | Moodle        | Mysql    | Nginx     | xenial-moodle-mysql-nginx    |
| 16.04  | 7.0 | Moodle        | Mysql    | Apache    | Not supported (yet)          |
| 16.04  | 7.0 | Mahara        | Postgres | Nginx     | xenial-mahara-postgres-nginx |
| 16.04  | 7.0 | Mahara        | Postgres | Apache    | Not supported (yet)          |
| 16.04  | 7.0 | Mahara        | Mysql    | Nginx     | Not supported (yet)          |
| 16.04  | 7.0 | Mahara        | Mysql    | Apache    | Not supported (yet)          |
| 18.04  | 7.2 | Moodle        | Postgres | Nginx     | bionic-moodle-postgres-nginx |
| 18.04  | 7.2 | Moodle        | Postgres | Apache    | Not supported (yet)          |
| 18.04  | 7.2 | Moodle        | Mysql    | Nginx     | Not supported (yet)          |
| 18.04  | 7.2 | Moodle        | Mysql    | Apache    | Not supported (yet)          |
| 18.04  | 7.2 | Mahara        | Postgres | Nginx     | Not supported (yet)          |
| 18.04  | 7.2 | Mahara        | Postgres | Apache    | Not supported (yet)          |
| 18.04  | 7.2 | Mahara        | Mysql    | Nginx     | Not supported (yet)          |
| 18.04  | 7.2 | Mahara        | Mysql    | Apache    | Not supported (yet)          |

## Roadmap

* Add Support for all environments
* Add common utility commands

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
