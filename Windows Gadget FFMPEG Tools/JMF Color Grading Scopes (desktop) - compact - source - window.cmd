REM This script uses FFPLAY to display vectorscope
REM with waveform parade and luma of a window capture
REM Copyright (c) 2018 Jacob Maximilian Fober
REM This work is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
REM (CC BY-SA 4.0) https://creativecommons.org/licenses/by-sa/4.0/
echo off
cls
title=JMF Grading Scopes (window capture)
set /a cpuT=%NUMBER_OF_PROCESSORS%*3/2
call :logo
echo  ╔══════════════════════════════╗
echo  ║To reset captured window name,║
echo  ║please close the scope window.║
echo  ╚══════════════════════════════╝
call :instruction
:scope
set /p name="Please enter window name to capture> "
ffplay -hide_banner -threads %cpuT% -f gdigrab -framerate 11 ^
-i title=%name% -window_title^
 "JMF Grading Scopes - %name% - window capture" ^
-vf split=3[vector][wave][source],^

[vector]^
format=yuv444p9,^
vectorscope=mode=color3:graticule=color:colorspace=601,^
drawbox=w=5:h=5:t=2:x=208-2:y=194-2:c=sienna@0.8,^
drawbox=w=5:h=5:t=2:x=218-2:y=207-2:c=sienna@0.8,^
drawbox=w=5:h=5:t=2:x=234-2:y=227-2:c=sienna@0.8,^
drawbox=w=5:h=5:t=2:x=244-2:y=241-2:c=sienna@0.8,^
drawbox=w=4:h=4:t=1:x=317-2:y=364-2:c=skyblue@0.8^
[vector],^

[wave]^
scale=256:ih,^
split=2[parade][luma],^

[parade]^
format=gbrp,^
waveform=filter=lowpass:i=0.02:components=7:display=overlay^
[parade],^

[luma]^
format=yuva444p,^
waveform=filter=lowpass:scale=ire:graticule=green:flags=numbers+dots^
[luma],^

[parade][luma]hstack^

[wave],^

[source]^
scale=496:112:force_original_aspect_ratio=decrease,^
pad=w=512:h=128:x=-1:y=-1,^
format=gbrp,^
format=yuva444p^
[source],^

[vector][wave][source]vstack=inputs=3
if errorlevel 9009 (
	cls
	title=JMF Grading Scopes - Error
	ffplay
	echo.
	echo Missing FFplay.exe software.
	echo Please check your user Environment Variables in system settings.
	echo.
	echo You can download FFplay packages at:
	echo https://ffmpeg.org
	echo.
	echo ...press any key to visit download website
	pause
	start http://ffmpeg.zeranoe.com/builds/
)
cls
call :instruction
goto :scope
:logo
echo Made by...
echo  ▀███████████     ███████       ███████ ▀██████████████████▄
echo  ░██▓▓▓▓▓▓▓▓██   ██▓▓▓▓▓██     ██▓▓▓▓▓██ ▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▄
echo  ▒░██▓▒▒▒▒▒▒▓██ ▄██▓▒▒▒▒▓██   ██▓▒▒▒░▒▓██ ░██▓▓▒▒▒▒▒▒▓███████▄
echo  ▓▒ ██████▓▒▒▓██░ ██▓▓▓░▒▓██ ██▓▒▓▓▒▒░▒▓██ ░██▓▓░░░░▒▒▓██▄░  ▒
echo  ▀▓░ ▀▀▀▀██▓░▒▓██░ ██▓█▓░▒▓███▓▒▓▓█▓▓▒░▒▓██ ░██▓▓▒░▒▓▓▓▓██▄ ░▓
echo   ▀▓▒░  ░▓██▓░▒▓██░ ▀███▓▓▒▓▓▓▒▓▓███▓▓▒░▒▓██ ░██▓▓░▒▓██████▄▒▓
echo    ▀▓░▄░▒▓░██▓░▒▓██░░▀░██▓▓▒░▒▓▓██░██▓▓▒░▒▓██ ░██▓▓░▒▓██▄ ▒░▀▀
echo     ▀███▒▒▒░██▓░▒▓██░░▒ ██▓▓▒▓▓██ ░ ██▓▓▒▓▓██▀░░██▓▓░▓▓██ ▓▒
echo     ██▓████████▓░▒▓██░▒ ░██▓▓▓██ ░▓░ ██▓▓▓██ ▒░  ██▓▓▓██▀ ▓█
echo    ██▓▓▓▓▓▓▓▓▓▓▓░░▒▓██▓░ ░██▓██░ ▒▓▒ ░██▓██ ░▓▒   ██▓██ ░▀▀
echo   ███▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓██▒░ ░███░ ░▓▀▓░  ███  ░▓░▓▒  ███  ▒
echo   ▒▀████████████████████▒   █   ▓▀ ▀░   █   ▒▀ ▀▓▒  █  ░▒
echo   ▓░▒                  ▒▀▓  ▒  ▓▀   ▀▓  ▒  ▓▀   ▀▓░ ▒ ░▓▀
echo   █░▓▓▒▒░░        ░░░▒▒▓ ▀▓░▓░▓▀     ▀▓░▓░▓▀     ▀▓▒▓░▓▀JMF...
echo    █▓▓▓▓▒▒▒░░  ░░░▒▒▓▓▓▓  ▀▓▓▓▀       ▀▓▓▓▀       ▀▓▓▓▀
echo     ▀▀▀▀▀▀▀▀    ▀▀▀▀▀▀▀▀   ▀█▀         ▀█▀         ▀█▀
echo.
goto :eof
:instruction
echo.
echo  Key bindings:
echo  ┌────────┬────────────────────┐
echo  │"Q",ESC │ Quit              │
echo  │"F"     │ Toggle full-screen│
echo  │"P",SPC │ Pause             │
echo  └────────┴────────────────────┘
echo.