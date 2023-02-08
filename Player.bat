:get

for /f "tokens=1,2,3,4,5 delims==" %%a in (Player.ini) do (
if %%a==ServerRootDir set ServerRootDir=%%b
if %%a==LocalDir set LocalDir=%%b
if %%a==ImageDuration set ImageDuration=%%b
if %%a==Splash set Splash=%%b
if %%a==ServerLayoutDirName set ServerLayoutDirName=%%b
)

SET CurrentDir="%~dp0"



tasklist /nh /fi "imagename eq basewindow.exe" | find /i "basewindow.exe" > nul || (start "" %CurrentDir%basewindow.exe %Splash%)








mkdir %LocalDir%

 



ffmpeg -y -f lavfi -i anullsrc=r=44100:cl=mono -t %ImageDuration% -q:a 9 -acodec libmp3lame Duration.mp3








%CurrentDir%Robocopy.exe %ServerRootDir%\%ServerLayoutDirName% %LocalDir% /xf *.db /MIR /FFT /Z /XA:H /R:3 /W:5



SET cnt=0
for %%A in (%LocalDir%\*) do set /a cnt+=1
if "%cnt%"=="1" (goto singlefile) else (goto multifile)




:singlefile
%CurrentDir%mpv.exe --fullscreen  --audio-file=Duration.mp3 "%LocalDir%" --loop-playlist


:multifile
%CurrentDir%mpv.exe --fullscreen  --audio-file=Duration.mp3 "%LocalDir%"


SET "ServerRootDir="
SET "LocalDir="
SET "ImageDuration="
SET "Splash="
SET "PlayMode="
SET "ServerLayoutDirName="
SET "cnt="





goto get
