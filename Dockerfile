ARG PHP_VERSION=8.4


FROM php:$PHP_VERSION-cli AS base


FROM base AS composer
COPY --from=composer:lts /usr/bin/composer /usr/bin/composer


FROM base AS server

RUN <<EOF
apt-get update
apt-get install -y --no-install-recommends \
  libicu-dev \
  libfreetype-dev \
  libjpeg62-turbo-dev \
  libpng-dev \
  libzip-dev
rm -rf /var/lib/apt/lists/*
EOF

RUN <<EOF
docker-php-ext-configure \
  gd --with-freetype --with-jpeg
docker-php-ext-install \
  gd \
  intl \
  mysqli \
  pdo \
  pdo_mysql \
  zip
EOF

RUN <<EOF
pecl channel-update pecl.php.net
pecl install xdebug
docker-php-ext-enable xdebug
EOF

COPY --from=composer /usr/bin/composer /usr/bin/composer
RUN cp /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

RUN groupadd -g 1000 php && useradd -m -u 1000 -g php php
RUN mkdir /app  && chown -R php:php /app
USER php

WORKDIR /app
VOLUME /app

EXPOSE 8888

CMD ["php", "-S", "0.0.0.0:8888", "-t", "/app"]