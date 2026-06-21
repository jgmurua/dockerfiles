# Utiliza la imagen base de Alpine con Nginx
FROM nginx:1.25-alpine

# Copia el archivo de configuración personalizado al contenedor
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Instala el paquete apache2-utils para generar las contraseñas
RUN apk update && apk add apache2-utils

# Establece las variables de usuario y contraseña para la autenticación
ENV USERNAME=""
ENV PASSWORD=""
ENV PROXY_URL=""
ENV PORT=""


# Expone el puerto 80 para que Nginx escuche las solicitudes
EXPOSE 80

CMD [ "sh", "-c", "htpasswd -b -c /etc/nginx/.htpasswd $USERNAME $PASSWORD \
       && sed -i 's|PROXY_URL|'$PROXY_URL'|g' /etc/nginx/conf.d/default.conf \
       && sed -i 's|PORT|'$PORT'|g' /etc/nginx/conf.d/default.conf \
       && nginx -g 'daemon off;'" ]
