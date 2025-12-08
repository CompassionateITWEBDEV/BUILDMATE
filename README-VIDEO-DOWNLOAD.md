# Video Download Guide

This folder contains scripts to download the YouTube video for the build guide.

## Quick Start

### Option 1: PowerShell Script (Recommended)
```powershell
.\download-video.ps1
```

Features:
- Auto-installs yt-dlp if missing
- Downloads video at 720p quality
- Optional GIF conversion with ffmpeg
- Progress indicators

### Option 2: Batch Script (Simple)
```cmd
download-video.bat
```

Simpler version, downloads video only.

### Option 3: Online Converter (Easiest)
1. Go to: https://ezgif.com/youtube-to-gif
2. Paste: `https://www.youtube.com/watch?v=Vq1EF9V_QSc`
3. Select duration (30-60 seconds recommended)
4. Download and save as `public/build-guide.gif`

## Prerequisites

### For PowerShell Script:
- **yt-dlp** (auto-installs if missing)
  ```powershell
  winget install yt-dlp
  ```

- **ffmpeg** (optional, for GIF conversion)
  ```powershell
  winget install ffmpeg
  ```

### For Batch Script:
- **yt-dlp** only
  ```cmd
  winget install yt-dlp
  ```

## Manual Installation

If winget doesn't work:

**yt-dlp:**
1. Download from: https://github.com/yt-dlp/yt-dlp/releases
2. Extract `yt-dlp.exe` to a folder in your PATH

**ffmpeg:**
1. Download from: https://ffmpeg.org/download.html
2. Extract and add to PATH

## Troubleshooting

### Script execution policy error
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### yt-dlp not found
- Install manually from: https://github.com/yt-dlp/yt-dlp/releases
- Or use online converter

### GIF file too large
- Reduce duration (30 seconds instead of 60)
- Lower frame rate (5-10 fps)
- Reduce resolution (480p instead of 720p)

## Output Files

- **Video:** `public/build-guide.mp4` (~50-100 MB)
- **GIF:** `public/build-guide.gif` (~20-50 MB depending on settings)

## GIF Settings

The PowerShell script creates GIF with:
- Duration: 60 seconds
- Resolution: 720p width
- Frame rate: 10 fps
- Optimized color palette

## Alternative Online Tools

1. **ezgif.com** - https://ezgif.com/youtube-to-gif
2. **gifs.com** - https://gifs.com/
3. **giphy.com** - https://giphy.com/create/gifmaker

## After Download

Once you have the GIF file, the code will automatically display it on the build guide page:
- Location: `localhost:3000/guides/beginner-gaming-build`
- The GIF will replace the YouTube embed

## Questions?

For issues or questions, check the documentation or try the online converter method.


