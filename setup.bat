@echo off
echo [92m🚀 Starting 3lue Library setup...[0m

:: Step 1: Run package installation
echo [94m📦 Installing required packages...[0m
julia setup.jl
if errorlevel 1 (
    echo [91m❌ Error occurred during package installation![0m
    pause
    exit /b 1
)

:: Step 2: Run initialization
echo [94m🔧 Initializing project structure...[0m
julia init.jl
if errorlevel 1 (
    echo [91m❌ Error occurred during initialization![0m
    pause
    exit /b 1
)

:: Step 3: Create directories if they don't exist
echo [94m📂 Setting up directories...[0m
if not exist "public\Docs" mkdir "public\Docs"
if not exist "public\Music" mkdir "public\Music"
if not exist "public\Movies" mkdir "public\Movies"
if not exist "public\Books" mkdir "public\Books"

:: Print success message
echo [92m
✅ Setup completed successfully!

🌟 To start the server, run:
   julia serve.jl

📚 The following directories have been created:
   - public\Docs    (for documentation)
   - public\Music   (for audio files)
   - public\Movies  (for video files)
   - public\Books   (for ebooks and documents)
[0m

pause