# Load the Visual Studio Module and prep the environment
Import-Module "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
Enter-VsDevShell -VsInstallPath "C:\Program Files\Microsoft Visual Studio\2022\Community" #\3be3d950"

# Ensure (strawberry) perl is installed
# Ensure visual studio (C/C++) is installed

# Modify the config file because it seems like the command line arguments are not working (but we add them anyway for good measure)
$configureText = Get-Content -Path ".\Configure" -Raw

$fixedText = $configureText -replace '( +"(ssl3.*?|weak-ssl-ciphers)"\s+=> "default",)', '# $1'

$fixedText | Set-Content -Path ".\Configure"

perl Configure enable-weak-ssl-ciphers enable-ssl3-method enable-ssl3 -static VC-WIN64A

nmake

nmake test

