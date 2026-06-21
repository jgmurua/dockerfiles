# utils-ubuntu-dind-multi

Imagen Ubuntu 24.04 multi-cloud con Docker-in-Docker: Azure, GCP, AWS.

## Contenido

- Ubuntu 24.04
- Docker CE + Buildx (storage driver VFS)
- Azure CLI, Google Cloud SDK, AWS CLI
- Terraform (tfswitch), kubectl, Helm, kubelogin
- OpenLens (Kubernetes IDE) con alias `lens`
- vim, git, jq, tmux, zip, python3
- Configuración de SSH y git

## Construir

```bash
docker build -t utils-dind-multi .
```

## Ejecutar

```bash
docker run -d --privileged \
  -e DISPLAY=host.docker.internal:0.0 \
  utils-dind-multi
```

## Directorios

| Ruta | Descripción |
|---|---|
| `/workdir` | Directorio de trabajo |
| `/root/.ssh/` | Claves SSH |
| `/pems` | Certificados .pem |

## OpenLens

Para usar OpenLens, se necesita un servidor X11. El alias `lens` inicia OpenLens con `--no-sandbox`.
