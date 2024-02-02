# Utilizar una imagen de Alpine Linux v3.14 como base
FROM alpine:3.14

# Instalar el cliente de MySQL
RUN apk add --no-cache mysql-client curl bash openssl gnupg && \
    rm -rf /var/cache/apk/*

# Copiar el script Bash para ejecutar SQL
COPY sql_runner.sh /sql_runner.sh
RUN chmod +x /sql_runner.sh

# Establecer variables de entorno para la conexión a MySQL
ENV MYSQL_HOST server
ENV MYSQL_DATABASE dbname
ENV MYSQL_USER user
ENV MYSQL_PASSWORD pass
ENV QUERY query


# Establecer el punto de entrada para ejecutar el script con Bash
CMD ["/sql_runner.sh"]
