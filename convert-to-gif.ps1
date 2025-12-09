# Convert MP4 to GIF Script
# Converts the downloaded PC build video to optimized GIF

$inputVideo = "PC Disassembly & Assembly Guide _ Gabayan sa Pag-disassemble at Pag-assemble ng PC (3D Animation).mp4"
$outputGif = ".\public\build-guide.gif"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "MP4 to GIF Converter for BuildMate" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if input file exists
if (-not (Test-Path $inputVideo)) {
    Write-Host "[ERROR] Input video not found!" -ForegroundColor Red
    Write-Host "Looking for: $inputVideo" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Please make sure the video file is in the current directory." -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}

Write-Host "[OK] Input video found!" -ForegroundColor Green
$fileSize = (Get-Item $inputVideo).Length / 1MB
Write-Host "File size: $([math]::Round($fileSize, 2)) MB" -ForegroundColor Cyan
Write-Host ""

# Check for ffmpeg
Write-Host "Checking for ffmpeg..." -ForegroundColor Yellow
$ffmpegInstalled = Get-Command ffmpeg -ErrorAction SilentlyContinue

if (-not $ffmpegInstalled) {
    Write-Host "[ERROR] ffmpeg not found! Installing..." -ForegroundColor Red
    Write-Host "Installing via winget..." -ForegroundColor Yellow
    Write-Host ""
    
    winget install ffmpeg
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "[ERROR] Installation failed!" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please install ffmpeg manually:" -ForegroundColor Yellow
        Write-Host "  winget install ffmpeg" -ForegroundColor Cyan
        Write-Host "  OR download from: https://ffmpeg.org/download.html" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Alternative: Use online converter at https://ezgif.com/video-to-gif" -ForegroundColor Yellow
        Write-Host ""
        pause
        exit 1
    }
    
    Write-Host ""
    Write-Host "Please restart PowerShell and run this script again." -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 0
}

Write-Host "[OK] ffmpeg found!" -ForegroundColor Green
Write-Host ""

# Create public folder if it doesn't exist
if (-not (Test-Path ".\public")) {
    Write-Host "Creating public folder..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path ".\public" | Out-Null
}

# Ask user for preferences
Write-Host "GIF Conversion Options:" -ForegroundColor Cyan
Write-Host "1. Quick (30 seconds, 720p, 10 fps) - ~10-15 MB" -ForegroundColor Yellow
Write-Host "2. Medium (60 seconds, 720p, 10 fps) - ~20-30 MB" -ForegroundColor Yellow
Write-Host "3. Full (all, 720p, 10 fps) - ~40-60 MB" -ForegroundColor Yellow
Write-Host "4. Custom" -ForegroundColor Yellow
Write-Host ""

$choice = Read-Host "Select option (1-4)"

switch ($choice) {
    "1" {
        $duration = 30
        $width = 720
        $fps = 10
    }
    "2" {
        $duration = 60
        $width = 720
        $fps = 10
    }
    "3" {
        $duration = 0  # Full video
        $width = 720
        $fps = 10
    }
    "4" {
        $duration = Read-Host "Duration in seconds (0 for full video)"
        $width = Read-Host "Width in pixels (e.g., 720)"
        $fps = Read-Host "Frame rate (e.g., 10)"
    }
    default {
        Write-Host "Invalid option. Using Quick settings." -ForegroundColor Yellow
        $duration = 30
        $width = 720
        $fps = 10
    }
}

Write-Host ""
Write-Host "Converting to GIF..." -ForegroundColor Yellow
Write-Host "Settings:" -ForegroundColor Cyan
Write-Host "  Duration: $(if ($duration -eq 0) { 'Full video' } else { "$duration seconds" })" -ForegroundColor Cyan
Write-Host "  Width: ${width}px" -ForegroundColor Cyan
Write-Host "  Frame rate: ${fps} fps" -ForegroundColor Cyan
Write-Host ""
Write-Host "This will take several minutes..." -ForegroundColor Yellow
Write-Host "Please wait..." -ForegroundColor Yellow
Write-Host ""

# Build ffmpeg command
$ffmpegCmd = "ffmpeg -i `"$inputVideo`""

if ($duration -gt 0) {
    $ffmpegCmd += " -t $duration"
}

$ffmpegCmd += " -vf `"fps=$fps,scale=${width}:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse`" -loop 0 `"$outputGif`""

# Execute conversion
Invoke-Expression $ffmpegCmd

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "✓ GIF created successfully!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Output: $outputGif" -ForegroundColor Cyan
    
    $gifSize = (Get-Item $outputGif).Length / 1MB
    Write-Host "File size: $([math]::Round($gifSize, 2)) MB" -ForegroundColor Cyan
    Write-Host ""
    
    if ($gifSize -gt 50) {
        Write-Host "[WARNING] GIF file is large (>50 MB)" -ForegroundColor Yellow
        Write-Host "Consider using shorter duration or lower resolution for better performance." -ForegroundColor Yellow
        Write-Host ""
    }
    
    Write-Host "The GIF is ready to use in your build guide!" -ForegroundColor Green
    Write-Host "It will automatically display on: localhost:3000/guides/beginner-gaming-build" -ForegroundColor Cyan
    Write-Host ""
    
} else {
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Red
    Write-Host "✗ Conversion failed!" -ForegroundColor Red
    Write-Host "========================================" -ForegroundColor Red
    Write-Host ""
    Write-Host "Try using online converter instead:" -ForegroundColor Yellow
    Write-Host "https://ezgif.com/video-to-gif" -ForegroundColor Cyan
    Write-Host ""
}

Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")





