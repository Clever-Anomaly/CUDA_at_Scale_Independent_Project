# Edge Detection NPP - Quick Reference

## ✨ Now Supports All Image Formats!
**JPG, PNG, BMP, PGM** - Use any format directly!  
**Color images** are automatically converted to grayscale!  
**PNG output** - No conversion needed!

## Build
```bash
./build.sh          # Linux/Mac
build.bat           # Windows
```

## Run
```bash
# Use any image format!
./edgeDetectionNPP --input=photo.jpg    # JPG
./edgeDetectionNPP --input=image.png    # PNG  
./edgeDetectionNPP --input=pic.bmp      # BMP
./edgeDetectionNPP                      # Default test image
```

## Output Files (PNG format)
- `{filename}_edges_horizontal.png` - Vertical edges
- `{filename}_edges_vertical.png` - Horizontal edges

**No conversion needed - just open the PNG files!**

## Examples
```bash
# Vacation photo
./edgeDetectionNPP --input=vacation.jpg

# Selfie
./edgeDetectionNPP --input=selfie.png

# Any image!
./edgeDetectionNPP --input=myimage.jpg
```

## Requirements
- NVIDIA GPU with CUDA support
- CUDA Toolkit 11.0+
- FreeImage library
- Linux: `sudo apt-get install libfreeimage-dev`

## Troubleshooting
```bash
# Check CUDA
nvcc --version
nvidia-smi

# Check NPP libraries
ls /usr/local/cuda/lib64/libnpp*

# Set CUDA path
export CUDA_PATH=/usr/local/cuda
export LD_LIBRARY_PATH=$CUDA_PATH/lib64:$LD_LIBRARY_PATH
```

## What It Does
- Detects edges using Sobel operator
- GPU-accelerated processing
- Separates horizontal and vertical edges
- Perfect for computer vision applications

See README.md for full documentation.
