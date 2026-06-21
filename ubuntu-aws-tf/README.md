# ubuntu-aws-tf

Ubuntu-based Docker image with AWS CLI, Terraform (via tfswitch), Helm, kubectl, Docker-in-Docker, and common DevOps tooling.

## Included Tools

| Tool | Description |
|------|-------------|
| **AWS CLI v2** | Amazon Web Services command-line interface |
| **Terraform** | Infrastructure as Code (via tfswitch) |
| **Helm** | Kubernetes package manager |
| **kubectl** | Kubernetes command-line tool |
| **Docker** | Container runtime with DinD support |
| **Docker Buildx** | Multi-platform image builder |
| **Python 3** | Python runtime + pip |
| **Node.js / npm** | JavaScript runtime |
| **Go** | Go programming language |
| **MariaDB Client** | MariaDB/MySQL CLI |
| **jq, git, curl, wget, vim, tmux** | Common utilities |

## Build

```bash
docker build -t ubuntu-aws-tf .
```

## Usage

Run with Docker-in-Docker (DinD) support and a workspace mount:

```bash
docker run --privileged -it \
  -v "$PWD:/workspace" \
  -w /workspace \
  ubuntu-aws-tf
```

The entrypoint will start the Docker daemon automatically and configure Buildx.

### Select Terraform Version

```bash
tfswitch 1.9.8  # or any desired version
```

## Environment Variables

| Variable | Default | Description |
|----------|---------|-------------|
| `DEBIAN_FRONTEND` | `noninteractive` | Avoids interactive prompts during package installs |
| `DOCKER_CLI_EXPERIMENTAL` | `enabled` | Enables experimental Docker CLI features |

## Volumes

- `/workspace` — Recommended mount point for your project files
