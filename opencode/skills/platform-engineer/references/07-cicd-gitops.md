# CI/CD y GitOps

## Pipeline recomendado para Terraform

1. `fmt`.
2. `validate`.
3. `plan`.
4. Publicar plan como artefacto.
5. Aprobación manual para prod.
6. `apply` del plan aprobado.

## Pipeline recomendado para Kubernetes/Helm

1. Lint YAML.
2. `helm lint`.
3. `helm template`.
4. `kubectl apply --dry-run=server` contra cluster de validación si existe.
5. Deploy.
6. `kubectl rollout status`.

## GitHub Actions

Buenas prácticas:

- Usar OIDC para cloud, no access keys estáticas.
- Pinnear actions por versión mayor o SHA si hay alta seguridad.
- No imprimir secretos.
- `concurrency` por ambiente.
- Separar branches y environments.

## Forgejo Actions

Similar a GitHub Actions, pero verificar compatibilidad de actions externas y runners.

Checklist de migración:

- Reemplazar actions no compatibles.
- Confirmar labels del runner.
- Confirmar secrets/variables.
- Confirmar permisos de checkout.
- Confirmar cache/artifacts.

## ArgoCD

Estructura sugerida:

```text
gitops/
├── apps/
│   └── my-app/
│       ├── base/
│       └── overlays/
│           ├── dev/
│           └── prod/
└── platform/
    ├── observability/
    └── ingress/
```

Reglas:

- Una app por componente o dominio.
- Sync waves para dependencias.
- Evitar auto-prune en recursos críticos sin revisión.
- Secrets gestionados fuera del repo o cifrados.

## Rollback

- Git revert para GitOps.
- `helm rollback` para Helm directo.
- `kubectl rollout undo` para deployments simples.
- Terraform: revertir commit y aplicar plan; no editar state manualmente salvo emergencia controlada.
