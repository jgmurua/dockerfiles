Docker en Docker (DinD) en Ubuntu
==================================
Este contenedor permite ejecutar Docker dentro de un contenedor Docker, crear imagenes multi-arquitectura, correr contenedores, etc.

Uso
---
```bash

# Construir imagen
docker build -t ubuntu-dind .

# Correr docker en docker
docker run -it --privileged --name ubuntu-dind docker

# Correr docker en docker buildeando una imagen multi-arquitectura
docker run -it --privileged --name ubuntu-dind docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t someTag .

```


