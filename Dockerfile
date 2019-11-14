FROM php:7.2-apache
LABEL maintainer="martin.pircher@i-med.ac.at"
LABEL maintainer="andreas.erhard@i-med.ac.at"

# build:
# docker build -t gmitirol/resquewebui .
# run:
# docker stop resquewebui && docker run --rm -p 80:80 --name resquewebui gmitirol/resquewebui

EXPOSE 80

WORKDIR "/var/www/project"

# php
RUN set -xe && \
    apt-get update && \
    apt-get install -y git libmcrypt-dev zip unzip && \
    docker-php-ext-install -j$(nproc) pcntl

# apache config
COPY .docker/project.conf /etc/apache2/sites-available

RUN a2dissite 000-default && \
    a2ensite project && \
    a2enmod rewrite

# source
COPY ./ /var/www/project
RUN set -xe && \
    chmod +x bin/console && \
    rm -rf .docker && \
    rm -f Dockerfile

# composer
RUN set -xe && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer && \
    COMPOSER_CACHE_DIR=/dev/null composer install --no-dev --no-progress --optimize-autoloader --no-interaction && \
    chown -R www-data:www-data /var/www/project
