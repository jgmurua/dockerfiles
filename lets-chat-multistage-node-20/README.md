# lets-chat-multistage-node-20

[Lets-Chat](https://github.com/sdelements/lets-chat) — chat autocontenido con build multi-stage y Node.js 20.

## Construir

```bash
docker build -t lets-chat .
```

## Ejecutar

```bash
docker run -d \
  -p 8080:8080 \
  -p 5222:5222 \
  -e LCB_DATABASE_URI=mongodb://mongo/letschat \
  lets-chat
```

## Variables de entorno

| Variable | Descripción |
|---|---|
| `LCB_DATABASE_URI` | URI de MongoDB |
| `LCB_HTTP_HOST` | Host HTTP (default: 0.0.0.0) |
| `LCB_HTTP_PORT` | Puerto HTTP (default: 8080) |
| `LCB_XMPP_ENABLE` | Habilitar XMPP (default: true) |
| `LCB_XMPP_PORT` | Puerto XMPP (default: 5222) |

## Puertos

| Puerto | Protocolo |
|---|---|
| 8080 | HTTP |
| 5222 | XMPP |

Requiere MongoDB.
