# Utilizamos una imagen base de Ubuntu
FROM ubuntu:latest
ARG country_code="AR"
ARG country="Argentina"
ARG statename="Buenos Aires"
ARG namecert="some name"
ARG email="youremail@.com"

# Actualizamos los paquetes del sistema e instalamos las dependencias necesarias
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    build-essential \
    openssl \
    libssl-dev \
    pkg-config \
    vim

# Descargamos y extraemos el código fuente de Squid
WORKDIR /tmp
RUN wget http://www.squid-cache.org/Versions/v6/squid-6.1.tar.gz \
    && tar -xvf squid-6.1.tar.gz

# Compilamos e instalamos Squid
WORKDIR /tmp/squid-6.1
RUN ./configure --with-default-user=proxy --with-openssl --enable-ssl-crtd \
    && make \
    && make install

# Configuramos OpenSSL
RUN sed -i '/\[ v3_ca \]/a keyUsage = cRLSign, keyCertSign' /etc/ssl/openssl.cnf

# Creamos una carpeta temporal y generamos el certificado autofirmado
RUN mkdir /tmp/ssl_cert
WORKDIR /tmp/ssl_cert
RUN openssl req -new -newkey rsa:2048 -days 365 -nodes -x509 -extensions v3_ca -keyout squid-self-signed.key -out squid-self-signed.crt \
    -subj "/C=${country_code}/ST=${country}/L=${statename}/O=MyProxy/OU=Squid/CN=${namecert}/emailAddress=S{email}" \
    && openssl x509 -in squid-self-signed.crt -outform DER -out squid-self-signed.der \
    && openssl x509 -in squid-self-signed.crt -outform PEM -out squid-self-signed.pem \
    && openssl dhparam -outform PEM -out squid-self-signed_dhparam.pem 2048

# Copiamos los certificados a la ubicación de Squid
RUN cp -rf /tmp/ssl_cert /usr/local/squid/etc/ssl_cert \
    && cp /usr/local/squid/etc/ssl_cert/squid-self-signed.pem /usr/local/share/ca-certificates/squid-self-signed.crt \
    && update-ca-certificates

# Copiamos la configuración de Squid
COPY squid.conf /usr/local/squid/etc/squid.conf

# Establecemos los permisos adecuados
RUN chown -R proxy:proxy /usr/local/squid

# Exponemos el puerto utilizado por Squid
EXPOSE 3128/tcp
EXPOSE 3129/tcp
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
