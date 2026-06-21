# Runbook Template

## Servicio

Nombre:
Owner:
Repositorio:
Ambiente:
Namespace:

## Descripción

Qué hace el servicio y cuáles son sus dependencias.

## SLO/SLI

- SLI:
- SLO:
- Error budget:

## Dashboards

- Grafana:
- Logs:
- Traces:

## Alertas

| Alerta | Severidad | Acción |
|---|---|---|

## Diagnóstico rápido

```bash
kubectl -n <ns> get pods -o wide
kubectl -n <ns> get events --sort-by=.lastTimestamp | tail -80
kubectl -n <ns> logs deploy/<deploy> --all-containers --tail=200
```

## Procedimientos

### Restart seguro

```bash
kubectl -n <ns> rollout restart deploy/<deploy>
kubectl -n <ns> rollout status deploy/<deploy>
```

### Rollback

```bash
kubectl -n <ns> rollout history deploy/<deploy>
kubectl -n <ns> rollout undo deploy/<deploy>
```

## Dependencias

- DB:
- Queue:
- APIs externas:
- Storage:

## Contactos

- Primary:
- Secondary:
