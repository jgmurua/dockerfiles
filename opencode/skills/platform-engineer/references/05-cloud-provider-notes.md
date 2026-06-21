# Cloud Provider Notes

## AWS / EKS

### Bootstrap

```bash
aws sts get-caller-identity
aws eks update-kubeconfig --region <region> --name <cluster>
kubectl get nodes -o wide
```

### Componentes frecuentes

- AWS Load Balancer Controller.
- EBS CSI Driver.
- EFS CSI Driver si se requieren volúmenes compartidos.
- ExternalDNS.
- cert-manager.
- Karpenter o Cluster Autoscaler.
- IRSA o EKS Pod Identity.

### Errores frecuentes

- Subnets sin tags para LoadBalancer.
- IAM role del controller sin permisos.
- Security group bloquea health checks.
- Node IAM role sin permisos para ECR/EBS.

## GCP / GKE

### Bootstrap

```bash
gcloud auth list
gcloud config set project <project>
gcloud container clusters get-credentials <cluster> --region <region>
kubectl get nodes -o wide
```

### Componentes frecuentes

- Workload Identity.
- Artifact Registry.
- Cloud NAT para nodos privados.
- GCE Ingress o Gateway.
- Secret Manager CSI Driver.

### Errores frecuentes

- IAM binding faltante para Workload Identity.
- Firewall bloquea health checks.
- Subnet sin secondary ranges para pods/services.
- Quota regional de CPU/GPU/IP.

## Azure / AKS

### Bootstrap

```bash
az account show
az aks get-credentials -g <resource-group> -n <cluster>
kubectl get nodes -o wide
```

### Componentes frecuentes

- Managed Identity.
- Azure CNI Overlay.
- Application Gateway Ingress Controller o NGINX.
- Azure Disk/File CSI.
- Key Vault CSI Driver.

### Errores frecuentes

- Managed Identity sin rol sobre subnet/registry.
- NSG bloquea tráfico.
- Azure Policy impide privilegios.
- Quotas regionales.
