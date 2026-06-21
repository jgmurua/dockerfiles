# Command Cheatsheet

## Kubernetes

```bash
kubectl config current-context
kubectl get nodes -o wide
kubectl get pods -A -o wide
kubectl get deploy,sts,ds -A
kubectl get svc,ingress -A
kubectl get pvc,pv -A
kubectl get events -A --sort-by=.lastTimestamp | tail -100
```

## Logs

```bash
kubectl -n <ns> logs deploy/<deploy> --all-containers --tail=200
kubectl -n <ns> logs <pod> -c <container> --previous --tail=200
kubectl -n <ns> logs -l app.kubernetes.io/name=<app> --all-containers -f
```

## Rollouts

```bash
kubectl -n <ns> rollout status deploy/<deploy>
kubectl -n <ns> rollout history deploy/<deploy>
kubectl -n <ns> rollout undo deploy/<deploy>
kubectl -n <ns> rollout restart deploy/<deploy>
```

## Helm

```bash
helm list -A
helm status <release> -n <ns>
helm get values <release> -n <ns>
helm template <release> <chart> -n <ns> -f values.yaml
helm upgrade --install <release> <chart> -n <ns> --create-namespace -f values.yaml --atomic --timeout 10m
helm rollback <release> <revision> -n <ns>
```

## Terraform

```bash
terraform fmt -recursive
terraform init
terraform validate
terraform plan -out=tfplan
terraform show tfplan
terraform apply tfplan
terraform plan -refresh-only
```

## AWS/GCP/Azure

```bash
aws sts get-caller-identity
aws eks update-kubeconfig --region <region> --name <cluster>

gcloud auth list
gcloud config list
gcloud container clusters get-credentials <cluster> --region <region>

az account show
az aks get-credentials -g <resource-group> -n <cluster>
```
