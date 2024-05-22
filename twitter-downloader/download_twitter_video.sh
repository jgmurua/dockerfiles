#!/bin/bash

echo "Inicio del script de descarga"

# Comprobar si se proporcionó una URL como argumento
if [ -z "$1" ]; then
  echo "Uso: $0 <twitter_video_url> [format]"
  exit 1
fi

# Asignar la URL proporcionada a una variable
TWITTER_VIDEO_URL=$1
FORMAT=$2

echo "URL proporcionada: $TWITTER_VIDEO_URL"
echo "Formato proporcionado: $FORMAT"

# Descargar el video usando yt-dlp y nombrarlo basado en el título del video
if [ "$FORMAT" == "mp3" ]; then
  yt-dlp --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s" $TWITTER_VIDEO_URL
else
  yt-dlp -o "%(title)s.%(ext)s" $TWITTER_VIDEO_URL
fi

# Verificar si la descarga fue exitosa
if [ $? -eq 0 ]; then
  echo "Video descargado exitosamente."
else
  echo "Error al descargar el video."
  exit 1
fi
