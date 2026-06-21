# drupal

Stack [Drupal 10.1.7](https://www.drupal.org/) con MySQL 8.0 y Nginx.

## Servicios

| Servicio | Imagen | Puerto |
|---|---|---|
| `mysql` | mysql:8.0 | — |
| `drupal` | drupal:10.1.7-php8.2-fpm-alpine3.18 | — |
| `webserver` | nginx:1.21.3-alpine | 80:80 |

## Ejecutar

```bash
docker-compose up -d
```

## Variables de entorno (Drupal)

| Variable | Valor por defecto |
|---|---|
| `MYSQL_ROOT_PASSWORD` | root |
| `MYSQL_DATABASE` | drupal |
| `MYSQL_USER` | drupal |
| `MYSQL_PASSWORD` | drupal |
| `USER` | admin |
| `PASS` | p4ssw0rd***p4ssw0rd*** |

## Volúmenes

| Volumen | Ruta |
|---|---|
| `db-data` | `/var/lib/mysql` |
| `drupal-data` | `/var/www/html` |
