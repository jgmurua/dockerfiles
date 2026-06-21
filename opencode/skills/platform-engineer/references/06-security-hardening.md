# Kubernetes Security Hardening

## Principios

- Menor privilegio.
- No root.
- No privileged.
- No hostPath salvo justificación.
- NetworkPolicy por defecto deny cuando el CNI lo soporte.
- Secrets fuera de Git o cifrados.
- Auditoría de RBAC.

## securityContext recomendado

```yaml
securityContext:
  runAsNonRoot: true
  seccompProfile:
    type: RuntimeDefault
containers:
  - name: app
    securityContext:
      allowPrivilegeEscalation: false
      readOnlyRootFilesystem: true
      capabilities:
        drop:
          - ALL
```

Si la imagen requiere escribir en `/tmp`, montar `emptyDir`:

```yaml
volumeMounts:
  - name: tmp
    mountPath: /tmp
volumes:
  - name: tmp
    emptyDir: {}
```

## RBAC mínimo

- Crear ServiceAccount por app.
- No usar `default` en producción.
- Evitar ClusterRole salvo necesidad.
- Usar Role namespace-scoped.

## NetworkPolicy base

- Default deny ingress.
- Permitir solo desde ingress controller o namespaces necesarios.
- Permitir egress explícito si hay política de egress.

## Secret management

Opciones:

- External Secrets Operator.
- SealedSecrets.
- SOPS + age/KMS.
- CSI Secret Store.

Nunca commitear secretos reales.

## Checks rápidos

```bash
kubectl get pods -A -o jsonpath='{range .items[*]}{.metadata.namespace}{"/"}{.metadata.name}{" runAsNonRoot="}{.spec.securityContext.runAsNonRoot}{"\n"}{end}'
kubectl get clusterrolebinding -o wide
kubectl get pods -A -o json | jq '.. | objects | select(has("privileged"))'
```

## Riesgos habituales

- `hostNetwork: true`.
- `privileged: true`.
- `runAsUser: 0`.
- `automountServiceAccountToken: true` innecesario.
- Wildcards en RBAC.
- Secrets como env vars en apps que hacen dumps.
