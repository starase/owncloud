NGINX="/etc/nginx/nginx.conf"
PHP="/etc/php/7.0/fpm"

sed -i "4i daemon off;" $NGINX
sed -i "s/;daemonize = yes/daemonize = no/g" $PHP/php-fpm.conf
sed -i "/listen =/d" $PHP/pool.d/www.conf
sed -i "36i listen = 127.0.0.1:9000" $PHP/pool.d/www.conf
