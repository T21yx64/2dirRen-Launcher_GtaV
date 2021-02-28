@echo off
rem Run As Adminstrator
rem inspired by https://github.com/achmadfauzihamibowo aka @achmadfhbw on Twitter
rem program is inpired; not the code, I know its sloppy not clean but it works so don't judge me Lol, feel free to use/commit/fork whatever..
rem mode is size of console
mode 50,20
color 0a

rem swapping begins here
rem cd current directory
cd /d "%~dp0"

:choice
title Original or Modded?
echo.

echo Launch Original or Modded? 1/3
set /p "starwars=input: "
if %starwars%==1 goto Original
if %starwars%==3 goto Modded
if not defined %starwars% goto choice 

:Original
cls
echo.
echo Checking folder current states...
echo.
timeout 1 /nobreak
echo.

if exist original.txt	(
	cls
	rem do not rename
	echo.
	echo Status Already Original..
	echo.
	timeout 1 /nobreak
	goto launcher
	) else (
	cls
	ren GTAV GTAVt
	ren GTAVo GTAV
	ren GTAVt GTAVm

	echo Files Renamed Successfully..

	ren notoriginal.txt original.txt
	echo.
	echo Status Changed from Modded to Original..
	echo.
	timeout 1 /nobreak
	goto launcher
	)	

:Modded
cls
echo.
echo Checking folder states...
echo.
timeout 1 /nobreak
echo.

if exist notoriginal.txt (
	rem do not rename
	echo.
	echo Status Already Modded..
	echo.
	timeout 1 /nobreak
	set "condition=true"
	goto launcher
	) else (
	cls
	ren GTAV GTAVt
	ren GTAVm GTAV
	ren GTAVt GTAVo

	echo Files Renamed Successfully..

	ren original.txt notoriginal.txt
	echo.
	echo Status Changed from Original to Modded..
	echo.
	timeout 1 /nobreak
	set "condition=true"
	goto launcher
	)
rem swapping ends here

:launcher
cls
echo Running Game..
timeout 1 /nobreak
rem shortucut file to run gtav from, preferably in same folder
start GTAVrun.url
timeout 1 /nobreak

rem below is for disabling net after launching modded

if "%condition%" == "true" (
	echo.
	netsh interface set interface name="Wi-Fi" admin=disabled
	netsh interface set interface name="Ethernet" admin=disabled
	timeout 1 /nobreak
	cls
	echo.
	echo internet disabled to protect from detection.
	echo.
	echo you will need to disable internet..specify duration to disable for
	goto choice )
:choicehrerr
if not %hr%==0 goto hrproc
cls
echo.
echo please correctly specify duration.
:choice
set /a zec=0
set /p "hr=Time(Hour): "
if %hr%==0 goto min
set /a zec=hr*3600
echo.
:min
set /p "min=Time(Min): "
if %min%==0 goto choicehrerr
set /a nec=min*60
set /a sec=nec+zec
goto proc
:hrproc
set /a sec=nec
goto proc
:proc
set time=%sec%
goto timeloop

:timeloop
cls
echo.
echo.
set /a time=%time%-1
if %time%==0 goto timesup
title Counting down...
echo.
echo.
echo.
echo Countdown - [%time%]
ping localhost -n 2 > nul
goto timeloop

:timesup
cls
echo.
echo Internet Enabled..
TIME /T
timeout 1 /nobreak
netsh interface set interface name="Wi-Fi" admin=enabled
netsh interface set interface name="Ethernet" admin=enabled
timeout 2 /nobreak


rem netsh interface set interface name="Wi-Fi" admin=disabled
rem netsh interface set interface name="Ethernet" admin=disabled
rem commands to enable disable internet
	
