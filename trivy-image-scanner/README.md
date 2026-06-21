# trivy-image-scanner

Imagen Docker con [Trivy](https://github.com/aquasecurity/trivy) para análisis de vulnerabilidades en imágenes de contenedores.

## Contenido

- Ubuntu 24.04
- Trivy (Aqua Security)
- Docker CLI (para escanear imágenes locales)
- Base de datos de vulnerabilidades precargada

## Construir

```bash
docker build -t trivy-scanner .
```

## Ejecutar

### Escanear una imagen de Docker Hub

```bash
docker run --rm trivy-scanner image nginx:latest
```

### Escanear una imagen local (montando el socket de Docker)

```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock \
  trivy-scanner image alpine:3.19
```

### Escanear con formato de salida JSON

```bash
docker run --rm trivy-scanner image --format json nginx:latest
```

### Escanear con severidad específica

```bash
docker run --rm trivy-scanner image --severity HIGH,CRITICAL nginx:latest
```

### Escanear un sistema de archivos

```bash
docker run --rm -v $(pwd):/scan trivy-scanner filesystem /scan
```

### Ayuda general

```bash
docker run --rm trivy-scanner --help
```
