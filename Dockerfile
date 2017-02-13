FROM starase/base
MAINTAINER Paolo De Michele <paolo@starase.com>

RUN apt-get update && apt-get install nginx unzip php7.0-mysql php7.0-fpm php7.0-bz2 php7.0-curl php7.0-gd php7.0-intl php7.0-mbstring php7.0-xml php7.0-zip -y
RUN mkdir -p /etc/starase/src && mkdir -p /var/www/html && mkdir -p /run/php \
   && cd /etc/starase/src \
   && curl -O https://download.owncloud.org/community/owncloud-9.1.4.zip \
   && unzip owncloud-9.1.4.zip \
   && rm -rf /var/www/html/* \
   && cp -R owncloud/* /var/www/html/ \
   && chown -R www-data:www-data /var/www/html/*

COPY supervisor/*.conf /etc/supervisor/conf.d/
COPY customization.sh /etc/starase/
COPY conf/owncloud.conf /etc/nginx/sites-available/

RUN chmod 700 /etc/starase/customization.sh \
    && /bin/bash /etc/starase/customization.sh \
    && rm -rf /etc/nginx/sites-enabled/default \
    && ln -s /etc/nginx/sites-available/owncloud.conf /etc/nginx/sites-enabled/owncloud.conf
