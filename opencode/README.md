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

El contenedor ejecuta `opencode` por defecto. Si pasas un comando como `bash`,
ejecuta ese comando en su lugar:

```bash
docker run -it opencode-cli bash
```

Puedes pasar argumentos a opencode:

```bash
docker run -it opencode-cli --help
```

## Persistir datos de OpenCode

OpenCode guarda configuraciones, skills y datos en `~/.config/opencode`.
Para conservarlos entre ejecuciones, monta un volumen:

```bash
docker run -it \
  -v $(pwd):/workspace \
  -v opencode-data:/root/.config/opencode \
  -e OPENCODE_API_KEY=tu-api-key \
  opencode-cli
```

También puedes bind-mount un directorio local:

```bash
docker run -it \
  -v $(pwd):/workspace \
  -v $HOME/.config/opencode:/root/.config/opencode \
  -e OPENCODE_API_KEY=tu-api-key \
  opencode-cli
```
