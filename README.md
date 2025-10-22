# Docker Image using PHP's built-in Web Server

This Docker image provides a lightweight PHP development environment using PHP's built-in web server.
Based on the official PHP image, it's ideal for quickly spinning up ad hoc projects.

## Supported PHP Versions

- 8.2
- 8.3
- 8.4

Older versions should also work.

## Build Image

Create Docker image based on the latest supported PHP version.

    docker build -t php:8.4 https://github.com/tbreuss/php-built-in-server.git

Optionally, you can also use an older PHP version.

    docker build --build-arg PHP_VERSION=8.2 -t php:8.2 https://github.com/tbreuss/php-built-in-server.git
    docker build --build-arg PHP_VERSION=8.3 -t php:8.3 https://github.com/tbreuss/php-built-in-server.git

## Apply Image

Let's say you have the following project structure.

    project/
    ├─ your-code/
    └─ web/
        └─ index.php

Then you can start your project as follows:

    docker run --rm -v .:/app -p 8888:8888 php:8.4 php -S 0.0.0.0:8888 -t /app/web

And if you want to use Xdebug, here's how to do it:

    docker run --rm -e XDEBUG_CONFIG="client_host=172.17.0.1" -e XDEBUG_MODE=debug -e XDEBUG_SESSION_START=true -v .:/app -p 8888:8888 php:8.4 php -S 0.0.0.0:8888 -t /app/web

To start the container with an interactive terminal session, run the following command:

    docker run --rm -it -v .:/app php:8.4 bash
