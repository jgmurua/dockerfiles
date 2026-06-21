# utils-ubuntu-dind-gcp

Imagen Ubuntu 24.04 con Docker-in-Docker y herramientas Google Cloud.

## Contenido

- Ubuntu 24.04
- Docker CE + Buildx (storage driver VFS)
- Google Cloud SDK, AWS CLI, Terraform (tfswitch)
- kubectl, Helm, MariaDB client
- vim, git, jq, tmux, zip

## Construir

```bash
docker build -t utils-dind-gcp .
```

## Ejecutar

```bash
docker run -d --privileged utils-dind-gcp
```

El contenedor inicia Docker automáticamente y mantiene el shell interactivo.
