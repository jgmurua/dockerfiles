Agente AzureDevops en container Ubuntu con Docker incluido (version minima 250Mb)
puede construir imagenes docker, correr contenedores, funciona con testcontainers

## Build

```bash
docker build -t agentegithubactiondindubuntu .

docker run -it --rm --name agentegithubactiondindubuntu agentegithubactiondindubuntu 

docker build --build-arg RUNNER_VERSION=2.312.0 --tag agentegithubactiondindubuntu .

docker run -e GH_TOKEN='myPatToken' -e GH_OWNER='orgName' -e GH_REPOSITORY='repoName' -d image-name

docker run -e GH_TOKEN='***' -e GH_OWNER='jgmurua' -e GH_REPOSITORY='***' -d agentegithubactiondindubuntu

```