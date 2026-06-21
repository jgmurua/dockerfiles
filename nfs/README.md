# nfs

Servidor [NFS](https://es.wikipedia.org/wiki/Network_File_System) sobre Alpine, con un Nginx que sirve el mismo contenido vía HTTP.

## Servicios

| Servicio | Puerto | Descripción |
|---|---|---|
| `nfs-server` | 2049 | Servidor NFSv3/v4 |
| `nginx` | 8870:80 | Servidor web del contenido compartido |

## Ejecutar

```bash
docker-compose up -d
```

## Volúmenes

| Ruta local | Ruta NFS |
|---|---|
| `./nfs` | `/mnt/nfs_share` |

## Uso del cliente NFS

```bash
mount -t nfs -o vers=4 <server-ip>:/mnt/nfs_share /local/mount
```

## Puertos NFS expuestos

| Puerto | Protocolo |
|---|---|
| 2049/tcp | NFS |
| 111/tcp | rpcbind |
| 111/udp | rpcbind |
