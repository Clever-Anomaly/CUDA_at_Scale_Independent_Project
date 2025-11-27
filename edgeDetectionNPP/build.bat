@echo off
REM Build script for Edge Detection NPP (Windows)
REM Requires: Visual Studio with CUDA Toolkit installed

echo ==========================================
echo Building Edge Detection NPP
echo ==========================================
echo.

REM Check for CUDA
where nvcc >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: nvcc not found. Please install CUDA Toolkit.
    echo Download from: https://developer.nvidia.com/cuda-downloads
    echo Make sure CUDA bin directory is in your PATH.
    pause
    exit /b 1
)

REM Set CUDA path (modify if needed)
if not defined CUDA_PATH (
    set CUDA_PATH=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.4
)

echo CUDA Path: %CUDA_PATH%
echo Building edgeDetectionNPP...
echo.

REM Compiler flags
set INCLUDES=-I..\Common -I..\Common\UtilNPP
set LIBS=-L"%CUDA_PATH%\lib\x64" nppif.lib nppisu.lib nppc.lib cudart.lib
set CXXFLAGS=-O2

REM Build
nvcc %CXXFLAGS% -o edgeDetectionNPP.exe edgeDetectionNPP.cpp %INCLUDES% %LIBS%

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ==========================================
    echo Build Successful!
    echo ==========================================
    echo.
    echo Executable: edgeDetectionNPP.exe
    echo.
    echo Usage:
    echo   edgeDetectionNPP.exe
    echo   edgeDetectionNPP.exe --input=image.pgm
    echo.
) else (
    echo.
    echo ==========================================
    echo Build Failed
    echo ==========================================
    echo.
    echo Common issues:
    echo   1. Missing FreeImage library
    echo   2. Wrong CUDA path
    echo   3. Missing NPP libraries
    echo.
)

pause
