#!/bin/bash
echo -e "build image... \n"
docker build -t nginx-server ./nginx/.
echo -e "\n"
echo -e "run container... \n"
docker run -d --name nginx-server1 -p 54321:80 nginx-server
echo -e "\n"
echo -e "containers: \n"
docker ps -a
echo -e "\n"
echo -e "fetch index.html from nginx container:"
curl http://localhost:54321
echo -e "\n"
echo -e "logs from container:\n"
docker logs nginx-server1
echo -e "\n"
echo -e "stop and remove container:\n"
docker stop nginx-server1 && docker rm nginx-server1
echo -e "\n"
echo -e "there is no containers:\n"
docker ps -a
echo -e "\n"
echo -e "remove image:\n"
docker image rm nginx-server
echo -e "\n"
echo -e "there is no image 'nginx-server':\n"
docker images -a
echo -e "\n"
echo "done."
