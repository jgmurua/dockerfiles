# mysql_run_query

Contenedor Alpine para ejecutar consultas SQL contra un servidor MySQL remoto.

## Contenido

- Alpine 3.18
- mysql-client, curl, bash, openssl, gnupg

## Construir

```bash
docker build -t mysql-run-query .
```

## Ejecutar

```bash
docker run --rm \
  -e MYSQL_HOST=server \
  -e MYSQL_DATABASE=dbname \
  -e MYSQL_USER=user \
  -e MYSQL_PASSWORD=pass \
  -e QUERY="SELECT * FROM tabla" \
  mysql-run-query
```

## Variables de entorno

| Variable | Descripción |
|---|---|
| `MYSQL_HOST` | Host del servidor MySQL |
| `MYSQL_DATABASE` | Base de datos |
| `MYSQL_USER` | Usuario |
| `MYSQL_PASSWORD` | Contraseña |
| `QUERY` | Consulta SQL a ejecutar |
