document.addEventListener('DOMContentLoaded', () => {
    // Configuration for upload sections
    const uploadConfigs = [
        {
            uploadBoxId: 'bookUpload',
            fileInputId: 'bookFile',
            progressId: 'bookProgress',
            endpoint: '/api/upload/books',
            maxSize: 100 * 1024 * 1024 // 100MB
        },
        {
            uploadBoxId: 'musicUpload',
            fileInputId: 'musicFile',
            progressId: 'musicProgress',
            endpoint: '/api/upload/music',
            maxSize: 50 * 1024 * 1024 // 50MB
        },
        {
            uploadBoxId: 'docUpload',
            fileInputId: 'docFile',
            progressId: 'docProgress',
            endpoint: '/api/upload/docs',
            maxSize: 50 * 1024 * 1024 // 50MB
        }
    ];

    uploadConfigs.forEach(config => {
        const uploadBox = document.getElementById(config.uploadBoxId);
        const fileInput = document.getElementById(config.fileInputId);
        const progressContainer = document.getElementById(config.progressId);
        const progressBar = progressContainer.querySelector('.progress-bar');
        const progressText = progressContainer.querySelector('.progress-text');

        // Click to trigger file input
        uploadBox.addEventListener('click', () => fileInput.click());

        // Drag and drop
        uploadBox.addEventListener('dragover', (e) => {
            e.preventDefault();
            uploadBox.classList.add('dragover');
        });

        uploadBox.addEventListener('dragleave', () => {
            uploadBox.classList.remove('dragover');
        });

        uploadBox.addEventListener('drop', (e) => {
            e.preventDefault();
            uploadBox.classList.remove('dragover');
            fileInput.files = e.dataTransfer.files;
            uploadFiles(fileInput.files, config.endpoint, progressBar, progressText, config.maxSize);
        });

        // File input change
        fileInput.addEventListener('change', () => {
            uploadFiles(fileInput.files, config.endpoint, progressBar, progressText, config.maxSize);
        });
    });

    async function uploadFiles(files, endpoint, progressBar, progressText, maxSize) {
        // Validate files
        const validFiles = Array.from(files).filter(file => file.size <= maxSize);
        if (validFiles.length === 0) {
            progressText.textContent = 'Error: No valid files selected or files exceed size limit';
            return;
        }
    
        const formData = new FormData();
        validFiles.forEach(file => {
            formData.append('files', file);
            console.log(`Appending file: ${file.name}, size: ${file.size}`); // Debug
        });
    
        // Log FormData entries (for debugging)
        for (let [key, value] of formData.entries()) {
            console.log(`FormData: ${key}=${value.name || value}`);
        }
    
        progressBar.style.width = '0%';
        progressText.textContent = 'Uploading...';
    
        try {
            const response = await fetch(endpoint, {
                method: 'POST',
                body: formData
            });
    
            // Log raw response
            const responseText = await response.text();
            console.log('Raw server response:', responseText);
    
            // Parse JSON
            let result;
            try {
                result = JSON.parse(responseText);
            } catch (jsonError) {
                throw new Error(`Failed to parse JSON: ${jsonError.message}\nResponse: ${responseText}`);
            }
    
            if (!response.ok) {
                throw new Error(result.error || `Upload failed: ${response.statusText}`);
            }
    
            progressBar.style.width = '100%';
            progressText.textContent = 'Upload complete';
    
            if (result.status === 'success') {
                console.log('Uploaded files:', result.files);
                updateUploadedFiles(result.files);
                if (result.warnings?.length > 0) {
                    alert(`Upload completed with warnings: ${result.warnings.join(', ')}`);
                }
            } else {
                throw new Error(result.errors?.join(', ') || 'Upload failed');
            }
        } catch (error) {
            console.error('Upload error:', error);
            progressText.textContent = `Error: ${error.message}`;
            alert(`Upload failed: ${error.message}`);
        }
    }

    function updateUploadedFiles(files) {
        const filesGrid = document.getElementById('uploadedFiles');
        files.forEach(file => {
            const fileElement = document.createElement('div');
            fileElement.className = 'file-item';
            fileElement.textContent = `${file.name} (${file.type})`;
            filesGrid.prepend(fileElement);
        });
    }
});