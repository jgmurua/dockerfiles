# squid proxy cache

``` bash
docker build -t squid .
docker run -d --restart=always --publish 3129:3129  --publish 3128:3128  --volume $(pwd)/squid/cache:/var/spool/squid   squid
```

## copiar el cerificado desde el contenedor
docker cp c3cb5a80057f:/usr/local/squid/etc/ssl_cert/squid-self-signed.pem squid-self-signed.pem

## importar Certificado en firefox
si se utiliza en navegadores sin antes agregar el certificado dara error de MITM


![agregar certificado](./11.png)



![agregar certificado](./12.png)



![seleccionar proxy](./13.png)


![seleccionar proxy](./14.png)


![seleccionar proxy](./15.png)



puertos por defecto
3129 https
3128 http

Basado en
https://rasika90.medium.com/how-i-saved-tons-of-gbs-with-https-caching-41550b4ada8a



