#!/bin/bash

id=$(docker ps | grep deploy | awk '{print $1}')

docker exec $id cat /var/log/libsimple/uwsgi.log | less
