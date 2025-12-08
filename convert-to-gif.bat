@echo off
REM Convert MP4 to GIF - Simple Batch Version

echo ========================================
echo MP4 to GIF Converter for BuildMate
echo ========================================
echo.

set INPUT_VIDEO=PC Disassembly ^& Assembly Guide _ Gabayan sa Pag-disassemble at Pag-assemble ng PC (3D Animation).mp4
set OUTPUT_GIF=.\public\build-guide.gif

REM Check if input file exists
if not exist "%INPUT_VIDEO%" (
    echo [ERROR] Input video not found!
    echo Looking for: %INPUT_VIDEO%
    echo.
    echo Please make sure the video file is in the current directory.
    echo.
    pause
    exit /b 1
)

echo [OK] Input video found!
echo.

REM Check for ffmpeg
where ffmpeg >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] ffmpeg not found!
    echo.
    echo Please install ffmpeg first:
    echo   winget install ffmpeg
    echo.
    echo Or download from: https://ffmpeg.org/download.html
    echo.
    echo Alternative: Use https://ezgif.com/video-to-gif
    echo.
    pause
    exit /b 1
)

echo [OK] ffmpeg found!
echo.

REM Create public folder
if not exist "public" (
    echo Creating public folder...
    mkdir public
)

echo Converting to GIF...
echo Duration: 60 seconds
echo Width: 720px
echo Frame rate: 10 fps
echo.
echo This will take several minutes...
echo Please wait...
echo.

REM Convert to GIF (60 seconds, 720p, 10fps)
ffmpeg -i "%INPUT_VIDEO%" -t 60 -vf "fps=10,scale=720:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "%OUTPUT_GIF%"

if %errorlevel% equ 0 (
    echo.
    echo ========================================
    echo [SUCCESS] GIF created successfully!
    echo ========================================
    echo.
    echo Output: %OUTPUT_GIF%
    echo.
    echo The GIF is ready to use in your build guide!
    echo.
) else (
    echo.
    echo ========================================
    echo [ERROR] Conversion failed!
    echo ========================================
    echo.
    echo Try using online converter: https://ezgif.com/video-to-gif
    echo.
)

pause


