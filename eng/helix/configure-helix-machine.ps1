# This file prepares the helix machine for our tests runs
$dotnetLocation=Join-Path (Split-Path -Parent $script:MyInvocation.MyCommand.Path) "dotnet"
$env:DOTNET_ROOT=$dotnetLocation
Set-Variable -Name "DOTNET_ROOT(x86)" -Value $dotnetLocation