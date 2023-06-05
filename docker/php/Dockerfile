FROM php:8.1-fpm

# Définir le répertoire de travail dans le conteneur
WORKDIR /srv

# Installez les dépendances système nécessaires pour Symfony
RUN apt-get update && apt-get install -y \
    git \
    libicu-dev \
    libzip-dev \
    unzip

# Installez les extensions PHP requises pour Symfony
RUN docker-php-ext-install \
    intl \
    pdo_mysql \
    zip

# Installez Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Exécutez Composer pour installer les dépendances du projet
#RUN composer install --no-interaction --no-plugins --no-scripts


# Démarrez le serveur PHP-FPM
CMD ["php-fpm"]