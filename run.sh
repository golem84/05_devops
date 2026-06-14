#!/bin/bash
echo "====== 1. build image... ======"
docker build -t nginx-server ./nginx/.
echo "====== 2. images: ======"
docker image list | grep nginx-server
echo "====== 3. run container... ======"
docker run -d --name nginx-server1 -p 54321:80 nginx-server
echo "====== 4. containers: ======"
docker ps -a
echo "====== 5. fetch index.html from nginx container: ======"
curl http://localhost:54321
echo "====== 6. logs from container: ======"
docker logs nginx-server1
echo "====== 7. stop and remove container: ======"
docker stop nginx-server1 && docker rm nginx-server1
echo "====== 8. there is no containers: ======"
docker ps -a
echo "====== 9. remove image: ======"
docker image rm nginx-server
echo "====== 10. there is no image 'nginx-server': ======"
docker images -a
echo "====== done. ======"
