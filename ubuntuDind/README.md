# ubuntuDind

Imagen base Ubuntu 24.04 con Docker-in-Docker mínima.

## Contenido

- Ubuntu 24.04
- Docker CE + Buildx (storage driver VFS)
- Utilidades básicas: curl, wget, git, zip, jq, sudo

## Construir

```bash
docker build -t ubuntu-dind .
```

## Ejecutar

```bash
docker run -d --privileged ubuntu-dind
```

El contenedor inicia el daemon de Docker automáticamente y mantiene el shell abierto.
