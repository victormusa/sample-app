#!/usr/bin/env bash


sudo apt-get install -y php5-fpm and php5-redis and git

sudo mkdir /var/www

sudo mkdir /var/www/html

sudo mkdir /var/www/html/sample-app

sudo git clone https://github.com/Tombar/sample-app /var/www/html/sample-app/

sudo sed -i 's#listen = /var/run/php5-fpm.sock#listen = 10.127.0.20:9000#g'  /etc/php5/fpm/pool.d/www.conf

sudo sed -i 's#;listen.allowed_clients = 127.0.0.1#listen.allowed_clients = 10.127.0.10#g'  /etc/php5/fpm/pool.d/www.conf

sudo sed -i 's#session.save_handler = files#session.save_handler = redis#g'  /etc/php5/fpm/php.ini

sudo sed -i 's#;session.save_path = "/var/lib/php5/sessions"#session.save_path = "tcp://10.127.0.30:6379"#g'  /etc/php5/fpm/php.ini

sudo sed -i 's#"host" => "127.0.0.1",#"host" => "10.127.0.30",#g'  /var/www/html/sample-app/settings.php


