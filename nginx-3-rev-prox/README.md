# nginx-3-rev-prox

Nginx 1.25-alpine configurado como proxy inverso.

## Contenido

- nginx:1.25-alpine
- Configuración personalizada (`nginx.conf`)

## Construir

```bash
docker build -t nginx-rev-prox .
```

## Ejecutar

```bash
docker run -d -p 80:80 nginx-rev-prox
```

## Puertos

| Puerto | Descripción |
|---|---|
| 80 | Proxy HTTP |

La configuración del proxy se define en `nginx.conf`. Edítalo para apuntar al backend deseado.
