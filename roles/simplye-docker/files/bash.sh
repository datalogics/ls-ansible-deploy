#!/bin/bash

id=$(docker ps | grep deploy | awk '{print $1}')

docker exec -it $id /bin/bash
