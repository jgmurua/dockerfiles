# Usa la imagen base de Python
FROM python:3.9-slim

# Instala yt-dlp desde el repositorio oficial y otros paquetes necesarios
RUN apt-get update && apt-get install -y \
    python3-pip \
    ffmpeg \
    curl \
    && pip3 install --upgrade pip \
    && curl -L https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -o /usr/local/bin/yt-dlp \
    && chmod a+rx /usr/local/bin/yt-dlp \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Crea un directorio de trabajo
WORKDIR /app

# Copia los archivos de la aplicación al contenedor
COPY app.py /app/
COPY download_twitter_video.sh /app/
COPY requirements.txt /app/
COPY static /app/static/
COPY templates /app/templates/

# Da permisos de ejecución al script
RUN chmod +x /app/download_twitter_video.sh

# Instala las dependencias de Python
RUN pip install -r requirements.txt

# Expone el puerto en el que correrá la aplicación
EXPOSE 5000

# Comando para ejecutar la aplicación
CMD ["python", "app.py"]
