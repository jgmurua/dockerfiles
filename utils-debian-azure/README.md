# utils-debian-azure

Imagen Debian Bookworm-slim con herramientas para trabajar con Azure.

## Contenido

- Debian bookworm-slim
- Azure CLI, kubectl, Helm, kubelogin
- vim, git, jq, tmux, zip
- Configuración de SSH y git

## Construir

```bash
docker build -t utils-debian-azure .
```

## Ejecutar

```bash
docker run -it \
  -v $(pwd):/workdir \
  utils-debian-azure
```

## Directorios

| Ruta | Descripción |
|---|---|
| `/workdir` | Directorio de trabajo |
| `/root/.ssh/` | Claves SSH |
| `/pems` | Certificados .pem |
