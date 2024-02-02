### Funciona ok

# Mysql Run Query Dockerfile

## Build

```bash

docker build -t mysql_run_query -f Dockerfile .
docker tag mysql_run_query:latest mysql_run_query:alpine

```

## Run
### notar que en QUERY se puede poner la consulta que se desee ejecutar en la base de datos en este caso lista las bases de datos

```bash
docker run --rm  -e "MYSQL_HOST=host.com" -e "MYSQL_DATABASE=admin" -e "MYSQL_USER=dba" -e "MYSQL_PASSWORD=*****" -e "QUERY=SELECT name, database_id, create_date FROM sys.databases" mysql_run_query:alpine
```

## ejecuta un contenedor con mysql server (docker) para hacer pruebas

```bash
docker run --name mysql -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=example -e MYSQL_USER=example -e MYSQL_PASSWORD=example -d mysql:5.7
```