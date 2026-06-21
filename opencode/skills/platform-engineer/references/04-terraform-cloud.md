# Terraform Multi-Cloud Standards

## Estructura base

```text
terraform/
├── versions.tf
├── providers.tf
├── variables.tf
├── main.tf
├── outputs.tf
├── locals.tf
└── envs/
    ├── dev.tfvars
    └── prod.tfvars
```

## Comandos seguros

```bash
terraform fmt -recursive
terraform init
terraform validate
terraform plan -out=tfplan
terraform show tfplan
terraform apply tfplan
```

## Revisión del plan

Buscar:

- `-/+` replacements.
- Deletes no esperados.
- Cambios de IAM amplios.
- Exposición pública.
- Cambios en discos, buckets o bases de datos.
- Reemplazo de nodos/cluster.

## Backend remoto

AWS S3 + DynamoDB lock:

```hcl
terraform {
  backend "s3" {
    bucket         = "my-tf-state"
    key            = "platform/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
```

GCP Cloud Storage:

```hcl
terraform {
  backend "gcs" {
    bucket = "my-tf-state"
    prefix = "platform/dev"
  }
}
```

Azure Storage:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "tfstateaccount"
    container_name       = "tfstate"
    key                  = "platform/dev.tfstate"
  }
}
```

## Variables sensibles

Usar:

```hcl
variable "token" {
  type      = string
  sensitive = true
}
```

No imprimir secretos en outputs.

## Drift

Detectar:

```bash
terraform plan -refresh-only
```

Aplicar reconciliación solo después de entender quién cambió qué y por qué.

## Módulos

Un módulo debe tener:

- Inputs mínimos.
- Outputs útiles.
- README.
- Ejemplo.
- Versionado.

Evitar módulos gigantes que mezclan red, compute, IAM y apps sin límites claros.
