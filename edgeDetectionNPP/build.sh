#!/bin/bash

# Build script for Edge Detection NPP
# Simple standalone build for edge detection project

echo "=========================================="
echo "Building Edge Detection NPP"
echo "=========================================="

# Check if CUDA is available
if ! command -v nvcc &> /dev/null; then
    echo "ERROR: nvcc not found. Please install CUDA Toolkit."
    echo "Download from: https://developer.nvidia.com/cuda-downloads"
    exit 1
fi

# Set CUDA path (modify if needed)
CUDA_PATH=${CUDA_PATH:-/usr/local/cuda}

# Compiler flags
INCLUDES="-I../Common -I../Common/UtilNPP"
LIBS="-L${CUDA_PATH}/lib64 -lnppif -lnppisu -lnppc -lcudart -lfreeimage"
CXXFLAGS="-O2"

echo ""
echo "CUDA Path: $CUDA_PATH"
echo "Building edgeDetectionNPP..."
echo ""

# Build
if nvcc $CXXFLAGS -o edgeDetectionNPP edgeDetectionNPP.cpp $INCLUDES $LIBS; then
    echo ""
    echo "=========================================="
    echo "✓ Build Successful!"
    echo "=========================================="
    echo ""
    echo "Executable: edgeDetectionNPP"
    ls -lh edgeDetectionNPP 2>/dev/null | awk '{print "Size: " $5}'
    echo ""
    echo "Usage:"
    echo "  ./edgeDetectionNPP                    # Use default Lena.pgm"
    echo "  ./edgeDetectionNPP --input=image.pgm  # Custom image"
    echo ""
else
    echo ""
    echo "=========================================="
    echo "✗ Build Failed"
    echo "=========================================="
    echo ""
    echo "Common issues:"
    echo "  1. Missing FreeImage: sudo apt-get install libfreeimage-dev"
    echo "  2. Wrong CUDA path: export CUDA_PATH=/your/cuda/path"
    echo "  3. Missing NPP libraries: Check CUDA installation"
    echo ""
    exit 1
fi
