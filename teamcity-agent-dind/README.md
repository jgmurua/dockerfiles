# teamcity-agent-dind

Agente [TeamCity](https://www.jetbrains.com/teamcity/) 2023.05.2 sobre Ubuntu 24.04 con Docker-in-Docker.

## Contenido

- Ubuntu 24.04
- Docker + Buildx (storage driver VFS)
- OpenJDK 8 (JRE + JDK)
- TeamCity Agent 2023.05.2

## Construir

```bash
docker build -t teamcity-agent-dind .
```

## Ejecutar

```bash
docker run -d \
  --privileged \
  -e TEAMCITY_SERVER_URL=https://tu-teamcity.com \
  -e TEAMCITY_AGENT_NAME=mi-agente \
  teamcity-agent-dind
```

## Variables de entorno

| Variable | Descripción |
|---|---|
| `TEAMCITY_SERVER_URL` | URL del servidor TeamCity |
| `TEAMCITY_AGENT_NAME` | Nombre del agente |
