document.getElementById('download-form').addEventListener('submit', function(event) {
    event.preventDefault();

    const url = document.getElementById('url').value;
    const format = document.getElementById('format').value;
    const messageDiv = document.getElementById('message');

    messageDiv.textContent = 'Downloading...';

    const formData = new FormData();
    formData.append('url', url);
    formData.append('format', format);

    fetch('/download', {
        method: 'POST',
        body: formData
    })
    .then(response => {
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
        return response.blob();
    })
    .then(blob => {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement('a');
        a.style.display = 'none';
        a.href = url;
        a.download = format === 'mp3' ? 'audio.mp3' : 'video.mp4';
        document.body.appendChild(a);
        a.click();
        window.URL.revokeObjectURL(url);
        messageDiv.textContent = 'Download complete!';
    })
    .catch(error => {
        console.error('Error:', error);
        messageDiv.textContent = 'Download failed!';
    });
});
