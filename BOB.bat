@echo off
title -= bitnIfe =-

:restart
echo       [38;5;226m___                                             
echo      _,H,_                                 
echo   _   ([31m#[38;5;226m)_         ___  __     
echo  ^| ^|__^|[31m#[38;5;226m^| ^|_  _ _ ^|_ _^|/ _^|___     {[38;5;245mv1.70 stable[38;5;226m}
echo  ^| '_ \[31m#[38;5;226m^|  _^|^| ' \ ^| ^|^|  _/ -_^|    [38;5;75mHacking tool[38;5;226m
echo  ^|_.__/[31m#[38;5;226m^|_^|  ^|_^|^|_^|___^|_^| \___^|
echo        V_... .  .[0m
echo.
echo [38;5;120m  - Warning: some of our commands are are illegal to use
echo     without the target's permission
echo.
echo   - Type "help" to see all commands.[0m
echo.
:menu
cd C:\"My stuff"\Code\Files
set /p input="bit-nIfe/> "

if "%input%"=="help" (
    echo - help
    echo - color rules
    echo - cls
    echo - wifi
    echo    -all
    echo    -current
    echo - hostip
    echo - state
    echo - listen
    echo - restart
    echo - netconn
    echo - task
    echo - ps
    echo - sysinfo
    echo - OS
    echo - myip
    echo    -public

    echo [94m- port
    echo - shodan
    echo - vbox
    echo - putty
    echo - rcd
    echo - shutdown
    echo - angry ip
    echo - wireshark[38;5;226m

    echo - trace
    echo - wifipass
    echo - neighbors
    echo - sqlinj[0m

    echo [31m- scan
    echo    -wifi
    echo    -port
    echo - geo
    echo - vulnerabilities
    echo - vulnerable ips[0m
    goto menu
)
if "%input%"=="cls" (
    cls
    goto menu
) 
if /i "%input%"=="color rules" (
    echo white - these commands are safe to use
    echo [94mblue - these commands are for other applications - some are restricted
    echo [38;5;226myellow - you need to be careful with these commands
    echo [31mred - you need to be REALLY careful with these commands - only alowed for admins[0m
)
if "%input%"=="shutdown" (
    shutdown -i
)
if "%input%"=="wifi -current" (
    call :wifi
)
if "%input:~0,9%"=="wifipass " (
    set network=%input:~9%
    call :swifi
) 
if "%input%"=="putty" (
    start putty.exe
)
if "%input%"=="vbox" (
    start vbox
)
if "%input%"=="angry ip" (
    start angry_ip
)
if "%input%"=="rcd" mstsc
if /i "%input:~0,3%"=="ip " (
    set IP=%input:~3%
    call :ip
) 
if /i "%input:~0,5%"=="port " (
    set por=%input:~5%
    call :port
) 
if /i "%input:~0,11%"=="scan -wifi " (
    powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Are you sure you want to scan for ips on wifi', 'Double check', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
    set ip=%input:~11%
    call :scanw
)
if /i "%input:~0,11%"=="scan -port " (
    powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Are you sure you want to scan for opened ports', 'Double check', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
    set pip=%input:~11%
    call :pscan
)
if /i "%input%"=="myip" (
    call :smyip
)
if /i "%input:~0,4%"=="geo " (
    set geoip=%input:~4%
    call :geo
)
if /i "%input:~0,6%"=="trace " (
    set traceip=%input:~6%
    call :trace
)
if /i "%input:~0,7%"=="hostip " (
    set host=%input:~7%
    call :hostip
)
if /i "%input%"=="wifi -all" (
    call :awifi
)
if /i "%input%"=="myip -public" (
    curl https://api.ipify.org
    echo.
)
if /i "%input:~0,6%"=="state " (
    set stateip=%input:~6%
    call :state
)
if /i "%input%"=="listen" (
    netstat -an | find "LISTEN"
)
if /i "%input%"=="restart" (
    powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Are you sure you want to restart', 'Double check', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
    cls
    goto restart
)
if /i "%input%"=="netconn" (
    netstat -ano
)
if /i "%input%"=="task" (
    start taskmgr
)
if /i "%input%"=="ps" (
    tasklist
)
if /i "%input%"=="sysinfo" (
    systeminfo
)
if /i "%input%"=="OS" (
    for /f "tokens=2 delims=:" %%a in ('systeminfo ^| find "OS Name"') do echo %%a
)
if /i "%input%"=="neighbors" (
    powershell -Command "Get-NetNeighbor"
)
if /i "%input%"=="vulnerable ips" (
    echo [38;5;226mIPs: [0m
    echo - 21
    echo - 22
    echo - 25
    echo - 53
    echo - 80
    echo - 445
    echo - 139
)
if /i "%input:~0,16%"=="vulnerabilities " (
    powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Are you sure you want to scan for vulnerabilities', 'Double check', 'OK', [System.Windows.Forms.MessageBoxIcon]::Information);}"
    set vulip=%input:~16%
    call :vulnerabilities
)
if /i "%input%"=="shodan" (
    start https://shodan.io
)
if /i "%input%"=="wireshark" (
    start wireshark
)
if /i "%input:~0,7%"=="sqlinj " (
    cd C:\"My stuff"\Code\Files\sqlmap
    sqlmap %input:~7%
)
goto menu

:wifi
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "SSID" ^| findstr /v "BSSID" ') do set ssid=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "Description" ') do set descr=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "State" ') do set state=%%a
for /f "tokens=2 delims=:" %%a in ('netsh wlan show interface ^| find "Signal" ') do set signal=%%a
for /f "tokens=4 delims==" %%a in ('ping -n 2 8.8.8.8 ^| find "Average" ') do set ping=%%a
for /f "tokens=2 delims= " %%a in ('netstat -e ^| find "Bytes" ') do set rby=%%a
for /f "tokens=3 delims= " %%a in ('netstat -e ^| find "Bytes" ') do set sby=%%a
echo SSID: %ssid%
echo Adapter: %descr%
echo State: %state%
echo Signal: %signal%
echo Ping: %ping%
echo Recieved Bytes: %rby%
echo Sent Bytes: %sby%
goto menu

:port
start https://google.com/search?q=what+is+port+%por%+used+for
goto menu

:ip
echo IP: %IP%
for /f "tokens=1-3 delims=." %%a in ("%IP%") do set WIFI=%%a.%%b.%%c.1
echo WIFI: %WIFI%
for /f "tokens=1,2 delims=." %%a in ("%IP%") do set first=%%a.%%b
for /f "tokens=1 delims=." %%a in ("%IP%") do set FIRST_OCTET=%%a
if %FIRST_OCTET% GEQ 1 if %FIRST_OCTET% LEQ 126 (
    echo Class: A
) else if %FIRST_OCTET% GEQ 128 if %FIRST_OCTET% LEQ 191 (
    echo Class: B
) else if %FIRST_OCTET% GEQ 192 if %FIRST_OCTET% LEQ 223 (
    echo Class: C
)
ping -n 1 %IP% >nul
if errorlevel 0 (
    powershell -Command "& {Write-Host '%IP%: ' -NoNewline; Write-Host 'online' -ForegroundColor Green}"
) else powershell -Command "& {Write-Host '%IP%: ' -NoNewline; Write-Host 'offline' -ForegroundColor Red}"
goto menu

:pscan
for /f "tokens=1,2 delims=:" %%a in ("%pip%") do (
    set ppip=%%a
    set pport=%%b
)
for /f "tokens=2 delims=:" %%a in ('powershell -Command "Test-NetConnection -ComputerName %ppip% -Port %pport%" ^| find "TcpTestSucceeded"') do set bool=%%a
if "%bool%"==" True" (
    powershell -Command "& {Write-Host 'Port %pport%: ' -NoNewline; Write-Host 'opened' -ForegroundColor Green}"
) else powershell -Command "& {Write-Host 'Port %pport%: ' -NoNewline; Write-Host 'closed' -ForegroundColor Red}"
goto menu

:scanw
cd C:\"Program Files"\"Angry IP Scanner"
for /f "tokens=1-3 delims=." %%a in ("%ip%") do set start=%%a.%%b.%%c.1
for /f "tokens=1-3 delims=." %%a in ("%ip%") do set end=%%a.%%b.%%c.255
ipscan.exe -f:range %start% %end% -s
goto menu

:swifi
netsh wlan show profile name="%network%" key=clear | findstr "Key Content"
goto menu

:smyip
set "cmyip="
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /r /c:"IPv4 Address"') do (
    set "cmyip=%%a"
)
for /f "tokens=* delims= " %%b in ("%cmyip%") do set "cmyip=%%b"
powershell -Command "& {Write-Host '%cmyip%' -ForegroundColor Yellow}"
goto menu

:geo
for /f "tokens=8,12 delims=," %%a in ('curl -s https://api.shodan.io/shodan/host/%geoip%') do (
    set long=%%a
    set lang=%%b
)
for /f "tokens=2 delims=:" %%a in ("%long%") do echo Longitude: %%a
for /f "tokens=2 delims=:" %%a in ("%lang%") do echo Laditude: %%a
goto menu

:trace
powershell -Command "Test-NetConnection -ComputerName %traceip% -Traceroute"
goto menu

:hostip
nslookup %host%
for /f "tokens=1,2,3,4,5,6,7,8,9,10,11,12 delims=," %%a in ('curl -s https://api.shodan.io/shodan/host/%host%') do (
    echo %%a
    echo %%b
    echo %%c
    echo %%d
    echo %%e
    echo %%f
    echo %%g
    echo %%i
    echo %%j,%%k
)
goto menu

:awifi
netsh wlan show profile
goto menu

:state
ping -n 1 %stateip% >nul
if errorlevel 1 (
    powershell -Command "& {Write-Host '%stateip%: ' -NoNewline; Write-Host 'offline' -ForegroundColor Red}"
) else powershell -Command "& {Write-Host '%stateip%: ' -NoNewline; Write-Host 'online' -ForegroundColor Green}"
goto menu

:pscan
for /f "tokens=1,2 delims=:" %%a in ("%pip%") do (
    set ppip=%%a
    set pport=%%b
)
for /f "tokens=2 delims=:" %%a in ('powershell -Command "Test-NetConnection -ComputerName %ppip% -Port %pport%" ^| find "TcpTestSucceeded"') do set bool=%%a
if "%bool%"==" True" (
    powershell -Command "& {Write-Host 'Port %pport%: ' -NoNewline; Write-Host 'opened' -ForegroundColor Green}"
) else powershell -Command "& {Write-Host 'Port %pport%: ' -NoNewline; Write-Host 'closed' -ForegroundColor Red}"
goto 

:vulnerabilities
for /f "tokens=2 delims=:" %%a in ('powershell -Command "Test-NetConnection -ComputerName %vulip% -Port 21" ^| find "TcpTestSucceeded"') do set bool=%%a
if "%bool%"==" True" (
    powershell -Command "& {Write-Host '21 (FTP) opened' -ForegroundColor Green}"
)
for /f "tokens=2 delims=:" %%a in ('powershell -Command "Test-NetConnection -ComputerName %vulip% -Port 22" ^| find "TcpTestSucceeded"') do set bool=%%a
if "%bool%"==" True" (
    powershell -Command "& {Write-Host '22 (SSH) opened' -ForegroundColor Green}"
)
for /f "tokens=2 delims=:" %%a in ('powershell -Command "Test-NetConnection -ComputerName %vulip% -Port 25" ^| find "TcpTestSucceeded"') do set bool=%%a
if "%bool%"==" True" (
    powershell -Command "& {Write-Host '25 (SMTP) opened' -ForegroundColor Green}"
)
for /f "tokens=2 delims=:" %%a in ('powershell -Command "Test-NetConnection -ComputerName %vulip% -Port 53" ^| find "TcpTestSucceeded"') do set bool=%%a
if "%bool%"==" True" (
    powershell -Command "& {Write-Host '53 (DNS) opened' -ForegroundColor Green}"
)
for /f "tokens=2 delims=:" %%a in ('powershell -Command "Test-NetConnection -ComputerName %vulip% -Port 80" ^| find "TcpTestSucceeded"') do set bool=%%a
if "%bool%"==" True" (
    powershell -Command "& {Write-Host '80 (HTTP) opened' -ForegroundColor Green}"
)
for /f "tokens=2 delims=:" %%a in ('powershell -Command "Test-NetConnection -ComputerName %vulip% -Port 445" ^| find "TcpTestSucceeded"') do set bool=%%a
if "%bool%"==" True" (
    powershell -Command "& {Write-Host '445 (SMB) opened' -ForegroundColor Green}"
)
for /f "tokens=2 delims=:" %%a in ('powershell -Command "Test-NetConnection -ComputerName %vulip% -Port 139" ^| find "TcpTestSucceeded"') do set bool=%%a
if "%bool%"==" True" (
    powershell -Command "& {Write-Host '139 (NetBios) opened' -ForegroundColor Green}"
)
:: evil-winrm