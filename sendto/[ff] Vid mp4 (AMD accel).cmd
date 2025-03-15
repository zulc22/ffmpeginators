@echo off
rem MP4inator written by zulc22, 2021

rem snippet: https://stackoverflow.com/a/39776524
:argloop

call :processVid %1

shift
if not "%~1"=="" goto argloop

:processVid

ffmpeg -hwaccel d3d11va -hwaccel_output_format d3d11 -i "%~1" -c:v h264_amf -c:a aac -pix_fmt yuv420p "%~dpn1.yuv420p.mp4" || pause

exit /b