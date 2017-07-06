#!/usr/bin/env bash

#1.0 Redis package install:
sudo apt-get install -y redis-server

#2.0 Redis server connection configure:
sudo sed -i 's#bind 127.0.0.1#bind 127.0.0.1 10.127.0.30#g'  /etc/redis/redis.conf

#3.0 Redis reflecting configuration:
sudo /etc/init.d/redis-server restart
