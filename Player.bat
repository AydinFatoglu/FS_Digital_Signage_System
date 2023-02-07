@echo off

echo Starting up...
timeout 5 >nul 2>&1 

echo Player Running

for /f "tokens=1,2,3,4 delims==" %%a in (Player.ini) do (
if %%a==ServerDir set ServerDir=%%b
if %%a==LocalDir set LocalDir=%%b
if %%a==Duration set Duration=%%b
if %%a==Splash set Splash=%%b
)


SET CurrentDir="%~dp0"
SET ffmpegDir=%~dp0

mkdir %LocalDir% >nul 2>&1

start "" %CurrentDir%basewindow.exe %Splash% 

%ffmpegtDir%ffmpeg -y -f lavfi -i anullsrc=r=44100:cl=mono -t %Duration% -q:a 9 -acodec libmp3lame Duration.mp3 >nul 2>&1

:get


TASKKILL /F /IM mpv.exe >nul 2>&1

%CurrentDir%Robocopyx %ServerDir% %LocalDir% /xf *.db /MIR /FFT /Z /XA:H /R:0 /W:2 >nul 2>&1

%CurrentDir%mpv.exe --fullscreen  --audio-file=Duration.mp3 "%LocalDir%" >nul 2>&1

goto get
