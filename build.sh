#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
BUILD_DIR="build"
BUILD_TYPE="Release"
PROJECT_NAME="STM32F4Discovery" # Match the project name in CMakeLists.txt

# Create the build directory if it doesn't exist
if [ ! -d "$BUILD_DIR" ]; then
    echo "Creating build directory..."
    mkdir "$BUILD_DIR"
fi

# Navigate to the build directory
cd "$BUILD_DIR"

# Run CMake configuration
echo "Configuring the project with CMake..."
cmake -G Ninja -DCMAKE_BUILD_TYPE="$BUILD_TYPE" ..

# Build the project
echo "Building the project..."
ninja

# Generate HEX and BIN files
echo "Generating HEX file..."
ninja hex

echo "Generating BIN file..."
ninja bin

# Print build artifacts size info
echo "Displaying size info for the ELF file..."
ninja size

# Notify the user of successful build
echo "Build completed successfully!"
cd -
