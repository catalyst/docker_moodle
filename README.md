# docker_moodle

## Requirements

- Docker
- Docker-compose
- Nginx installed locally

## Set up

1. Clone this repository to the folder where all your moodle projects are stored (e.g ~/projects)

```
git clone git@github.com:catalyst/docker_moodle.git ~/projects/docker_moodle
```

2. Set environment variable PROJECTS_DIR to where all your moodle projects are stored (including just cloned docker_moodle)

```
sudo bash -c 'echo "PROJECTS_DIR=/home/dmitriim/projects" >> /etc/environment'
```

```
echo "export PROJECTS_DIR=/home/dmitriim/projects" >> ~/.bashrc
source ~/.bashrc
```

2. Symlink control file to your /usr/local/bin/control

```
sudo ln -s ~/project/docker_moodle/control /usr/local/bin/control
```

3. Make ure that you local nginx server got client_max_body_size set to 8000M

```
sudo vi /etc/nginx/nginx.conf
```

```
http {
...
   client_max_body_size 8000M;
...        

}
```

4. Set up MailHog locally (it will be used for all your instances). Note: 192.168.56.1 is your local IP address,
   and it should be available from your docker containers. 

```
docker run --detach --name=mailhog --publish=192.168.56.1:8025:8025 --publish=192.168.56.1:1025:1025 --restart=unless-stopped mailhog/mailhog
```

```
sudo bash -c 'echo "MOODLE_MAIL_HOST=192.168.56.1" >> /etc/environment'
```

```
echo "export MOODLE_MAIL_HOST=192.168.56.1" >> ~/.bashrc
source ~/.bashrc
```

MailHog UI will be available on http://192.168.56.1:8025

## Usage

1. Clone Moodle code to your  to where all your moodle projects are stored (e.g ~/projects)

```
git clone git@github.com:moodle/moodle.git ~/projects/moodle
```

2. Create project (a name of the project should match the folder where your moodle code is located)

```
sudo control create moodle 
```

4. Start containers

```
 control start moodle
```

5. Stop containers

```
 control stop moodle
```

6. Delete project

```
 sudo control delete moodle
```

## Utility Commands

Use the following command to enter the bash shell of each container.
Replaces using the docker exec function.

To change container names, change name in yaml file and control file.

Enter web container:

```
control web moodle
```

Enter db container:

```
control db moodle
```

Enter test database container:

```
control testdb moodle
```

Restore db locally:

```
control dbrestore moodle <filename.gz>
```

## Running Tests

To setup the testing environment run:

```
control web moodle
php admin/tool/phpunit/cli/init.php
```

To run tests:

```
control web
./vendor/bin/phpunit
```
