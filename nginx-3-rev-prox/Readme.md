
docker build -t mi_nginx .

docker run -d -p 8080:80 mi_nginx
