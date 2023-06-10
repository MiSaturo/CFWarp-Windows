chcp 936
cls
@echo off & setlocal enabledelayedexpansion
goto start

:start
if not exist "warp.exe" echo missing warp.exe program & pause & exit
if not exist "ips-v4.txt" echo missing IPV4 data ips-v4.txt & pause & exit
if not exist "ips-v6.txt" echo missing IPV6 data ips-v6.txt & pause & exit
goto main

:main
title WARP Endpoint IP one-click optimization script
set /a menu=1
echo ################################################## ############
echo # WARP Endpoint IP one-click optimization script #
echo # Author: MisakaNo ¤Î Xiaopozhan #
echo # Blog: https://blog.misaka.rest #
echo # GitHub project: https://github.com/Misaka-blog #
echo # GitLab project: https://gitlab.com/Misaka-blog #
echo # Telegram channel: https://t.me/misaka_noc #
echo # Telegram group: https://t.me/misaka_noc_chat #
echo # YouTube Channel: https://www.youtube.com/@misaka-blog #
echo ################################################## ############
echo.
echo 1. WARP IPv4 Endpoint IP preferred
echo 2. WARP IPv6 Endpoint IP preferred
echo -------------
echo 0. exit
echo.
set /p menu=Please enter options (default %menu%):
if %menu%==0 exit
if %menu%==1 title WARP IPv4 Endpoint IP Preference & set filename=ips-v4.txt & goto getv4
if %menu%==2 title WARP IPv6 Endpoint IP Preference & set filename=ips-v6.txt & goto getv6
cls
goto main

:getv4
for /f "delims=" %%i in (%filename%) do (
set !random!_%%i=randomsort
)
for /f "tokens=2,3,4 delims=_.=" %%i in ('set ^| findstr =randomsort ^| sort /m 10240') do (
call :randomcidrv4
if not defined %%i.%%j.%%k.!cidr! set %%i.%%j.%%k.!cidr!=anycastip&set /a n+=1
if !n! EQU 255 goto getip
)
goto getv4

:randomcidrv4
set /a cidr=%random%%%256
goto :eof

:getv6
for /f "delims=" %%i in (%filename%) do (
set !random!_%%i=randomsort
)
for /f "tokens=2,3,4 delims=_:=" %%i in ('set ^| findstr =randomsort ^| sort /m 10240') do (
call :randomcidrv6
if not defined [%%i:%%j:%%k::!cidr!] set [%%i:%%j:%%k::!cidr!]=anycastip&set /a n+=1
if !n! EQU 100 goto getip
)
goto getv6

:randomcidrv6
set str=0123456789abcdef
set /a r=%random%%%16
set cidr=!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!:!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!:!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!:!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
set /a r=%random%%%16
set cidr=!cidr!!str:~%r%,1!
goto :eof

:getip
del ip.txt > nul 2>&1
for /f "tokens=1 delims==" %%i in ('set ^| findstr =randomsort') do (
set %%i=
)
for /f "tokens=1 delims==" %%i in ('set ^| findstr =anycastip') do (
echo %%i>>ip.txt
)
for /f "tokens=1 delims==" %%i in ('set ^| findstr =anycastip') do (
set %%i=
)

warp
del ip.txt > nul 2>&1
echo Please press any key to close the window
pause > nul
exit