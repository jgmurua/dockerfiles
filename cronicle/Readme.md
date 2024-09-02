
#Construye la imagen de Docker:

```bash
docker run -d -p 3012:3012 --name cronicle -v /opt/cronicle/data -v /opt/cronicle/logs -v /opt/cronicle/plugins -v /opt/cronicle/backup cronicle
docker run -d -p 3012:3012 cronicle
```
