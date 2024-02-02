#!/bin/bash

# Ejecutar el script SQL y guardar el resultado en un archivo temporal
resultado_tmp=$(mktemp)
# crea un archivo temporal con la query
echo $QUERY > /tmp/query.sql
mysql -h "$MYSQL_HOST" -u "$MYSQL_USER" -p"$MYSQL_PASSWORD" "$MYSQL_DATABASE"  < /tmp/query.sql > "$resultado_tmp"

# Verificar si hubo errores en la ejecución
if [ $? -eq 0 ]; then
  echo "Script SQL ejecutado exitosamente. Resultado:"
  cat "$resultado_tmp"
else
  echo "Error al ejecutar el script SQL."
fi

# Eliminar el archivo temporal de resultados
rm -rf "$resultado_tmp" /tmp/query.sql