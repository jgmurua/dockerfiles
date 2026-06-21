# jenkins-agent-xx

Agente [Jenkins Inbound Agent](https://plugins.jenkins.io/inbound-agent/) con herramientas de infraestructura.

## Contenido

- `jenkins/inbound-agent:lts`
- Terraform 1.4 + tfswitch, kubectl, Helm
- Azure CLI, AWS CLI
- Python 3.9, vim, git, jq, cowsay

## Construir

```bash
docker build -t jenkins-agent-xx .
```

## Ejecutar

```bash
docker run -d \
  -e JENKINS_URL=https://tu-jenkins.com \
  -e JENKINS_SECRET=tu-secret \
  -e JENKINS_AGENT_NAME=mi-agente \
  jenkins-agent-xx
```
