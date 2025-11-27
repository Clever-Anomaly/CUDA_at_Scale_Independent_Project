# Edge Detection NPP - GPU-Accelerated Edge Detection

A simple CUDA/NPP project that performs **Sobel edge detection** on images using GPU acceleration.

## 📖 What It Does

This program detects edges in images using the **Sobel operator**, which identifies areas of rapid intensity change. It produces two output images:
- **Horizontal edges** - Detects vertical lines and left-right transitions
- **Vertical edges** - Detects horizontal lines and up-down transitions

Perfect for computer vision, object detection, and image analysis applications!

## ✨ NEW: Automatic Format Support

**No more PGM conversions!** The program now:
- ✅ Accepts **JPG, PNG, BMP, PGM** and other common formats directly
- ✅ Automatically converts **color images to grayscale**
- ✅ Outputs **PNG files** (no need to convert!)

Just use your regular photos - the program handles everything!

## 🎯 Key Features

- ✅ GPU-accelerated processing using NVIDIA NPP library
- ✅ Sobel edge detection (industry-standard algorithm)
- ✅ Separate horizontal and vertical edge outputs
- ✅ Fast processing even for large images
- ✅ Simple command-line interface
- ✅ Support for JPG, PNG, BMP, PGM and other image formats
- ✅ Automatic color-to-grayscale conversion
- ✅ PNG output files (easy to view!)

## 📋 Prerequisites

### Required
- **NVIDIA GPU** with CUDA support
- **CUDA Toolkit** 11.0 or later ([Download](https://developer.nvidia.com/cuda-downloads))
- **FreeImage library** for image I/O
- **C++ compiler** (g++ on Linux, MSVC on Windows)

### Check Your Setup
```bash
# Verify CUDA is installed
nvcc --version

# Verify GPU is available
nvidia-smi

# Check for NPP libraries
ls /usr/local/cuda/lib64/libnpp*
```

## 🚀 Quick Start

### 1. Install Dependencies

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install libfreeimage-dev
```

**Windows:**
Download FreeImage from [http://freeimage.sourceforge.net/](http://freeimage.sourceforge.net/)

**macOS:**
```bash
brew install freeimage
```

### 2. Build the Project

**Linux/Mac:**
```bash
chmod +x build.sh
./build.sh
```

**Windows:**
```cmd
build.bat
```

**Manual build (Linux):**
```bash
nvcc -o edgeDetectionNPP edgeDetectionNPP.cpp \
     -I../Common -I../Common/UtilNPP \
     -L/usr/local/cuda/lib64 \
     -lnppif -lnppisu -lnppc -lcudart -lfreeimage \
     -O2
```

### 3. Run It!

```bash
# Use the included test image
./edgeDetectionNPP

# Or specify your own image
./edgeDetectionNPP --input=myimage.pgm
```

## 📊 Usage Examples

### Basic Usage
```bash
./edgeDetectionNPP
```
Uses a default test image and creates PNG output files

### Use Your Own Photos! (JPG, PNG, BMP)
```bash
# Just use any image format directly!
./edgeDetectionNPP --input=photo.jpg
./edgeDetectionNPP --input=vacation.png
./edgeDetectionNPP --input=selfie.bmp
```

**Output files** (automatically named):
- `photo_edges_horizontal.png`
- `photo_edges_vertical.png`

### Works with Color Images!
```bash
# Color photos are automatically converted to grayscale
./edgeDetectionNPP --input=colorful_sunset.jpg

# The program will:
# 1. Load the color image
# 2. Convert to grayscale
# 3. Detect edges
# 4. Save as PNG
```

### Viewing Results
```bash
# Output is PNG - just open it!
display photo_edges_horizontal.png  # Linux
open photo_edges_horizontal.png     # Mac
start photo_edges_horizontal.png    # Windows

# Or use any image viewer
```

## 🔍 Understanding the Output

### Horizontal Edges
- Bright pixels indicate **vertical lines** or **left-to-right intensity changes**
- Good for detecting vertical structures (pillars, walls, edges of objects)
- Example: Person's silhouette sides, building edges

### Vertical Edges
- Bright pixels indicate **horizontal lines** or **up-to-down intensity changes**
- Good for detecting horizontal structures (floors, ceilings, horizons)
- Example: Person's shoulders, table tops, horizons

### Edge Intensity
- **Bright white pixels** = Strong edge (rapid intensity change)
- **Dark/black pixels** = No edge (uniform area)
- **Gray pixels** = Weak edge (gradual change)

## 📁 Project Structure

```
edgeDetectionNPP/
├── edgeDetectionNPP.cpp   # Main source code
├── build.sh               # Linux/Mac build script
├── build.bat              # Windows build script
├── README.md              # This file
├── Lena.pgm               # Test image
└── (output files)         # Generated edge images
```

## 🛠️ How It Works

1. **Load Image** - Reads grayscale PGM image into CPU memory
2. **Transfer to GPU** - Copies image data to GPU memory
3. **Apply Sobel Horizontal** - Detects vertical edges on GPU
4. **Apply Sobel Vertical** - Detects horizontal edges on GPU
5. **Transfer to CPU** - Copies results back to CPU memory
6. **Save Images** - Writes edge images to disk

All GPU operations are handled by the **NPP (NVIDIA Performance Primitives)** library for maximum performance.

## 🎓 Use Cases

### Computer Vision
- Object boundary detection
- Feature extraction
- Image segmentation preprocessing
- Pattern recognition

### Real-World Applications
- Quality control (detecting defects)
- Document scanning (finding text boundaries)
- Medical imaging (identifying anatomical structures)
- Autonomous vehicles (lane detection)
- Face detection (finding facial features)

## 🐛 Troubleshooting

### Build Errors

**"cannot find -lnppif"**
```bash
# Check if NPP libraries exist
ls /usr/local/cuda/lib64/libnpp*

# Set CUDA path
export CUDA_PATH=/usr/local/cuda
export LD_LIBRARY_PATH=$CUDA_PATH/lib64:$LD_LIBRARY_PATH
```

**"FreeImage.h not found"**
```bash
# Install FreeImage
sudo apt-get install libfreeimage-dev  # Ubuntu/Debian
```

### Runtime Errors

**"No CUDA-capable device detected"**
- Verify GPU: `nvidia-smi`
- Check CUDA installation: `nvcc --version`
- Update NVIDIA drivers

**"Unable to open input file"**
- Check file exists: `ls -l yourimage.pgm`
- Use absolute path: `./edgeDetectionNPP --input=/full/path/to/image.pgm`
- Ensure file is grayscale PGM format

### Output Issues

**Edges are too faint**
- This is normal for Sobel output (low contrast)
- Try image enhancement: `convert edges.pgm -normalize edges_enhanced.pgm`
- Consider combining horizontal and vertical edges

**No output files created**
- Check write permissions in current directory
- Look for error messages in terminal output

## 💡 Tips & Tricks

### Best Results
- Use high-contrast images for clearer edges
- Grayscale images work better than color
- Higher resolution = more detailed edges

### Performance
- GPU processing is much faster than CPU
- Larger images benefit more from GPU acceleration
- Processing time: ~5-10ms for 512x512 image on modern GPU

### Image Preparation
```bash
# Resize large images
convert large.jpg -resize 1024x1024 -colorspace Gray input.pgm

# Enhance contrast before edge detection
convert input.jpg -normalize -colorspace Gray enhanced.pgm
```

## 📚 Technical Details

### NPP Functions Used
- `nppiFilterSobelHorizBorder_8u_C1R` - Horizontal Sobel filter
- `nppiFilterSobelVertBorder_8u_C1R` - Vertical Sobel filter
- `nppGetLibVersion` - Get NPP version info
- `nppiMalloc_8u_C1` - Allocate GPU image memory
- `nppiFree` - Free GPU memory

### Sobel Operator
The Sobel operator uses 3x3 convolution kernels:

**Horizontal (detects vertical edges):**
```
-1  0  +1
-2  0  +2
-1  0  +1
```

**Vertical (detects horizontal edges):**
```
-1  -2  -1
 0   0   0
+1  +2  +1
```

## 🔗 Related Resources

- **NPP Documentation**: https://docs.nvidia.com/cuda/npp/
- **CUDA Toolkit**: https://developer.nvidia.com/cuda-toolkit
- **Sobel Operator**: https://en.wikipedia.org/wiki/Sobel_operator
- **FreeImage**: http://freeimage.sourceforge.net/

## 🤝 Contributing

Feel free to enhance this project:
- Add command-line options for output filenames
- Implement combined edge output (horizontal + vertical)
- Add support for color images
- Implement other edge detection algorithms (Canny, Prewitt)
- Add image preprocessing options

## 📄 License

Based on NVIDIA CUDA Samples
- Original code: Copyright (c) 2019, NVIDIA CORPORATION
- See license in source file header

## 🙋 Need Help?

- Check **Troubleshooting** section above
- Read [NVIDIA NPP Documentation](https://docs.nvidia.com/cuda/npp/)
- Visit [NVIDIA Developer Forums](https://forums.developer.nvidia.com/)

---

## Quick Reference Card

```bash
# Build
./build.sh                              # Linux/Mac
build.bat                                # Windows

# Run
./edgeDetectionNPP                       # Use default image
./edgeDetectionNPP --input=photo.pgm    # Custom image

# Convert images
convert photo.jpg -colorspace Gray photo.pgm     # JPG to PGM
convert edges.pgm edges.png                       # PGM to PNG

# View results
display edges_horizontal.pgm             # Linux
open edges_horizontal.pgm                # Mac
```

**Output Files:**
- `{filename}_edges_horizontal.pgm` - Vertical edges (left-right changes)
- `{filename}_edges_vertical.pgm` - Horizontal edges (up-down changes)

---

**Happy Edge Detecting! 🔍✨**
