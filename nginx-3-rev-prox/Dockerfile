# Usa la imagen oficial de Nginx
FROM nginx:alpine

# Copia el archivo de configuración principal de Nginx al contenedor
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expone el puerto 80 para que Nginx escuche las solicitudes
EXPOSE 80

CMD [ "sh", "-c", "nginx -g 'daemon off;'" ]