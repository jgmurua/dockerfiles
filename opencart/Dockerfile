# Usar una imagen base de PHP con Apache
FROM php:8.0-apache

# Actualizar e instalar dependencias
RUN apt-get update && \
    apt-get install -y zip unzip libpng-dev libjpeg-dev libfreetype6-dev libzip-dev sqlite3 libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

# Habilitar extensiones de PHP necesarias
RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install gd mysqli opcache zip pdo pdo_sqlite

# Descargar e instalar OpenCart
WORKDIR /var/www/html
RUN curl -L https://github.com/opencart/opencart/releases/download/4.0.2.2/opencart-4.0.2.2.zip -o opencart.zip && \
    unzip opencart.zip && \
    rm opencart.zip && \
    mv upload/* . && \
    rm -r upload && \
    chown -R www-data:www-data .

COPY config.php /var/www/html/config.php
COPY admin/config.php /var/www/html/admin/config.php

# Configurar Apache
RUN a2enmod rewrite

# Puerto en el que Apache escuchará
EXPOSE 80

# Comando para iniciar Apache
CMD ["apache2-foreground"]
