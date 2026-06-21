# sqlserver_run_query

Contenedor Ubuntu para ejecutar consultas SQL contra un servidor SQL Server remoto.

## Contenido

- Ubuntu 24.04
- mssql-tools, unixodbc-dev

## Construir

```bash
docker build -t sqlserver-run-query .
```

## Ejecutar

```bash
docker run --rm \
  -e SQL_SERVER_HOST=server \
  -e SQL_DATABASE=dbname \
  -e SQL_USER=user \
  -e SQL_PASSWORD=pass \
  -e QUERY="SELECT * FROM tabla" \
  sqlserver-run-query
```

## Variables de entorno

| Variable | Descripción |
|---|---|
| `SQL_SERVER_HOST` | Host del servidor SQL Server |
| `SQL_DATABASE` | Base de datos |
| `SQL_USER` | Usuario |
| `SQL_PASSWORD` | Contraseña |
| `QUERY` | Consulta SQL a ejecutar |
