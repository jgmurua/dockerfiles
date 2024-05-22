from flask import Flask, request, send_file, render_template, jsonify, Response
import os
import subprocess
import logging
import time

app = Flask(__name__)

logging.basicConfig(level=logging.DEBUG)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/download', methods=['POST'])
def download_video():
    url = request.form['url']
    format_option = request.form['format']

    app.logger.debug(f'Received URL: {url}')
    app.logger.debug(f'Received format: {format_option}')

    if not url:
        return jsonify({"error": "No URL provided"}), 400

    # Call the download script with the desired format
    result = subprocess.run(['./download_twitter_video.sh', url, format_option], capture_output=True, text=True)

    app.logger.debug(f'Script stdout: {result.stdout}')
    app.logger.debug(f'Script stderr: {result.stderr}')

    if result.returncode != 0:
        return jsonify({"error": "Failed to download video", "details": result.stderr}), 500

    # Find the downloaded file in the current directory
    for file in os.listdir('.'):
        if file.endswith('.mp4') or file.endswith('.mp3') or file.endswith('.webm'):
            try:
                response = send_file(file, as_attachment=True)
                response.call_on_close(lambda: os.remove(file))
                return response
            except Exception as e:
                app.logger.error(f'Error sending file: {e}')
                return jsonify({"error": "Failed to send file"}), 500
        
    return jsonify({"error": "Failed to find downloaded file"}), 500

@app.route('/download_stream', methods=['POST'])
def download_video_stream():
    url = request.form['url']
    format_option = request.form['format']

    app.logger.debug(f'Received URL: {url}')
    app.logger.debug(f'Received format: {format_option}')

    if not url:
        return jsonify({"error": "No URL provided"}), 400

    # Call the download script with the desired format
    result = subprocess.Popen(['./download_twitter_video.sh', url, format_option], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

    def generate():
        for line in result.stdout:
            yield line
    # luego de que el proceso termina, se cierra el archivo y se elimina
    return Response(generate(), mimetype='text/plain')

# verificar los archivos en el directorio y borrar los archivos con mas de 3 minutos de antiguedad
def delete_old_files():
    for file in os.listdir('.'):
        if file.endswith('.mp4') or file.endswith('.mp3') or file.endswith('.webm'):
            file_time = os.path.getctime(file)
            current_time = time.time()
            os.remove(file)
            app.logger.debug(f'Deleted file: {file}')

# ejecutar la funcion delete_old_files cada 60 segundos y lanzar el servidor
if __name__ == '__main__':
    import threading
    # ejecutar la funcion delete_old_files cada 60 segundos
    threading.Timer(60.0, delete_old_files).start()
    # lanzar el servidor en otro hilo secundario
    threading.Thread(target=app.run, kwargs={'host': '0.0.0.0', 'port': 80}).start()


