cls
:get

@echo off
Title FS Digital Signage Listener
echo -----------------------------
echo Checking Software Updates ...
echo -----------------------------
echo %DATE% - %TIME%
SET APPNAME=FS_Digtal_Signage
xcopy %1\*.* %appdata%\%APPNAME%\ /I /D /S /Y > nul

for /f "tokens=1,2,3,4,5,6,7 delims==" %%a in (%appdata%\%APPNAME%\ini\%2.ini) do (
if %%a==ServerRootDir set ServerRootDir=%%b
if %%a==LocalDir set LocalDir=%%b
if %%a==ImageDuration set ImageDuration=%%b
if %%a==Splash set Splash=%%b
if %%a==ServerLayoutDirName set ServerLayoutDirName=%%b
if %%a==Weather set Weather=%%b
if %%a==Weather-url set Weather-url=%%b
)

echo.
echo -----------------------------
echo Checking Basewindow ...
echo -----------------------------
cd %appdata%\%APPNAME%\splash
tasklist /nh /fi "imagename eq i_view64.exe" | find /i "i_view64.exe" > nul || (start "" i_view64.exe %Splash% /fs)
timeout 5
cd %appdata%\%APPNAME%

echo.
echo -----------------------------
echo Checking Content Changes ...
echo -----------------------------
Robocopy.exe %ServerRootDir%\%ServerLayoutDirName% %LocalDir% /xf *.db /MIR /FFT /Z /XA:H /R:3 /W:5 > nul

if "%Weather%"=="off" (goto sikipupdatehava) else (goto updatehava)

:sikipupdatehava 

goto countmedia

:updatehava
SiteShoter.exe /BrowserWidth 1920 /BrowserHeight 1080 /URL %Weather-url% /Filename %LocalDir%\z_hava.png

:countmedia
SET cnt=0
for %%A in (%LocalDir%\*) do set /a cnt+=1
if "%cnt%"=="1" (goto singlefile) else (goto multifile)

:singlefile
echo.
echo -----------------------------
echo Playing Now ...
echo -----------------------------
timeout 3  > nul
mpv.exe --mute --fullscreen --image-display-duration=900 "%LocalDir%" > nul


SET "ServerRootDir="
SET "LocalDir="
SET "ImageDuration="
SET "Splash="
SET "ServerLayoutDirName="
SET "cnt="
SET "Weather="
set "Weather-url="

cls
goto get


:multifile
echo.
echo -----------------------------
echo Playing Now ...
echo -----------------------------
ffmpeg -y -f lavfi -i anullsrc=r=44100:cl=mono -t %ImageDuration% -q:a 9 -acodec libmp3lame Duration.mp3 2>NUL
mpv.exe --mute --fullscreen --audio-file=Duration.mp3 "%LocalDir%" > nul



SET "ServerRootDir="
SET "LocalDir="
SET "ImageDuration="
SET "Splash="
SET "ServerLayoutDirName="
SET "cnt="
SET "Weather="
set "Weather-url="

cls
goto get
