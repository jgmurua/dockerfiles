# sqltools

Escritorio Linux con herramientas SQL: DBeaver CE, MySQL client, y utilidades.

## Contenido

- `lscr.io/linuxserver/doublecommander:latest`
- DBeaver CE (última versión)
- mysql-client, gnome-terminal, kate

## Ejecutar (docker-compose)

```bash
docker-compose up -d
```

## Puertos

| Puerto | Descripción |
|---|---|
| 3000 | Interfaz web del escritorio |

## Variables de entorno

| Variable | Descripción |
|---|---|
| `PUID` | ID de usuario (default: 1000) |
| `PGID` | ID de grupo (default: 1000) |
| `TZ` | Zona horaria |

## Volúmenes

| Ruta local | Ruta contenedor |
|---|---|
| `./workbench/config` | `/config` |
| `./workbench/data` | `/data` |
