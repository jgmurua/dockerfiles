# act-ubuntu-dind

Imagen Ubuntu 24.04 con Docker-in-Docker para [Gitea Act Runner](https://gitea.com/gitea/act_runner).

## Contenido

- Docker + Buildx (storage driver VFS)
- Node.js 20 + npm
- Google Cloud SDK, Azure CLI, AWS CLI
- Terraform (vía tfswitch), kubectl, Helm
- Gitea Act Runner (nightly)

## Construir

```bash
docker build -t act-ubuntu-dind \
  --build-arg GITEA_INSTANCE_URL=https://tu-gitea.com \
  --build-arg GITEA_RUNNER_REGISTRATION_TOKEN=tu-token .
```

## Ejecutar

```bash
docker run -d \
  --privileged \
  -e GITEA_INSTANCE_URL=https://tu-gitea.com \
  -e GITEA_RUNNER_REGISTRATION_TOKEN=tu-token \
  act-ubuntu-dind
```

## Variables de entorno

| Variable | Descripción |
|---|---|
| `GITEA_INSTANCE_URL` | URL de la instancia de Gitea |
| `GITEA_RUNNER_REGISTRATION_TOKEN` | Token de registro del runner |
