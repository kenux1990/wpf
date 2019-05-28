@echo off

REM We set these variables here because they can't be strings
REM and this is the easiest way of getting the correct path
REM without turning it into a string through powershell
set DOTNET_ROOT(x86)=%HELIX_CORRELATION_PAYLOAD%\dotnet
set DOTNET_ROOT=%HELIX_CORRELATION_PAYLOAD%\dotnet

powershell -ExecutionPolicy ByPass -NoProfile -command "& """%~dp0runtests.ps1"""  %*"