# cronicle

Imagen [Cronicle](https://github.com/jhuckaby/Cronicle) (job scheduler) sobre Node.js 22.

## Contenido

- Node.js 22.7.0-bullseye-slim
- Cronicle (última versión)
- Ansible, Python 3 boto3, AWS CLI
- curl, unzip, jq, git

## Construir

```bash
docker build -t cronicle .
```

## Ejecutar (docker-compose)

```bash
docker-compose up -d
```

## Puertos

| Puerto | Descripción |
|---|---|
| 3012 | Interfaz web de Cronicle |

## Volúmenes

| Volumen | Ruta |
|---|---|
| `cronicle_data` | `/opt/cronicle/data` |
| `cronicle_logs` | `/opt/cronicle/logs` |
| `cronicle_plugins` | `/opt/cronicle/plugins` |
| `cronicle_backup` | `/opt/cronicle/backup` |
