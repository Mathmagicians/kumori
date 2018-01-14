FROM php:7.1.11-cli-alpine3.4

RUN apk update && \
    apk upgrade && \
    apk add --no-cache git postgresql-dev && \
    docker-php-ext-install pdo pdo_pgsql
RUN wget -O /usr/bin/phpcs.phar https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && \
    wget -O /usr/bin/phpcbf.phar https://squizlabs.github.io/PHP_CodeSniffer/phpcbf.phar && \
    wget -O /usr/bin/php-cs-fixer.phar https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/download/v2.0.0/php-cs-fixer.phar && \
    wget -O /usr/bin/composer.phar https://github.com/composer/composer/releases/download/1.5.5/composer.phar && \
    chmod 755 /usr/bin/*.phar
