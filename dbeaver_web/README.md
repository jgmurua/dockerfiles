# dbeaver_web

[Cloudbeaver](https://dbeaver.com/cloudbeaver/) — interfaz web de DBeaver para administración de bases de datos.

## Ejecutar

```bash
docker-compose up -d
```

## Puertos

| Puerto | Descripción |
|---|---|
| 8200:8978 | Interfaz web de Cloudbeaver |

## Volúmenes

| Ruta local | Ruta contenedor |
|---|---|
| `./workspace` | `/opt/cloudbeaver/workspace` |
