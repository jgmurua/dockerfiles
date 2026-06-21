# utils-ubuntu-dind-azure

Imagen Ubuntu 24.04 con Docker-in-Docker y herramientas Azure.

## Contenido

- Ubuntu 24.04
- Docker CE + Buildx (storage driver VFS)
- Azure CLI, kubectl, Helm, kubelogin
- vim, git, jq, tmux, zip, python3

## Construir

```bash
docker build -t utils-dind-azure .
```

## Ejecutar

```bash
docker run -d --privileged utils-dind-azure
```

## Directorios

| Ruta | Descripción |
|---|---|
| `/workdir` | Directorio de trabajo |
| `/root/.ssh/` | Claves SSH |
| `/pems` | Certificados .pem |

El contenedor inicia Docker automáticamente y mantiene el shell interactivo.
