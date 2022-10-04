@echo off
set URL=%1
set OldAddress=0
set counter=0
:repeat
ipconfig /flushdns >>null
for /F "tokens=3" %%a in ('ping -n 1 %URL% ^| find /i "] with 32"') do set Address=%%a
set Address=%Address:~0,-1%
if %OldAddress%==0 (
	@echo %date% %time% Original IP is %Address%
	set OldAddress=%Address%
) else (
	if %Address% NEQ %OldAddress% (
		echo ================================================
		@echo %date% %time% NEW IP is %Address%
		echo ================================================
		exit
	)
)
set /a counter=%counter%+1
if %counter%==20 (
	@echo %date% %time% Still the same...  %Address%
	set counter=0
)
Goto repeat
