# SRE Incident Response

## Golden Signals

- Latency: tiempos p50/p95/p99.
- Traffic: requests por segundo, jobs, throughput.
- Errors: tasa de errores, códigos 5xx, exceptions.
- Saturation: CPU, memoria, disco, conexiones, colas.

## SLI/SLO

Ejemplo API:

- SLI disponibilidad: porcentaje de requests HTTP 2xx/3xx/4xx no atribuibles al servidor sobre total.
- SLO: 99.9% mensual.
- Error budget: 0.1% mensual.

## RPO/RTO

- RPO: cuánto dato se puede perder.
- RTO: cuánto tiempo puede tardar la recuperación.

## Manejo de incidente

1. Declarar incidente si hay impacto real o riesgo alto.
2. Nombrar incident commander.
3. Crear canal de comunicación.
4. Estabilizar.
5. Mitigar.
6. Recuperar.
7. Postmortem.

## Comandos iniciales Kubernetes

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide | grep -v Running
kubectl get events -A --sort-by=.lastTimestamp | tail -120
kubectl top nodes
kubectl top pods -A --sort-by=cpu | tail -30
kubectl top pods -A --sort-by=memory | tail -30
```

## Mitigaciones comunes

- Rollback.
- Escalar réplicas.
- Desactivar feature flag.
- Aumentar recursos.
- Redirigir tráfico.
- Reiniciar componente si hay deadlock conocido.

## Postmortem sin culpa

```markdown
# Postmortem

## Resumen

## Timeline

## Impacto

## Detección

## Causa raíz

## Lo que salió bien

## Lo que salió mal

## Acciones correctivas

| Acción | Owner | Fecha | Estado |
|---|---|---|---|
```
