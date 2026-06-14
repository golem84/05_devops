# Лаб. работа №5. Образы Docker

to build image from ./nginx:
`docker build -t nginx-server .`

to run container from ./nginx:
`docker run -d --name nignx-server1 -p 8080:80 nginx-server`