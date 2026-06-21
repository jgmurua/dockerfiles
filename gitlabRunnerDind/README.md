# gitlabRunnerDind

[GitLab Runner](https://docs.gitlab.com/runner/) sobre Ubuntu 24.04 con Docker-in-Docker.

## Contenido

- Ubuntu 24.04
- Docker + Buildx (storage driver VFS)
- Node.js 18 + npm
- AWS CLI, Terraform (tfswitch), kubectl, Helm

## Construir

```bash
docker build -t gitlab-runner-dind .
```

## Ejecutar

```bash
docker run -d \
  --privileged \
  -e GITLAB_RUNNER_TOKEN=tu-token \
  -e GITLAB_URL=https://gitlab.com \
  gitlab-runner-dind
```

El contenedor inicia el daemon de Docker y mantiene el runner listo para trabajos CI/CD.
