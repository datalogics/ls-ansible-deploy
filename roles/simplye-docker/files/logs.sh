#!/bin/bash

id=$(docker ps | grep deploy | awk '{print $1}')

docker exec $id cat /var/log/uwsgi/uwsgi.log | less
