#!/bin/bash

# Test script for Edge Detection NPP
# Runs edge detection on the test image and displays results

echo "=========================================="
echo "Edge Detection NPP - Test Script"
echo "=========================================="
echo ""

# Check if executable exists
if [ ! -f "./edgeDetectionNPP" ]; then
    echo "Error: edgeDetectionNPP not found!"
    echo "Please run ./build.sh first"
    exit 1
fi

# Check if test image exists
if [ ! -f "Lena.pgm" ]; then
    echo "Warning: Lena.pgm not found. Using any available .pgm file..."
    TEST_IMAGE=$(ls *.pgm 2>/dev/null | head -n 1)
    if [ -z "$TEST_IMAGE" ]; then
        echo "Error: No .pgm images found in current directory"
        exit 1
    fi
else
    TEST_IMAGE="Lena.pgm"
fi

echo "Test Image: $TEST_IMAGE"
echo ""
echo "Running edge detection..."
echo ""

# Run edge detection
./edgeDetectionNPP --input="$TEST_IMAGE"

# Check results
echo ""
echo "=========================================="
echo "Results:"
echo "=========================================="
echo ""

# Find output files
H_EDGES=$(ls *_edges_horizontal.pgm 2>/dev/null | tail -n 1)
V_EDGES=$(ls *_edges_vertical.pgm 2>/dev/null | tail -n 1)

if [ -n "$H_EDGES" ] && [ -n "$V_EDGES" ]; then
    echo "✓ Edge detection completed successfully!"
    echo ""
    echo "Output files:"
    ls -lh *_edges_*.pgm | awk '{print "  " $9 " (" $5 ")"}'
    echo ""
    echo "To view results:"
    echo "  1. Convert to PNG: convert $H_EDGES ${H_EDGES%.pgm}.png"
    echo "  2. View: display ${H_EDGES%.pgm}.png"
    echo ""
else
    echo "✗ No output files found. Check for errors above."
fi

echo "Test complete!"
