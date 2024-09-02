
docker build -t mi_nginx .

docker run -d -p 8080:80 mi_nginx


Abre tu navegador y accede a las siguientes URLs para ver las rutas configuradas:

http://localhost:8080/ruta1
http://localhost:8080/ruta2
http://localhost:8080/ruta3