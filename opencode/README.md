# opencode

Imagen Ubuntu 24.04 con [OpenCode](https://opencode.ai) CLI y herramientas cloud/ops.

## Contenido

- Ubuntu 24.04
- OpenCode (`npm install -g opencode-ai`)
- Python 3, Node.js
- Terraform (tfswitch), AWS CLI, kubectl, Helm
- Skill de Platform Engineer precargado

## Construir

```bash
docker build -t opencode-cli .
```

## Ejecutar

```bash
docker run -it \
  -v $(pwd):/workspace \
  -e OPENCODE_API_KEY=tu-api-key \
  opencode-cli
```

## Entrypoint

El contenedor ejecuta `opencode` directamente. Puedes pasar argumentos:

```bash
docker run -it opencode-cli --help
```
