# Windows CLI YouTube Audio Streamer 🎵

An ultra-lightweight, high-performance terminal script designed to search and stream YouTube audio directly from the command line without opening a heavy web browser. 

This project is fully optimized for **legacy 32-bit (x86) Windows systems** and low-spec PCs, bypassing modern GPU acceleration bugs (like Vulkan crashes) by piping raw audio streams directly into a legacy media engine.

## ✨ Features
* **Zero Disk Waste:** Streams audio directly through system memory (RAM). No audio files are downloaded to your hard drive.
* **Low Resource Usage:** Uses almost 0% CPU and minimal RAM—perfect for keeping old computers fast and responsive.
* **No Vulkan/GPU Crashes:** Explicitly strips out heavy video layers to run safely on older integrated graphics cards.
* **Ad-Free Playback:** Automatically bypasses video advertisements.

---

## 🛠️ Tech Stack & Architecture
This script builds a simple **live media data pipeline** right inside the Windows terminal:

1. **Scraper Engine (`yt-dlp`):** Handles searching YouTube and fetches raw streaming URLs.
2. **Decryption Layer (`Node.js`):** Resolves YouTube's internal signature encryption algorithm.
3. **The Data Pipe (`|`):** A native operating system pipeline that routes live audio data directly between tools without hitting the disk.
4. **Playback Engine (`mplayer`):** A lightweight, 32-bit media compiler that handles playback via standard system audio drivers.

---

## 🚀 Prerequisites & Installation

### 1. Set Up the Package Manager
Open **PowerShell** and install **Scoop** (the developer-focused repository manager for Windows):

@echo off
setlocal enabledelayedexpansion

:: 1. Clear screen and show a clean loading message
cls
echo [Searching YouTube for: %*...]
:: 2. Fetch metadata quietly behind the scenes
yt-dlp "ytsearch5:%*" --print "%%(title)s [%%(duration_string)s] | %%(id)s" --js-runtimes node --quiet > %TEMP%\yt_raw.txt

cls
echo ======================================================================
echo                          CHOOSE A TRACK                              
echo ======================================================================
echo.

:: 3. Build the minimal list layout
set count=1
for /f "tokens=1,2 delims=|" %%A in (%TEMP%\yt_raw.txt) do (
    set "line=%%A"
    set "id=%%B"
    for /f "tokens=*" %%X in ("!id!") do set "id=%%X"
    set "track_!count!=!id!"
    echo  [!count!] !line!
    set /a count+=1
)
echo.
echo ======================================================================
set /p choice=" Enter song number to play: "set "chosen_id=!track_%choice%!"
if "!chosen_id!"=="" (
    echo [!] Invalid selection. Exiting.
    exit /b
)
:: 4. Get the direct streaming link using yt-dlp quietly
cls
echo [Loading audio stream...]
for /f "delims=" %%I in ('yt-dlp --get-url -f ba --js-runtimes node "!chosen_id!"') do set "stream_url=%%I"
:: 5. Launch audio streaming with native status reporting enabled
cls
echo ======================================================================
echo  Now Playing: Track #%choice%
echo  Controls: [Space] Pause/Play  ^|  [9] Vol Down  ^|  [0] Vol Up  ^|  [Q] Exit
echo ======================================================================
echo.
C:\Users\Rith\scoop\apps\mplayer\current\mplayer.exe -cache 8192 -msglevel statusline=5:all=0 "!stream_url!"
endlocal
