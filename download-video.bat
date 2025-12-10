@echo off
REM YouTube Video Downloader Batch Script
REM Simpler version for those who prefer batch files

echo ========================================
echo YouTube Video Downloader for BuildMate
echo ========================================
echo.

REM Check if yt-dlp exists
where yt-dlp >nul 2>nul
if %errorlevel% neq 0 (
    echo [ERROR] yt-dlp not found!
    echo.
    echo Please install yt-dlp first:
    echo   winget install yt-dlp
    echo.
    echo Or download from: https://github.com/yt-dlp/yt-dlp/releases
    echo.
    pause
    exit /b 1
)

echo [OK] yt-dlp found!
echo.

REM Create public folder
if not exist "public" (
    echo Creating public folder...
    mkdir public
)

echo Downloading video...
echo URL: https://www.youtube.com/watch?v=Vq1EF9V_QSc
echo Output: .\public\build-guide.mp4
echo.
echo This may take a few minutes...
echo.

yt-dlp -f "best[height<=720]" -o ".\public\build-guide.mp4" "https://www.youtube.com/watch?v=Vq1EF9V_QSc"

if %errorlevel% equ 0 (
    echo.
    echo [SUCCESS] Video downloaded successfully!
    echo Location: .\public\build-guide.mp4
    echo.
    echo To convert to GIF, use: https://ezgif.com/video-to-gif
    echo.
) else (
    echo.
    echo [ERROR] Download failed!
    echo.
    echo Try using online converter: https://ezgif.com/youtube-to-gif
    echo.
)

pause









