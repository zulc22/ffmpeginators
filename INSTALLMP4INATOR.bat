@echo off
cd /d "%~dp0"
set sendto=%appdata%\Microsoft\Windows\SendTo
goto instm

:cperms
net session >nul 2>&1
IF %ERRORLEVEL% NEQ 0 goto rperms
exit /b

:rperms
powershell -NonInteractive -NoLogo -NoProfile -Command "Start-Process '%~nx0' -Verb RunAs"
exit

:instm
where ffmpeg >nul 2>&1 || goto instff
del /q "%sendto%\[ff] *.*"
copy /y "sendto\*.*" "%sendto%\"
taskkill /im explorer.exe /f
start explorer
echo Done
pause
exit

:instff
echo FFMPEG not found in PATH! Installing FFMPEG with Chocolatey
where choco >nul 2>&1 || goto instffs
call :cperms
choco install -y ffmpeg || goto chocofail
goto instm

:chocofail
echo Choco failed?
echo Failed to install. Press any key to exit.
pause > nul
exit

:instffs
echo Choco not found in PATH! Installing FFMPEG with Scoop
where scoop >nul 2>&1 || goto instscoop
scoop install ffmpeg
goto instm

:instscoop
echo Scoop not found in PATH! Installing Scoop
powershell -NoLogo -NoProfile -NonInteractive -Command "Set-ExecutionPolicy Bypass -scope CurrentUser"
powershell -NoLogo -NoProfile -NonInteractive -Command "iwr -useb get.scoop.sh | iex"
RefreshEnv.cmd
goto instm