# utils-ubuntu-azure

Imagen Ubuntu 24.04 con herramientas para trabajar con Azure.

## Contenido

- Ubuntu 24.04
- Azure CLI, kubectl, Helm, kubelogin
- vim, git, jq, tmux, zip, python3
- Configuración de SSH y git

## Construir

```bash
docker build -t utils-ubuntu-azure .
```

## Ejecutar

```bash
docker run -it \
  -v $(pwd):/workdir \
  utils-ubuntu-azure
```

## Directorios

| Ruta | Descripción |
|---|---|
| `/workdir` | Directorio de trabajo |
| `/root/.ssh/` | Claves SSH |
| `/pems` | Certificados .pem |
