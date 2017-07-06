#!/usr/bin/env bash

#export DEBIAN_FRONTEND=noninteractiv

#This script is to install nginx package in server, configure and reload configuration

# 1.0 Install nginx packages

sudo apt-get update -y

sudo apt-get install -y nginx

#2.0 Nginx configuring in default site for php-fpm connection

sudo sed -i 's/index index.html index.htm index.nginx-debian.html;/index index.php index.html index.htm index.nginx-debian.html;/g'  /etc/nginx/sites-available/default

sudo sed -i 's#/var/www/html;#/var/www/html/sample-app;#g'  /etc/nginx/sites-available/default

sudo sed -i 's/# pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000/location ~ \\.php$ { \n fastcgi_keep_conn on; \n include fastcgi_params; \n fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name; \n fastcgi_intercept_errors on; \n fastcgi_split_path_info ^(.+\\.php)(.*)$; \n fastcgi_hide_header X-Powered-By; \n fastcgi_pass 10.127.0.20:9000; \n }/g' /etc/nginx/sites-available/default

sudo sed -i 's@#       deny all;@location ~ /\q.ht { \n                 deny all; \n         }@g'  /etc/nginx/sites-available/default

#3.0 Reflect configuration:

sudo /etc/init.d/nginx reload
