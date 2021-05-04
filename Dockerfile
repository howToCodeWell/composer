FROM php:7.4-apache-buster

LABEL maintainer="Peter Fisher"

RUN apt-get update --fix-missing \
    && apt-get install -y --no-install-recommends mariadb-client zlib1g-dev libcurl3-dev libssl-dev \
    && docker-php-ext-install pdo pdo_mysql iconv

RUN pecl install raphf propro redis \
    && docker-php-ext-enable raphf propro \
    && pecl install pecl_http-3.2.0  \
    && docker-php-ext-enable  http redis

RUN apt-get install -y --no-install-recommends  \
    zip unzip libzip-dev curl \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip

RUN pecl install xdebug-2.9.8 && docker-php-ext-enable xdebug

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && rm -rf /tmp/*
