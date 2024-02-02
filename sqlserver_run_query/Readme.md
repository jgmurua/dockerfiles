### Funciona ok

# SQL Server Run Query Dockerfile

## Build

```bash
docker build -t sqlserver_run_query .
docker tag sqlserver_run_query:latest sqlserver_run_query:ubuntu20.04

docker build -t sqlserver_run_query -f Dockerfile_alpine .
docker tag sqlserver_run_query:latest sqlserver_run_query:alpine

```

## Run
### notar que en QUERY se puede poner la consulta que se desee ejecutar en la base de datos en este caso lista las bases de datos

```bash
docker run --rm  -e "SQL_SERVER_HOST=host.com" -e "SQL_DATABASE=admin" -e "SQL_USER=dba" -e "SQL_PASSWORD=*****" -e "QUERY=SELECT name, database_id, create_date FROM sys.databases" sqlserver_run_query:alpine
```
