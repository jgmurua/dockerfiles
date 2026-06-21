# squid

Proxy [Squid 6.1](http://www.squid-cache.org/) compilado desde fuente sobre Ubuntu 24.04 con soporte SSL.

## Contenido

- Ubuntu 24.04
- Squid 6.1 (compilado con OpenSSL + SSL CRTD)
- Certificado autofirmado para inspección SSL
- Configuración personalizada (`squid.conf`)

## Construir

```bash
docker build -t squid-proxy .
```

## Ejecutar

```bash
docker run -d \
  -p 3128:3128 \
  -p 3129:3129 \
  squid-proxy
```

## Puertos

| Puerto | Descripción |
|---|---|
| 3128/tcp | Proxy HTTP/HTTPS |
| 3129/tcp | Proxy con SSL |

## Argumentos de build

| Argumento | Descripción | Default |
|---|---|---|
| `country_code` | Código de país para certificado | AR |
| `country` | País | Argentina |
| `statename` | Estado/Provincia | Buenos Aires |
| `namecert` | Nombre del certificado | some name |
| `email` | Email | youremail@.com |
