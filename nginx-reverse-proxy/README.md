# nginx-reverse-proxy

Nginx 1.25-alpine como proxy inverso con autenticación básica.

## Contenido

- nginx:1.25-alpine
- apache2-utils (htpasswd)
- Autenticación básica configurable por variables de entorno

## Construir

```bash
docker build -t nginx-auth-proxy .
```

## Ejecutar

```bash
docker run -d -p 80:80 \
  -e USERNAME=admin \
  -e PASSWORD=secreto \
  -e PROXY_URL=http://backend:3000 \
  -e PORT=80 \
  nginx-auth-proxy
```

## Variables de entorno

| Variable | Descripción |
|---|---|
| `USERNAME` | Usuario para autenticación |
| `PASSWORD` | Contraseña para autenticación |
| `PROXY_URL` | URL del backend a redirigir |
| `PORT` | Puerto de escucha |

## Puertos

| Puerto | Descripción |
|---|---|
| 80 | Proxy HTTP con auth básica |
