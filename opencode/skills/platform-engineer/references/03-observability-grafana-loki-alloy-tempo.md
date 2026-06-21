# Observabilidad: Grafana, Loki, Alloy y Tempo

## Objetivo

Proveer una base operativa para logs, métricas y trazas en Kubernetes.

## Arquitectura recomendada

```text
Pods -> Alloy -> Loki
Apps -> OTLP -> Alloy/Collector -> Tempo
Prometheus/kube-state-metrics -> Grafana
Grafana -> Loki/Tempo/Prometheus
```

## Loki

### Local/k3s

- Modo simple.
- Filesystem storage.
- PVC.
- Retención corta.

### EKS/producción

- S3 para chunks/ruler/admin si aplica.
- IRSA o Pod Identity.
- Requests/limits.
- Compactor configurado.
- Retención definida.

## Alloy

Alloy puede recolectar logs de pods con `discovery.kubernetes` y `loki.source.kubernetes`.

Labels útiles:

- namespace.
- pod.
- container.
- app.
- node.

## LogQL útil

Errores por namespace:

```logql
{namespace="default"} |= "error"
```

Errores JSON:

```logql
{app="api"} | json | level="error"
```

Conteo de errores:

```logql
sum by (app) (count_over_time({namespace="default"} |= "error" [5m]))
```

## Tempo

### Instrumentación

- Usar OpenTelemetry SDK en la aplicación.
- Exportar por OTLP HTTP/gRPC.
- Incluir `service.name` y `deployment.environment`.

### Correlación logs/traces

Incluir `trace_id` en logs. Luego en Grafana se puede enlazar de Loki a Tempo.

## Grafana

Datasources típicos:

- Loki: `http://loki:3100`.
- Tempo: `http://tempo:3100` o service chart correspondiente.
- Prometheus: `http://prometheus-server:80` o kube-prometheus-stack.

## Troubleshooting stack observabilidad

```bash
kubectl -n observability get pods -o wide
kubectl -n observability get svc,pvc
kubectl -n observability logs deploy/alloy --tail=200
kubectl -n observability logs deploy/grafana --tail=200
kubectl -n observability port-forward svc/grafana 3000:80
```

Loki readiness:

```bash
kubectl -n observability port-forward svc/loki 3100:3100
curl -s http://localhost:3100/ready
```

## Dashboard mínimo

Paneles recomendados:

- Logs por namespace/app.
- Error count por app.
- Top pods por volumen de logs.
- Últimos eventos Kubernetes.
- Traces por servicio.
- Latencia p95/p99 si hay métricas/traces.
