# YouTube Video Downloader Script
# This script downloads the YouTube video and optionally converts it to GIF

$videoUrl = "https://www.youtube.com/watch?v=Vq1EF9V_QSc"
$outputVideo = ".\public\build-guide.mp4"
$outputGif = ".\public\build-guide.gif"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "YouTube Video Downloader for BuildMate" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if yt-dlp is installed
Write-Host "Checking for yt-dlp..." -ForegroundColor Yellow
$ytdlpInstalled = Get-Command yt-dlp -ErrorAction SilentlyContinue

if (-not $ytdlpInstalled) {
    Write-Host "yt-dlp not found! Installing..." -ForegroundColor Red
    Write-Host "Installing via winget..." -ForegroundColor Yellow
    winget install yt-dlp
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Host "Installation failed. Please install manually:" -ForegroundColor Red
        Write-Host "Option 1: winget install yt-dlp" -ForegroundColor Yellow
        Write-Host "Option 2: Download from https://github.com/yt-dlp/yt-dlp/releases" -ForegroundColor Yellow
        exit 1
    }
}

Write-Host "yt-dlp found!" -ForegroundColor Green
Write-Host ""

# Create public folder if it doesn't exist
if (-not (Test-Path ".\public")) {
    Write-Host "Creating public folder..." -ForegroundColor Yellow
    New-Item -ItemType Directory -Path ".\public" | Out-Null
}

# Download video
Write-Host "Downloading video from YouTube..." -ForegroundColor Yellow
Write-Host "URL: $videoUrl" -ForegroundColor Cyan
Write-Host "Output: $outputVideo" -ForegroundColor Cyan
Write-Host ""
Write-Host "This may take a few minutes..." -ForegroundColor Yellow
Write-Host ""

yt-dlp -f "best[height<=720]" -o $outputVideo $videoUrl

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✓ Video downloaded successfully!" -ForegroundColor Green
    Write-Host "Location: $outputVideo" -ForegroundColor Cyan
    Write-Host ""
    
    # Ask if user wants to convert to GIF
    $convertGif = Read-Host "Do you want to convert to GIF? (y/n)"
    
    if ($convertGif -eq "y" -or $convertGif -eq "Y") {
        # Check for ffmpeg
        $ffmpegInstalled = Get-Command ffmpeg -ErrorAction SilentlyContinue
        
        if (-not $ffmpegInstalled) {
            Write-Host ""
            Write-Host "ffmpeg not found! Installing..." -ForegroundColor Red
            Write-Host "Installing via winget..." -ForegroundColor Yellow
            winget install ffmpeg
            
            if ($LASTEXITCODE -ne 0) {
                Write-Host ""
                Write-Host "Please install ffmpeg manually or use online converter" -ForegroundColor Yellow
                Write-Host "Recommended: https://ezgif.com/video-to-gif" -ForegroundColor Cyan
                exit 0
            }
        }
        
        Write-Host ""
        Write-Host "Converting to GIF..." -ForegroundColor Yellow
        Write-Host "This will take several minutes..." -ForegroundColor Yellow
        Write-Host ""
        
        # Convert to GIF with good quality
        # Extract first 60 seconds, resize to 720p width, 10 fps
        ffmpeg -i $outputVideo -t 60 -vf "fps=10,scale=720:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $outputGif
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "✓ GIF created successfully!" -ForegroundColor Green
            Write-Host "Location: $outputGif" -ForegroundColor Cyan
            
            $fileSize = (Get-Item $outputGif).Length / 1MB
            Write-Host "File size: $([math]::Round($fileSize, 2)) MB" -ForegroundColor Cyan
        } else {
            Write-Host ""
            Write-Host "GIF conversion failed. Try online converter:" -ForegroundColor Red
            Write-Host "https://ezgif.com/video-to-gif" -ForegroundColor Cyan
        }
    }
} else {
    Write-Host ""
    Write-Host "✗ Download failed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Try using online converter instead:" -ForegroundColor Yellow
    Write-Host "https://ezgif.com/youtube-to-gif" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Done!" -ForegroundColor Green
Write-Host ""









