# Quick Convert - MP4 to GIF
# File is already in public folder

$inputVideo = ".\public\PC Disassembly & Assembly Guide _ Gabayan sa Pag-disassemble at Pag-assemble ng PC (3D Animation).mp4"
$outputGif = ".\public\build-guide.gif"

Write-Host "Converting video to GIF..." -ForegroundColor Cyan
Write-Host "Input: $inputVideo" -ForegroundColor Yellow
Write-Host "Output: $outputGif" -ForegroundColor Yellow
Write-Host ""

# Check for ffmpeg
$ffmpeg = Get-Command ffmpeg -ErrorAction SilentlyContinue
if (-not $ffmpeg) {
    Write-Host "[ERROR] ffmpeg not found!" -ForegroundColor Red
    Write-Host "Installing..." -ForegroundColor Yellow
    winget install ffmpeg
    Write-Host ""
    Write-Host "Please restart PowerShell and run this script again." -ForegroundColor Yellow
    pause
    exit 1
}

Write-Host "Converting... (this will take a few minutes)" -ForegroundColor Green
Write-Host "Duration: 60 seconds | Resolution: 720p | FPS: 10" -ForegroundColor Cyan
Write-Host ""

# Convert to GIF (60 seconds, 720p, 10fps for good balance)
ffmpeg -i $inputVideo -t 60 -vf "fps=10,scale=720:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $outputGif

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "[SUCCESS] GIF created!" -ForegroundColor Green
    $size = (Get-Item $outputGif).Length / 1MB
    Write-Host "Size: $([math]::Round($size, 2)) MB" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Refresh your browser to see the GIF!" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "[ERROR] Conversion failed!" -ForegroundColor Red
}

pause

