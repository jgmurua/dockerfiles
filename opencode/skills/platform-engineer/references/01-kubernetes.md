# Kubernetes Standards

## Manifiestos mínimos recomendados

Para una API web:

- Namespace.
- ServiceAccount.
- Deployment.
- Service.
- ConfigMap.
- Secret placeholder o ExternalSecret.
- HPA si hay métricas.
- PDB si hay más de una réplica.
- NetworkPolicy si el CNI lo soporta.
- Ingress/Gateway opcional.

## Deployment checklist

- `replicas >= 2` para producción.
- `revisionHistoryLimit` entre 3 y 10.
- `strategy.rollingUpdate.maxUnavailable: 0` para APIs críticas.
- `resources.requests` y `limits`.
- `readinessProbe` para controlar entrada de tráfico.
- `livenessProbe` para reinicio de contenedor muerto.
- `startupProbe` para apps con arranque lento.
- `securityContext.runAsNonRoot: true`.
- `allowPrivilegeEscalation: false`.
- `capabilities.drop: ["ALL"]`.
- Root filesystem read-only cuando sea posible.

## Service checklist

- `type: ClusterIP` por defecto.
- Selectors coinciden con labels de pods.
- `port` es puerto del servicio.
- `targetPort` es puerto del contenedor.
- Nombre del puerto: `http`, `grpc`, `metrics`.

## Headless Service

Usar `clusterIP: None` cuando necesitas descubrir pods individuales, por ejemplo:

- StatefulSets.
- Bases de datos.
- Clustering peer-to-peer.
- Servicios donde el cliente balancea.

No usar headless para APIs web comunes salvo necesidad.

## Config y secretos

- Config no sensible: ConfigMap.
- Sensible: Secret, ExternalSecret, SOPS, SealedSecrets o cloud secret manager.
- Evitar variables sueltas sin defaults documentados.
- Montar config como archivos cuando sea más seguro.

## Probes

HTTP API típica:

```yaml
readinessProbe:
  httpGet:
    path: /healthz/ready
    port: http
  initialDelaySeconds: 5
  periodSeconds: 10
  timeoutSeconds: 2
  failureThreshold: 3
livenessProbe:
  httpGet:
    path: /healthz/live
    port: http
  initialDelaySeconds: 20
  periodSeconds: 20
  timeoutSeconds: 2
  failureThreshold: 3
```

Usar `startupProbe` si el arranque puede superar el liveness inicial.

## Requests y limits

Punto de partida para API chica:

```yaml
resources:
  requests:
    cpu: 100m
    memory: 128Mi
  limits:
    cpu: 500m
    memory: 512Mi
```

Ajustar con métricas reales.

## Debug temporal

Crear pod de debug:

```bash
kubectl -n <ns> run netshoot --image=nicolaka/netshoot --restart=Never -- sleep 3600
kubectl -n <ns> exec -it netshoot -- bash
```

Eliminar al final:

```bash
kubectl -n <ns> delete pod netshoot
```

## Rollout

```bash
kubectl -n <ns> rollout status deploy/<name>
kubectl -n <ns> rollout history deploy/<name>
kubectl -n <ns> rollout undo deploy/<name>
```
