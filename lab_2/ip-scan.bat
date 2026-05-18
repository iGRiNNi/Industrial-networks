@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion

set /p subnet=Введите первые три октета подсети, например 192.168.1: 

echo.
echo Пингую сеть %subnet%.1 - %subnet%.254
echo.

for /L %%i in (1,1,254) do (
    set "ip=%subnet%.%%i"

    ping -n 1 -w 500 !ip! | find "TTL=" > nul

    if not errorlevel 1 (
        echo.
        echo Найдено устройство: !ip!
        echo Попытка определить имя:
        nbtstat -A !ip! | find "<00>"
    )
)

echo.
echo Проверка завершена.
pause