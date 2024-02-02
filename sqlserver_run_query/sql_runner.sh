#!/bin/bash

# Ejecutar el script SQL y guardar el resultado en un archivo temporal
resultado_tmp=$(mktemp)
/opt/mssql-tools/bin/sqlcmd -S "$SQL_SERVER_HOST" -d "$SQL_DATABASE" -U "$SQL_USER" -P "$SQL_PASSWORD" -Q "$QUERY" -s "|" -W -w 65535 > "$resultado_tmp"

# Verificar si hubo errores en la ejecución
if [ $? -eq 0 ]; then
  echo "Script SQL ejecutado exitosamente. Resultado:"
  cat "$resultado_tmp"
else
  echo "Error al ejecutar el script SQL."
fi

# Eliminar el archivo temporal de resultados
rm "$resultado_tmp"
