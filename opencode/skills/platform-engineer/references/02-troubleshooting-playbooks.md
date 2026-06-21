# Kubernetes Troubleshooting Playbooks

## Recolección inicial

```bash
kubectl config current-context
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get events -A --sort-by=.lastTimestamp | tail -120
```

## Pod no arranca

```bash
NS=<namespace>
POD=<pod>
kubectl -n "$NS" describe pod "$POD"
kubectl -n "$NS" logs "$POD" --all-containers --tail=200
kubectl -n "$NS" logs "$POD" --all-containers --previous --tail=200
kubectl -n "$NS" get events --sort-by=.lastTimestamp | tail -80
```

Interpretación:

- `OOMKilled`: aumentar memoria o corregir fuga.
- `CreateContainerConfigError`: Secret/ConfigMap/env inválido.
- `CrashLoopBackOff`: app termina o probe mata el proceso.
- `ImagePullBackOff`: imagen/registry/credenciales.
- `RunContainerError`: runtime, permisos, command o volume.

## Pod reinicia por probes

```bash
kubectl -n <ns> describe pod <pod> | grep -A6 -i probe
kubectl -n <ns> logs <pod> --previous --tail=200
```

Acciones:

- Verificar endpoint de health.
- Aumentar `initialDelaySeconds` o usar `startupProbe`.
- Confirmar que app escucha en el puerto esperado.

## Service no tiene endpoints

```bash
kubectl -n <ns> get svc <svc> -o yaml
kubectl -n <ns> get endpoints <svc> -o yaml
kubectl -n <ns> get endpointslice -l kubernetes.io/service-name=<svc> -o yaml
kubectl -n <ns> get pods --show-labels
```

Causa común: selector no coincide con labels.

## Error de DNS

```bash
kubectl -n <ns> run dns-test --image=registry.k8s.io/e2e-test-images/agnhost:2.45 --restart=Never -- sleep 3600
kubectl -n <ns> exec dns-test -- nslookup kubernetes.default
kubectl -n <ns> exec dns-test -- nslookup <svc>.<ns>.svc.cluster.local
kubectl -n kube-system logs deploy/coredns --tail=200
```

## PVC Pending

```bash
kubectl get storageclass
kubectl -n <ns> describe pvc <pvc>
kubectl get pv
kubectl get events -A --sort-by=.lastTimestamp | grep -i pvc
```

Revisar:

- StorageClass default.
- CSI driver instalado.
- Zona del volumen vs zona del nodo.
- Quota.

## Nodo NotReady

```bash
kubectl describe node <node>
kubectl get events -A --field-selector involvedObject.kind=Node --sort-by=.lastTimestamp
```

Revisar en nodo:

```bash
sudo journalctl -u kubelet -n 200 --no-pager
sudo crictl ps -a
sudo crictl logs <container-id>
```

## Ingress 404

- Host no coincide.
- Path no coincide.
- IngressClass incorrecta.
- Service sin endpoints.
- Controller no instalado.

Comandos:

```bash
kubectl get ingress -A
kubectl describe ingress -n <ns> <name>
kubectl get ingressclass
kubectl -n <controller-ns> logs deploy/<controller> --tail=200
```

## LoadBalancer Pending

- En cloud: controller/cloud provider no provisiona LB.
- En local: falta MetalLB o cloud-provider-kind.
- En EKS: subnets no etiquetadas o permisos del controller.

```bash
kubectl -n <ns> describe svc <svc>
kubectl get events -A --sort-by=.lastTimestamp | tail -100
```
