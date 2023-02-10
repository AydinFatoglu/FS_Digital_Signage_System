cls
:get

@echo off
Title FS Digital Signage Listener
echo -----------------------------
echo Checking Software Updates ...
echo -----------------------------

SET APPNAME=FS_Digtal_Signage

xcopy %1\*.* %appdata%\%APPNAME%\ /I /D /S /Y > nul

for /f "tokens=1,2,3,4,5 delims==" %%a in (%appdata%\%APPNAME%\ini\%2.ini) do (
if %%a==ServerRootDir set ServerRootDir=%%b
if %%a==LocalDir set LocalDir=%%b
if %%a==ImageDuration set ImageDuration=%%b
if %%a==Splash set Splash=%%b
if %%a==ServerLayoutDirName set ServerLayoutDirName=%%b
)

echo.
echo -----------------------------
echo Checking Basewindow ...
echo -----------------------------
cd %appdata%\%APPNAME%\splash
tasklist /nh /fi "imagename eq basewindow.exe" | find /i "basewindow.exe" > nul || (start "" basewindow.exe %Splash%)

cd %appdata%\%APPNAME%

echo.
echo -----------------------------
echo Checking Content Changes ...
echo -----------------------------
Robocopy.exe %ServerRootDir%\%ServerLayoutDirName% %LocalDir% /xf *.db /MIR /FFT /Z /XA:H /R:3 /W:5 > nul

SET cnt=0
for %%A in (%LocalDir%\*) do set /a cnt+=1
if "%cnt%"=="1" (goto singlefile) else (goto multifile)

:singlefile
ffmpeg -y -f lavfi -i anullsrc=r=44100:cl=mono -t 900 -q:a 9 -acodec libmp3lame Duration.mp3 2>NUL
echo.
echo -----------------------------
echo Playing Now ...
echo -----------------------------
mpv.exe --fullscreen  --audio-file=Duration.mp3 "%LocalDir%" > nul

:multifile
ffmpeg -y -f lavfi -i anullsrc=r=44100:cl=mono -t %ImageDuration% -q:a 9 -acodec libmp3lame Duration.mp3 2>NUL
echo.
echo -----------------------------
echo Playing Now ...
echo -----------------------------
mpv.exe --fullscreen  --audio-file=Duration.mp3 "%LocalDir%" > nul

SET "ServerRootDir="
SET "LocalDir="
SET "ImageDuration="
SET "Splash="
SET "PlayMode="
SET "ServerLayoutDirName="
SET "cnt="
SET "CurrentDir="
SET "APPNAME="

echo.
echo -----------------------------
echo Sleeping for 5 seconds ...
echo -----------------------------
timeout 5 > nul 
goto get
