# dockerfile para la creacion de la imagen de magento2
FROM ubuntu:23.10

# Configuracion de variables de entorno
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV HOSTNAME_MAGENTO magento2.local
ENV DB_HOST localhost
ENV DB_NAME magento2
ENV DB_USER magento2
ENV DB_USER_PASS magento2
ENV USER_ADMIN admin
ENV USER_ADMIN_PASS admin123


# Instalacion de paquetes necesarios para la instalacion de magento2
RUN apt-get update && apt-get install -y \
    apache2 \
    php \
    php-mysql \
    php-curl \
    php-gd \
    php-intl \
    php-mbstring \
    php-soap \
    php-xml \
    php-xmlrpc \
    php-zip \
    libapache2-mod-php \
    curl \
    git \
    unzip \
    vim \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Instalacion de composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalacion de magento2
RUN cd /var/www/html && \
    composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition magento2

# Configuracion de apache2
RUN a2enmod rewrite && \
    sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/magento2\/pub/g' /etc/apache2/sites-available/000-default.conf && \
    sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf

# Configuracion de php
RUN sed -i 's/memory_limit = 128M/memory_limit = 2G/g' /etc/php/7.4/apache2/php.ini && \
    sed -i 's/max_execution_time = 30/max_execution_time = 18000/g' /etc/php/7.4/apache2/php.ini && \
    sed -i 's/zlib.output_compression = Off/zlib.output_compression = On/g' /etc/php/7.4/apache2/php.ini && \
    sed -i 's/;opcache.save_comments=1/opcache.save_comments=1/g' /etc/php/7.4/apache2/php.ini && \
    sed -i 's/;opcache.enable_file_override=0/opcache.enable_file_override=1/g' /etc/php/7.4/apache2/php.ini && \
    sed -i 's/;opcache.validate_timestamps=1/opcache.validate_timestamps=0/g' /etc/php/7.4/apache2/php.ini && \
    sed -i 's/;opcache.enable_cli=0/opcache.enable_cli=1/g' /etc/php/7.4/apache2/php.ini && \
    sed -i 's/;opcache.memory_consumption=128/opcache.memory_consumption=512/g' /etc/php/7.4/apache2/php.ini && \
    sed -i 's/;opcache.max_accelerated_files=10000/opcache.max_accelerated_files=100000/g' /etc/php/7.4/apache2/php.ini && \
    sed -i 's/;opcache.revalidate_freq=2/opcache.revalidate_freq=0/g' /etc/php/7.4/apache2/php.ini && \
    sed -i 's/;opcache.fast_shutdown=0/opcache.fast_shutdown=1/g' /etc/php/7.4/apache2/php.ini

# Configuracion de magento2
RUN cd /var/www/html/magento2 && \
    php bin/magento setup:install \
    --base-url=http://$HOSTNAME_MAGENTO/magento2 \
    --db-host=$DB_HOST \
    --db-name=$DB_NAME \
    --db-user=$DB_USER \
    --db-password=$DB_USER_PASS \
    --admin-password=$USER_ADMIN \
    --admin-user=$USER_ADMIN_PASS

# Configuracion de permisos
RUN chown -R www-data:www-data /var/www/html/magento2 && \
    chmod -R 755 /var/www/html/magento2


# Exposicion de puertos
EXPOSE 80

# Inicio de apache2
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
