@echo off
chcp 936 > nul
set endpoint=162.159.192.1:2408
set /p endpoint=Please enter the port that needs to be tested (default %endpoint%):
warp-cli.exe clear-custom-endpoint
warp-cli.exe set-custom-endpoint %endpoint%
echo The current endpoint has been set to %endpoint%
pause