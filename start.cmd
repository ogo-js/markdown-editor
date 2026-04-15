@echo off
setlocal
set "APP_URL=file:///%~dp0index.html"

set "EDGE1=%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe"
set "EDGE2=%ProgramFiles%\Microsoft\Edge\Application\msedge.exe"
set "CHROME1=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set "CHROME2=%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe"
set "CHROME3=%LocalAppData%\Google\Chrome\Application\chrome.exe"

if exist "%EDGE1%"   goto :edge1
if exist "%EDGE2%"   goto :edge2
if exist "%CHROME1%" goto :chrome1
if exist "%CHROME2%" goto :chrome2
if exist "%CHROME3%" goto :chrome3
goto :notfound

:edge1
start "" "%EDGE1%" --app="%APP_URL%"
goto :eof
:edge2
start "" "%EDGE2%" --app="%APP_URL%"
goto :eof
:chrome1
start "" "%CHROME1%" --app="%APP_URL%"
goto :eof
:chrome2
start "" "%CHROME2%" --app="%APP_URL%"
goto :eof
:chrome3
start "" "%CHROME3%" --app="%APP_URL%"
goto :eof

:notfound
echo Edge or Chrome was not found. Please open index.html manually in a browser.
pause
