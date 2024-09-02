# Reemplaza "tu_usuario" y "tu_contraseña" con las credenciales que deseas utilizar
docker build -t revprox .

# Ejecuta el contenedor en el puerto 80 y enlázalo con el contenedor de Jenkins (asegúrate de que el contenedor de Jenkins se esté ejecutando)
docker run -ti -p 80:80 -e USERNAME=jgmurua -e PASSWORD=******* -e JENKINS_URL=http://192.168.100.21:30021 revprox