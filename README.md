# Лаб. работа №5. Образы Docker

to build image from ./nginx:  
`docker build -t nginx-server .`  

to run container from ./nginx:  
`docker run -d --name nginx-server1 -p 54321:80 nginx-server`  

attach to container and view logs from nginx:  
`docker attach nginx-server1`  

to get an output to logs in nginx we need to access to it:  
`curl http://localhost:8080`  

output from container logs:  
```bash
172.17.0.1 - - [14/Jun/2026:13:14:55 +0000] "GET / HTTP/1.1" 200 88 "-" "curl/8.5.0" "-"
172.17.0.1 - - [14/Jun/2026:13:15:04 +0000] "GET / HTTP/1.1" 200 88 "-" "curl/8.5.0" "-"
```
