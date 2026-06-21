# nginx-3-html

Nginx 1.25-alpine que sirve contenido HTML estático.

## Contenido

- nginx:1.25-alpine
- Configuración personalizada (`nginx.conf`)
- Contenido estático en `html/`

## Construir

```bash
docker build -t nginx-html .
```

## Ejecutar

```bash
docker run -d -p 80:80 nginx-html
```

## Puertos

| Puerto | Descripción |
|---|---|
| 80 | Servidor HTTP |

## Personalización

Coloca tus archivos HTML en el directorio `html/` antes de construir.
