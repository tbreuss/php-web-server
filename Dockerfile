FROM cgr.dev/chainguard/wolfi-base:latest
ARG PHP_VERSION=8.4

RUN <<EOF
  apk update
  apk add --no-cache \
    composer \
    php-${PHP_VERSION} \
    php-${PHP_VERSION}-curl \
    php-${PHP_VERSION}-ctype \
    php-${PHP_VERSION}-dom \
    php-${PHP_VERSION}-gd \
    php-${PHP_VERSION}-intl \
    php-${PHP_VERSION}-mbstring \
    php-${PHP_VERSION}-mysqli \
    php-${PHP_VERSION}-mysqlnd \
    php-${PHP_VERSION}-openssl \
    php-${PHP_VERSION}-phar \
    php-${PHP_VERSION}-pdo \
    php-${PHP_VERSION}-pdo_mysql \
    php-${PHP_VERSION}-xdebug \
    php-${PHP_VERSION}-zip
EOF

WORKDIR /app
VOLUME /app

EXPOSE 8888

CMD ["php", "-S", "0.0.0.0:8888", "-t", "/app"]