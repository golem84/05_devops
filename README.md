# Лаб. работа №5. Образы и контейнеры Docker

## Подготовка

1. Создаем папку `nginx` с конфигурационными файлами для сборки образа `nginx-server`:
```bash
./nginx
    ├── nginx-conf
    │    └─ nginx.conf
    ├─ Dockerfile
    └─ index.html
```
2. в файле `nginx.conf` прописываем настройки сервера nginx:
```bash
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    root /var/www/html;

    index index.html index.htm index.nginx-debian.hmtl;

    server_name _;

    location / {
        try_files $uri $uri/ =404;
    }
}
```
3. в файле `index.html` создаем простую веб-страницу:  
```html
<HTML>
    <BODY>
        <H2>Hello World from Nginx in DOCKER!</H2>
    </BODY>
</HTML>

```
## В Dockerfile описываем процесс сборки:
- базовый образ nginx:1.12.0 - стабильная версия:  
`FROM nginx:1.12.0`
- копируем конфигурационные файлы в образ:  
```bash
COPY ["./nginx-conf/nginx.conf", "/etc/nginx/conf.d/default.conf"]
COPY ["./index.html", "/var/www/html/index.html"]
```
- для диагностики выводим распложение запускаемого файла, после комментируем:  
`# RUN which nginx`
- запускаем проверку конфигурационных файлов сервером Nginx:  
`RUN /usr/sbin/nginx -t`
- прописываем сигнал для безопасного и корректного завершения работы процессов внутри контейнера:  
`STOPSIGNAL SIGTERM`
- прописываем команду, которая будет выполнена при запуске контейнера:  
`CMD ["nginx", "-g", "daemon off;"]`

## Скрипт `run.sh` для проверки работы контейнера

Получает последнюю версию репозитория из `github.com` 
Запускает процесс сборки образа командой  
`# docker build -t nginx-server ./nginx/.`  
Проверяет что образ собран и готов к запуску  
Запускает образ с параметрами  
`# docker run -d --name nginx-server1 -p 54321:80 nginx-server`  
где:
- ключ `-d` - detached, запуск контейнера в фоне
- ключ `--name` - указываем имя создаваемому контейнеру
- ключ `-p` - указываем проброс портов хост:контейнер
- в конце указываем имя образа, из которого создать контейнер

Обращается к серверу Nginx в контейнере командой  
`$ curl http://localhost:54321`  
Должны получить такой вывод:  
```html
<HTML>
    <BODY>
        <H2>Hello World from Nginx in DOCKER!</H2>
    </BODY>
</HTML>
```
Выводит логи из процесса в контейнере командой  
`# docker logs nginx-server1`  
Должны получить такой вывод:
```bash
172.17.0.1 - - [14/Jun/2026:13:14:55 +0000] "GET / HTTP/1.1" 200 88 "-" "curl/8.5.0" "-"
172.17.0.1 - - [14/Jun/2026:13:15:04 +0000] "GET / HTTP/1.1" 200 88 "-" "curl/8.5.0" "-"
```
Аналогичный вывод можно получить в режиме реального времени из другого терминала командой  
`# docker attach nginx-server1`  
Останавливает и удаляет контейнер  
Удаляет образ с хоста  
