# mssql

Stack SQL Server 2022 con carga de esquemas inicial y cliente de consultas.

## Servicios

| Servicio | Imagen | Puerto |
|---|---|---|
| `sqlserver` | mcr.microsoft.com/mssql/server:2022-latest | 1433 |
| `sql-loader` | mcr.microsoft.com/mssql-tools | — |
| `sqlclient` | mcr.microsoft.com/mssql-tools | — |

## Ejecutar

```bash
docker-compose up -d
```

## Variables de entorno

| Variable | Valor por defecto |
|---|---|
| `ACCEPT_EULA` | Y |
| `MSSQL_SA_PASSWORD` | YourStrongPassword!123 |
| `SQLCMDPASSWORD` | YourStrongPassword!123 |

## Volúmenes

| Ruta local | Ruta contenedor |
|---|---|
| `./init-scripts` | `/var/opt/mssql/scripts` |

## Esquema inicial

Coloca scripts `.sql` en `./init-scripts/init-db.sql` para que `sql-loader` los ejecute automáticamente al iniciar.
