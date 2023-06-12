Docker en Docker (DinD) en Ubuntu + azcli kubectl helm jq zip unzip git curl wget + buildx 
==================================


Uso
---
```bash

# Construir imagen
docker build -t utils-azure .

# Correr docker en docker
docker run -it --privileged utils-azure docker

# Correr Bash
docker exec -it --privileged utils-azure bash

```


