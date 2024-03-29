@echo off
REM esta logica toma el path y lo convierte en formato linux
set "variable=%CD%"
set "drive=%variable:~0,1%"
set variable=%variable:~2%
set "variable=%variable:\=/%"

if %drive%==A set "drive=a"
if %drive%==B set "drive=b"
if %drive%==C set "drive=c"
if %drive%==D set "drive=d"
if %drive%==E set "drive=e"
if %drive%==F set "drive=f"
if %drive%==G set "drive=g"
if %drive%==H set "drive=h"
if %drive%==I set "drive=i"
if %drive%==J set "drive=j"
if %drive%==K set "drive=k"
if %drive%==L set "drive=l"
if %drive%==M set "drive=m"
if %drive%==N set "drive=n"
if %drive%==O set "drive=o"
if %drive%==P set "drive=p"
if %drive%==Q set "drive=q"
if %drive%==R set "drive=r"
if %drive%==S set "drive=s"
if %drive%==T set "drive=t"
if %drive%==U set "drive=u"
if %drive%==V set "drive=v"
if %drive%==W set "drive=w"
if %drive%==X set "drive=x"
if %drive%==Y set "drive=y"
if %drive%==Z set "drive=z"

set "variable=/%drive%%variable%"

REM aqui ejecuta el container con mi entorno de trabajo personalizado

docker run -ti -d --privileged --rm --publish 3129:3129  --publish 3128:3128 -v %variable%/squid/cache:/var/spool/squid squid
$container_id = "$(docker ps -q -f 'ancestor=squid')"
REM copia el certificado generado por el container a la carpeta local
docker cp $container_id:/usr/local/squid/etc/ssl_cert/squid-self-signed.pem squid-self-signed.pem
REM copia los certificados para docker
docker cp $container_id:/usr/local/squid/etc/ssl_cert/squid-self-signed.pem ca.pem
docker cp $container_id:/usr/local/squid/etc/ssl_cert/squid-self-signed.key key.pem
docker cp $container_id:/usr/local/squid/etc/ssl_cert/squid-self-signed.crt crt.pem

