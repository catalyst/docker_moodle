# docker_moodle

## Requirements

- Docker
- Docker-compose
- Nginx

## Set up

1. Clone this repository to the folder where all your moodle projects are stored (e.g ~/projects)

```
git clone git@github.com:catalyst/docker_moodle.git ~/projects/docker_moodle
```

2. Set environment variable PROJECTS_DIR to where all your moodle projects are stored (including just cloned docker_moodle)

```
 echo "export PROJECTS_DIR=/home/dmitriim/projects" >> ~/.bashrc
 source ~/.bashrc
```

2. Symlink control file to your /usr/local/bin/control

```
sudo ln -s ~/project/docker_moodle/control /usr/local/bin/control
```

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

4. Stop containers

```
 control stop moodle
```

4. Delete project

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
/vendor/bin/phpunit
```
