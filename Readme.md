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

```
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
iwr -useb get.scoop.sh | iex
```
### 2. Install the Required Tools
Open yoCommand Prompt (cmd.exe) (cmd.exe)** and install the 32-bit compatible tools:

```
scoop install yt-dlp mplayer
```

*Note: Make sure you aNode.js **Node.js** installed on your Windows system to handle background decryption.*

### 3. Setup the Shortcut Script
1. Create a text file in your user directory (C:\Users\YOUR_USERNAME\) and name it play.bat.
2. Open it with any text editor and paste the following code:

```
@echo off
yt-dlp "ytsearch1:%*" -f ba --js-runtimes node -o - | "%USERPROFILE%\scoop\apps\mplayer\current\mplayer.exe" -cache 8192 -
```
## How to Use It

Open your terminal from anywhere and run the script by typing play followed by any song name, artist, or album keyword:

```
play beatles don't let me down
```

 


### Live Keyboard Controls
While the track is playing natively inside your console, click on the terminal window and use these sSpacebar:*Spacebar:** Pause / Resume9:ack
* **9:** Turn Vo0:own
* **0:** Turn q / Esc:**q / Esc:** Stop playing and return to the prompt












