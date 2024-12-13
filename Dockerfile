# Usar una imagen base de PHP
FROM php:8.1-fpm

# Instalar dependencias necesarias para Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql

# Instalar Composer (gestor de dependencias de PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html

# Copiar el código del proyecto al contenedor
COPY . .

# Instalar dependencias con Composer
RUN composer install --no-dev --optimize-autoloader

# Exponer el puerto para PHP
EXPOSE 9000

# Comando para iniciar el servidor PHP
CMD ["php-fpm"]
