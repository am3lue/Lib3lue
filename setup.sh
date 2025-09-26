#!/bin/bash

echo "🚀 Starting 3lue Library setup..."

# Step 1: Run package installation
echo "📦 Installing required packages..."
julia setup.jl
if [ $? -ne 0 ]; then
    echo "❌ Error occurred during package installation!"
    exit 1
fi

# Step 2: Run initialization
echo "🔧 Initializing project structure..."
julia init.jl
if [ $? -ne 0 ]; then
    echo "❌ Error occurred during initialization!"
    exit 1
fi

# Step 3: Set correct permissions for directories
echo "📂 Setting up directory permissions..."
chmod -R 755 public/
if [ $? -ne 0 ]; then
    echo "⚠️ Warning: Could not set directory permissions"
fi

# Print success message
echo "
✅ Setup completed successfully!

🌟 To start the server, run:
   julia serve.jl

📚 The following directories have been created:
   - public/Docs    (for documentation)
   - public/Music   (for audio files)
   - public/Movies  (for video files)
   - public/Books   (for ebooks and documents)
"

read -p "Press enter to continue..."