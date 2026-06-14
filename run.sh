#!/bin/bash
docker build -t nginx-server ./nginx/.
docker run -d --name nginx-server1 -p 54321:80 nginx-server
docker ps -a
curl http://localhost:54321
docker logs nginx-server1
