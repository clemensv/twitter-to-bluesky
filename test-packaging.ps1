# Ensure you have Visual Studio Build Tools installed
# You can install them from: https://visualstudio.microsoft.com/visual-cpp-build-tools/
# Or try installing via npm (might need admin PowerShell)
npm install --global windows-build-tools

# Install node-gyp globally
npm install -g node-gyp

# Now run the packaging script
Remove-Item -Path dist -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path dist/package/sharp -Force

# Compile TypeScript
npm run compile

# Remove and reinstall Sharp for Windows
npm remove sharp
npm install --platform=win32 --arch=x64 sharp

# Copy entire Sharp module
Copy-Item -Path node_modules/sharp -Destination dist/package/sharp/ -Recurse

# Create package
pkg . --targets node22-win-x64 --output dist/package/twittertobluesky.exe

# Test the executable
cd dist/package
.\twittertobluesky.exe