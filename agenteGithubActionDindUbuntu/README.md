# agenteGithubActionDindUbuntu

[GitHub Actions](https://github.com/features/actions) self-hosted runner sobre Ubuntu 24.04 con Docker-in-Docker.

## Contenido

- Ubuntu 24.04
- Node.js 22 + npm
- Docker CE (storage driver VFS)
- GitHub Actions Runner v2.316.1

## Construir

```bash
docker build -t github-runner-dind .
```

## Ejecutar

```bash
docker run -d \
  --privileged \
  -e RUNNER_CFG_PAT=tu-pat \
  -e RUNNER_REPOSITORY_URL=https://github.com/tu-org/tu-repo \
  -e RUNNER_NAME=mi-runner \
  github-runner-dind
```

Requiere un script `start.sh` que configura y arranca el runner.
