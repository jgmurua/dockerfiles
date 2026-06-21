# twitter-downloader

Aplicación web Flask para descargar videos de Twitter/X usando [yt-dlp](https://github.com/yt-dlp/yt-dlp).

## Contenido

- Python 3.11-slim
- Flask (app web)
- yt-dlp, ffmpeg

## Construir

```bash
docker build -t twitter-downloader .
```

## Ejecutar

```bash
docker run -d -p 5000:5000 twitter-downloader
```

## Puertos

| Puerto | Descripción |
|---|---|
| 5000 | Interfaz web |

## Uso

1. Abrir `http://localhost:5000`
2. Ingresar URL del video de Twitter/X
3. El servidor descarga el video y lo sirve para descarga directa
