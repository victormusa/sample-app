#!/usr/bin/env bash


sudo apt-get install -y redis-server

sudo sed -i 's#bind 127.0.0.1#bind 127.0.0.1 10.127.0.30#g'  /etc/redis/redis.conf

sudo /etc/init.d/redis-server restart
