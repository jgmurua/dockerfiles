# platform-engineer OpenCode Skill

Skill extensa para OpenCode orientada a Platform Engineering, Kubernetes, Terraform, Helm, GitOps, observabilidad y SRE.

## Qué incluye

```text
platform-engineer/
├── SKILL.md
├── README.md
├── opencode.example.json
├── references/
├── scripts/
└── templates/
```

## Instalación global

OpenCode busca Skills globales en `~/.config/opencode/skills/<name>/SKILL.md`.

```bash
unzip platform-engineer-skill-extended.zip
mkdir -p ~/.config/opencode/skills
cp -r platform-engineer ~/.config/opencode/skills/platform-engineer
```

O usando el script:

```bash
cd platform-engineer
./scripts/install.sh --global
```

## Instalación por proyecto

OpenCode también busca Skills en `.opencode/skills/<name>/SKILL.md` dentro del proyecto.

```bash
unzip platform-engineer-skill-extended.zip
cd /ruta/a/tu/proyecto
mkdir -p .opencode/skills
cp -r /ruta/al/zip/platform-engineer .opencode/skills/platform-engineer
```

O:

```bash
cd platform-engineer
./scripts/install.sh --project /ruta/a/tu/proyecto
```

## Activar permisos de Skill en OpenCode

Ejemplo mínimo:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "permission": {
    "skill": "allow",
    "read": "allow",
    "grep": "allow",
    "glob": "allow",
    "bash": "ask",
    "edit": "ask"
  }
}
```

Puedes copiar `opencode.example.json` como base.

## Uso esperado

Dentro de OpenCode, pide algo como:

```text
Usa la skill platform-engineer y diagnostica por qué mi pod está en CrashLoopBackOff
```

O:

```text
Usa platform-engineer y generame manifests Kubernetes production-ready para una API en puerto 8080
```

## Diseño de seguridad

La Skill está escrita para:

- Priorizar diagnóstico antes de cambios.
- Pedir confirmación para operaciones destructivas.
- Incluir verificación y rollback.
- Separar plantillas, scripts y referencias.
- Evitar secretos reales en archivos.

## Notas

Los scripts son auxiliares y deben revisarse antes de usarse en producción. Están pensados como aceleradores para diagnóstico y bootstrap, no como reemplazo de procesos de change management.
