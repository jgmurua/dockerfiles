# opencart

[OpenCart 4.0.2.2](https://www.opencart.com/) sobre PHP 8.2 + Apache.

## Contenido

- php:8.2-apache
- Extensiones: GD, mysqli, zip, pdo_sqlite, opcache
- Apache mod_rewrite habilitado
- OpenCart 4.0.2.2

## Construir

```bash
docker build -t opencart .
```

## Ejecutar

```bash
docker run -d -p 80:80 opencart
```

## Puertos

| Puerto | Descripción |
|---|---|
| 80 | Servidor web Apache |

## Configuración

Los archivos `config.php` y `admin/config.php` deben configurarse con los datos de conexión a la base de datos antes de construir.
