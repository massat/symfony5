FROM php:8.0-fpm

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  git \
  # zip
  libzip-dev \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install \
  zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer

RUN curl -sS https://get.symfony.com/cli/installer | bash \
  && mv /root/.symfony/bin/symfony /usr/local/bin/symfony
