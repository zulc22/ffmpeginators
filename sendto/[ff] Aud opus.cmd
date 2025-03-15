@echo off
rem MP4inator written by zulc22, 2021

rem snippet: https://stackoverflow.com/a/39776524
:argloop

call :processVid %1

shift
if not "%~1"=="" goto argloop

:processVid

ffmpeg -i "%~1" "%~dpn1.ff.opus"

exit /b