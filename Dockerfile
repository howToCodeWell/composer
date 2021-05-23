FROM php:8.0.6-apache-buster

LABEL maintainer="Peter Fisher"

RUN apt-get update --fix-missing \
    && apt-get install -y --no-install-recommends mariadb-client zlib1g-dev libcurl3-dev libssl-dev libicu-dev g++ \
    && docker-php-ext-configure intl \
    && docker-php-ext-install pdo_mysql intl

RUN pecl install redis raphf \
    && docker-php-ext-enable redis raphf

RUN apt-get install -y --no-install-recommends  \
    zip unzip libzip-dev curl \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip

RUN pecl install pecl_http

RUN pecl install xdebug-3.0.0 && docker-php-ext-enable xdebug http

COPY --from=composer /usr/bin/composer /usr/bin/composer

RUN apt-get clean autoclean \
    && apt-get autoremove --yes \
    && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
    && rm -rf /tmp/*
