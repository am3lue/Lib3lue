# 3lue Library

A digital library application for sharing and accessing books, music, and documentation. Built with Julia and Genie framework.

## Features

- 📚 Book upload and viewing
- 🎵 Music file management
- 📄 Documentation sharing
- 🔍 Search functionality
- 📱 Responsive web interface
- 🔒 Secure file handling

## Prerequisites

- Julia 1.6 or higher
- Git (optional, for cloning the repository)

## Installation

### Step 1: Install Julia

#### Windows
1. Download Julia from [julialang.org](https://julialang.org/downloads/)
2. Run the installer
3. Check "Add Julia to PATH" during installation
4. Open Command Prompt and verify:
```bash
julia --version
```

#### macOS
1. Using Homebrew:
```bash
brew install julia
```
2. Or download from [julialang.org](https://julialang.org/downloads/)
3. Verify in Terminal:
```bash
julia --version
```

#### Linux
1. Using package manager:
```bash
# Ubuntu/Debian
sudo apt-get install julia

# Fedora
sudo dnf install julia

# Arch Linux
sudo pacman -S julia
```
2. Or download from [julialang.org](https://julialang.org/downloads/)
3. Verify:
```bash
julia --version
```

### Step 2: Install the Application

1. Get the source code:
```bash
# Option 1: Clone with Git
git clone https://github.com/am3lue/lib3lue.git
cd lib3lue

# Option 2: Download ZIP
# 1. Download the ZIP file
# 2. Extract to your desired location
# 3. Open terminal in the extracted folder
```

2. Install dependencies:

You have two options for installation:

#### Option A: Using the Setup Script (Recommended)
Simply run the setup batch file:
```bash
# On Windows
setup.bat

# On Linux/MacOS
chmod +x setup.sh  # First time only
./setup.sh
```

#### Option B: Manual Installation
Run the Julia setup script directly:
```bash
julia setup.jl
```

The setup script will:
- Activate the project environment
- Install all required packages
- Configure the necessary dependencies

Wait for the "Setup completed!" message to appear.

## Running the Application

### Starting the Server

1. Open terminal in the project folder
2. Start the server:
```bash
julia serve.jl
```
3. You'll see:
```
Starting 3lue Library server...
Server running at http://<your-ip-address>:8000
Press Ctrl+C to stop the server
```

4. Open your browser and go to:
```
http://<your-ip-address>:8000
```

Note: Replace `<your-ip-address>` with your device's actual IP address. The server will automatically detect and display your IP address when starting up.

### Accessing from Other Devices

The application is accessible from any device on your local network. To access it:
1. Make sure your device and the accessing device are on the same network
2. Use the IP address shown when starting the server
3. Open a browser on the other device and navigate to:
```
http://<server-ip-address>:8000
```

### Stopping the Server

- Press `Ctrl+C` in the terminal
- Wait for the server to stop

### Running in Background

#### Windows
```bash
start /B julia serve.jl
```

#### macOS/Linux
```bash
julia serve.jl &
```

### Troubleshooting Startup

1. **Port 8000 in use?**
```bash
# Windows
netstat -ano | findstr :8000

# macOS/Linux
lsof -i :8000
```
Solution: Change port in `serve.jl` or stop the process using port 8000

2. **Dependencies missing?**
```bash
julia init.jl
```

3. **Permission issues?**
- Windows: Run as Administrator
- Linux/macOS: Use `sudo`

## Usage Guide

### Uploading Files

1. Navigate to the Upload page
2. Choose the type of content you want to upload (Books, Music, or Documentation)
3. Drag and drop files or click to browse
4. Wait for the upload to complete
5. View your uploaded files in the "Recently Uploaded Files" section

### Supported File Types

#### Books
- PDF (.pdf)
- EPUB (.epub)
- MOBI (.mobi)
- Text (.txt)
- Word (.doc, .docx)
- DJVU (.djvu)
- Kindle (.azw, .azw3)
- FictionBook (.fb2)
- Rich Text (.rtf)

#### Music
- MP3 (.mp3)
- WAV (.wav)
- OGG (.ogg)
- M4A (.m4a)
- FLAC (.flac)

#### Documentation
- PDF (.pdf)
- Word (.doc, .docx)
- Text (.txt)
- Rich Text (.rtf)

### File Size Limits

- Books: Maximum 100MB per file
- Music: Maximum 50MB per file
- Documentation: Maximum 50MB per file

### Searching Content

1. Use the search bar on the respective pages (Books, Music, or Documentation)
2. Enter your search query
3. Results will be displayed in real-time

## API Endpoints

### Upload
- `POST /api/upload/books` - Upload book files
- `POST /api/upload/music` - Upload music files
- `POST /api/upload/docs` - Upload documentation files

### Search
- `GET /api/search` - Search books
- `GET /api/music/search` - Search music
- `GET /api/docs/search` - Search documentation

### File Access
- `GET /books/:filename` - Access book files
- `GET /music/:filename` - Access music files
- `GET /docs/:filename` - Access documentation files

## Security Features

- File type validation
- File size limits
- Filename sanitization
- Duplicate file handling
- Secure file storage

## Troubleshooting

### Common Issues

1. **Server won't start**
   - Make sure Julia is properly installed
   - Check if port 8000 is available
   - Run `julia init.jl` to ensure all dependencies are installed

2. **File upload fails**
   - Check file size limits
   - Verify file type is supported
   - Ensure you have write permissions in the upload directory

3. **Search not working**
   - Check if the files are properly indexed
   - Verify search query format

## Thank You!

Thank you for using 3lue Library! We appreciate your support and interest in our project. If you find this application useful, please consider:

- ⭐ Starring the repository on GitHub
- 🐛 Reporting any issues you encounter
- 💡 Suggesting new features
- 📢 Sharing with others who might find it useful

## Contributing

We welcome and appreciate all contributions to 3lue Library! Whether you're a developer, designer, or user, there are many ways to contribute:

### Ways to Contribute

1. **Code Contributions**
   - Fix bugs
   - Add new features
   - Improve performance
   - Enhance security
   - Write tests

2. **Documentation**
   - Improve documentation
   - Add usage examples
   - Write tutorials
   - Translate documentation

3. **Testing**
   - Report bugs
   - Test new features
   - Suggest improvements
   - Create test cases

4. **Community Support**
   - Answer questions
   - Help other users
   - Share your experience
   - Write blog posts

### How to Contribute

1. Fork the repository
2. Create a feature branch:
```bash
git checkout -b feature/your-feature-name
```
3. Make your changes
4. Commit your changes:
```bash
git commit -m "Description of your changes"
```
5. Push to the branch:
```bash
git push origin feature/your-feature-name
```
6. Create a Pull Request

### Contribution Guidelines

- Follow the existing code style
- Write clear commit messages
- Include tests for new features
- Update documentation as needed
- Be respectful and constructive in discussions

### Need Help?

If you're new to contributing or have questions:
- Open an issue for discussion
- Check out our [Contributor Guide](CONTRIBUTING.md)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contact

For support or questions, please contact:
- Email: am3lue@gmail.com
- GitHub Issues: [Create an issue](https://github.com/am3lue/lib3lue/issues) 