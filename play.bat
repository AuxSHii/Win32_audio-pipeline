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
set /p choice=" Enter song number to play: "

set "chosen_id=!track_%choice%!"

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
