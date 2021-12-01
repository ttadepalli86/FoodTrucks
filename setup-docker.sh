#!/bin/bash

# build the flask container
docker build -t ttadepalli86/foodtrucks .

# create the network
docker network create foodtrucks-net

# start the ES container
docker run -d --name es --net foodtrucks-net -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" -e "ES_JAVA_OPTS=-Xmx1g -Xms1g" docker.elastic.co/elasticsearch/elasticsearch:6.3.2

#Sleep And Wait for 5 Secs
sleep 25

# start the flask app container
docker run -d --net foodtrucks-net -p 5000:5000 --name ft ttadepalli86/foodtrucks
