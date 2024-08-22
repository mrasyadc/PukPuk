#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Print commands and their arguments as they are executed
set -x

# Install Homebrew if it's not already installed
if ! command -v brew &>/dev/null; then
	echo "Homebrew not found. Installing Homebrew..."
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install xcodegen if it's not already installed
if ! command -v xcodegen &>/dev/null; then
	echo "xcodegen not found. Installing xcodegen..."
	brew install xcodegen
fi

# Clean any previous builds or project files
echo "Cleaning previous builds..."
rm -rf ./build
rm -rf ./DerivedData
rm -rf ./YourProject.xcodeproj

# Generate the Xcode project using xcodegen
echo "Generating Xcode project..."
xcodegen generate

# Install CocoaPods dependencies if your project uses CocoaPods
if [ -f "Podfile" ]; then
	echo "Installing CocoaPods dependencies..."
	pod install
fi

echo "Pre-build setup complete!"
