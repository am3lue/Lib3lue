document.addEventListener('DOMContentLoaded', () => {
    // Configurations for different upload categories
    const uploadConfigs = [
        {
            uploadBoxId: 'bookUpload',
            fileInputId: 'bookFile',
            progressId: 'bookProgress',
            category: 'books',
            maxSize: 100 * 1024 * 1024 // 100MB
        },
        {
            uploadBoxId: 'musicUpload',
            fileInputId: 'musicFile',
            progressId: 'musicProgress',
            category: 'music',
            maxSize: 50 * 1024 * 1024 // 50MB
        },
        {
            uploadBoxId: 'docUpload',
            fileInputId: 'docFile',
            progressId: 'docProgress',
            category: 'docs',
            maxSize: 50 * 1024 * 1024 // 50MB
        }
    ];

    uploadConfigs.forEach(config => {
        const uploadBox = document.getElementById(config.uploadBoxId);
        const fileInput = document.getElementById(config.fileInputId);
        const progressContainer = document.getElementById(config.progressId);
        const progressBar = progressContainer.querySelector('.progress-bar');
        const progressText = progressContainer.querySelector('.progress-text');

        // Click → open file selector
        uploadBox.addEventListener('click', () => fileInput.click());

        // Drag-and-drop handling
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
            uploadFiles(fileInput.files, config.category, progressBar, progressText, config.maxSize);
        });

        // File input change
        fileInput.addEventListener('change', () => {
            uploadFiles(fileInput.files, config.category, progressBar, progressText, config.maxSize);
        });
    });

    async function uploadFiles(files, category, progressBar, progressText, maxSize) {
        const validFiles = Array.from(files).filter(file => file.size <= maxSize);
        if (validFiles.length === 0) {
            progressText.textContent = '❌ No valid files selected or files exceed size limit';
            return;
        }

        const formData = new FormData();
        validFiles.forEach(file => {
            formData.append('files', file);
        });

        progressBar.style.width = '0%';
        progressText.textContent = 'Uploading...';

        try {
            const response = await fetch(`/api/upload/${category}`, {
                method: 'POST',
                body: formData
            });

            const result = await response.json();

            if (!response.ok || result.error) {
                throw new Error(result.error || 'Upload failed');
            }

            progressBar.style.width = '100%';
            progressText.textContent = '✅ Upload complete';

            if (result.files?.length) {
                updateUploadedFiles(result.files);
            }

            if (result.warnings?.length) {
                alert(`⚠️ Warnings: ${result.warnings.join(', ')}`);
            }
        } catch (error) {
            console.error('Upload error:', error);
            progressText.textContent = `❌ Error: ${error.message}`;
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
