# This file prepares the helix machine for our tests runs
$dotnetLocation=Join-Path (Split-Path -Parent $script:MyInvocation.MyCommand.Path) "dotnet"

# Set both DOTNET_ROOT environment variables. This is necessary, even for x64 runs.
$env:DOTNET_ROOT=$dotnetLocation
Set-Variable -Name "DOTNET_ROOT(x86)" -Value $dotnetLocation

$runtimes = dotnet --list-runtimes
foreach ($rt in $runtimes)
{
    if ($rt.StartsWith("Microsoft.WindowsDesktop.App"))
    {
        $version = $rt.Split(" ")[1]
    }
}

# Rewrite the *.runtimeconfig.json files to match the version of the runtime on the machine
$infraLocation = Join-Path (Split-Path -Parent $script:MyInvocation.MyCommand.Path) "Test\Infra"
$stiConfigFile = Join-Path $infraLocation "Sti.runtimeconfig.json"
$qvConfigFile = Join-Path $infraLocation "QualityVaultFrontEnd.runtimeconfig.json"
$configFiles = $stiConfigFile, $qvConfigFile
foreach ($config in $configFiles)
{
    # Read current config file
    $jsondata = Get-Content -Raw -Path $config | ConvertFrom-Json
    # Update version
    $jsondata.runtimeOptions.framework.version = $version
    # Write data back
    $jsondata | ConvertTo-Json -depth 100 | Set-Content $config
}