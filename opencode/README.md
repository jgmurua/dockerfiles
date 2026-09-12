# opencode-docker

Ejecuta OpenCode dentro de Docker como si fuera un comando local `opencode`, sin instalar OpenCode en el host.

## Construcción

```bash
chmod +x build.sh
./build.sh
```

Esto crea la imagen:

```text
opencode-local:latest
```

La imagen usa Debian slim e instala OpenCode con el instalador oficial de `https://opencode.ai/install`.

## Instalación del wrapper Bash

Agrega el bloque de función del final de este README a `~/.bashrc` y recarga:

```bash
source ~/.bashrc
```

## Configuración persistente

Crea el directorio persistente del wrapper:

```bash
mkdir -p ~/.config/opencode-docker/{config,data,cache,state}
cp env.example ~/.config/opencode-docker/env
chmod 600 ~/.config/opencode-docker/env
```

OpenCode verá sus rutas XDG internas bajo `/home/opencode`, pero se persistirán en el host en:

```text
~/.config/opencode-docker/config  -> /home/opencode/.config/opencode
~/.config/opencode-docker/data    -> /home/opencode/.local/share/opencode
~/.config/opencode-docker/cache   -> /home/opencode/.cache/opencode
~/.config/opencode-docker/state   -> /home/opencode/.local/state/opencode
```

## Variables, providers y modelos

No guardes API keys en el Dockerfile, imagen, repositorio o argumentos de build. Usa archivos env:

```text
~/.config/opencode-docker/env
~/.config/opencode-docker/env.openai
~/.config/opencode-docker/env.openrouter
~/.config/opencode-docker/env.local
~/.config/opencode-docker/env.nvidia
```

OpenCode reconoce claves estándar de provider como `OPENAI_API_KEY` y `OPENROUTER_API_KEY`. La selección de modelo se configura con la clave real `model` en `opencode.json` o, para perfiles, con `OPENCODE_CONFIG_CONTENT` en el env file. Ver `env.example`.

## Perfiles

Por defecto se carga:

```text
~/.config/opencode-docker/env
```

Para usar un perfil:

```bash
OPENCODE_PROFILE=local opencode
# o
opencode-profile local
```

Eso carga `~/.config/opencode-docker/env.local` si existe.

## Uso

```bash
cd ~/repos/terraform-azure
opencode
opencode --help
opencode .
```

Dentro del contenedor el proyecto está en `/workspace`, montado desde tu `$PWD`. Cualquier modificación en `/workspace` modifica directamente `~/repos/terraform-azure` en el host.

## Endpoint local en el host

El wrapper añade:

```text
--add-host=host.docker.internal:host-gateway
```

Así puedes conectar con un `llama-server` u otro endpoint compatible con OpenAI en el host, por ejemplo:

```text
http://host.docker.internal:8080/v1
```

Configura el provider custom en `OPENCODE_CONFIG_CONTENT` como muestra `env.example`.

## Git y SSH

El contenedor se ejecuta con tu mismo UID/GID (`id -u`, `id -g`) para evitar archivos propiedad de root. `git status`, `git diff` y `git log` funcionan sobre `/workspace`.

Para evitar `dubious ownership`, el entrypoint marca únicamente `/workspace` como `safe.directory`; no usa `safe.directory '*'`.

Si tienes `ssh-agent`, el wrapper reenvía `SSH_AUTH_SOCK` al contenedor. No copia claves SSH a la imagen. Si no hay agent, OpenCode sigue arrancando normalmente.

## Seguridad

El wrapper no monta `/var/run/docker.sock`, no usa `--privileged`, no monta `/`, ni monta todo `/home`. Solo monta el proyecto actual, directorios XDG específicos de OpenCode y opcionalmente el socket de `ssh-agent`.

Recuerda que OpenCode podrá leer y modificar el proyecto que montes como `$PWD`.

## Bloque para `~/.bashrc`

```bash
# OpenCode in Docker
opencode() {
  local image="opencode-local:latest"
  local base="${OPENCODE_DOCKER_HOME:-$HOME/.config/opencode-docker}"
  local profile="${OPENCODE_PROFILE:-}"
  local env_file="$base/env"

  if [ -n "$profile" ]; then
    env_file="$base/env.$profile"
  fi

  if ! command -v docker >/dev/null 2>&1; then
    echo "opencode: docker no está instalado o no está en PATH" >&2
    return 127
  fi

  mkdir -p "$base/config" "$base/data" "$base/cache" "$base/state"

  local tty_args=(-i)
  if [ -t 0 ] && [ -t 1 ]; then
    tty_args=(-it)
  fi

  local env_args=()
  if [ -f "$env_file" ]; then
    env_args+=(--env-file "$env_file")
  elif [ -n "$profile" ]; then
    echo "opencode: perfil no encontrado: $env_file" >&2
    return 1
  fi

  local ssh_args=()
  if [ -n "${SSH_AUTH_SOCK:-}" ] && [ -S "$SSH_AUTH_SOCK" ]; then
    ssh_args+=(-v "$SSH_AUTH_SOCK:/ssh-agent" -e SSH_AUTH_SOCK=/ssh-agent)
  fi

  docker run --rm "${tty_args[@]}" \
    --user "$(id -u):$(id -g)" \
    --add-host=host.docker.internal:host-gateway \
    -e HOME=/home/opencode \
    -e XDG_CONFIG_HOME=/home/opencode/.config \
    -e XDG_DATA_HOME=/home/opencode/.local/share \
    -e XDG_CACHE_HOME=/home/opencode/.cache \
    -e XDG_STATE_HOME=/home/opencode/.local/state \
    -e OPENCODE_CONFIG_DIR=/home/opencode/.config/opencode \
    -e GIT_CONFIG_GLOBAL=/home/opencode/.config/opencode/gitconfig \
    "${env_args[@]}" \
    "${ssh_args[@]}" \
    -v "$PWD:/workspace" \
    -v "$base/config:/home/opencode/.config/opencode" \
    -v "$base/data:/home/opencode/.local/share/opencode" \
    -v "$base/cache:/home/opencode/.cache/opencode" \
    -v "$base/state:/home/opencode/.local/state/opencode" \
    -w /workspace \
    "$image" "$@"
}

opencode-profile() {
  if [ $# -lt 1 ]; then
    echo "uso: opencode-profile <perfil> [args...]" >&2
    return 2
  fi
  local profile="$1"
  shift
  OPENCODE_PROFILE="$profile" opencode "$@"
}
```
