# agenteAzureDindUbuntu

Agente de [Azure Pipelines](https://azure.microsoft.com/en-us/products/devops/pipelines/) sobre Ubuntu 23.10 con Docker-in-Docker.

## Contenido

- Ubuntu 23.10
- Docker CE (storage driver VFS)
- Azure Pipelines Agent

## Construir

```bash
docker build -t agente-azure-dind .
```

## Ejecutar

```bash
docker run -d \
  --privileged \
  -e AZP_URL=https://dev.azure.com/tu-organizacion \
  -e AZP_TOKEN=tu-token \
  -e AZP_AGENT_NAME=mi-agente \
  agente-azure-dind
```

Requiere un script `start.sh` que configura y arranca el agente de Azure.
