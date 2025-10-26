ARG PHP_VERSION=8.4

FROM php:$PHP_VERSION-cli-alpine

COPY --from=ghcr.io/mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN <<EOF
  install-php-extensions \
    @composer \
    gd \
    intl \
    pdo_mysql \
    xdebug \
    zip
EOF

WORKDIR /app
VOLUME /app

EXPOSE 8888

CMD ["php", "-S", "0.0.0.0:8888", "-t", "/app"]