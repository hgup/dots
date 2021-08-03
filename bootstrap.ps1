# well-known SID for admin group
if ('S-1-5-32-544' -notin [System.Security.Principal.WindowsIdentity]::GetCurrent().Groups) {
    throw 'Script must run as admin!'
}

# Installing Scoop
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
iwr -useb get.scoop.sh | iex
Set-ExecutionPolicy Restricted -scope CurrentUser

# Add extras to Scoop
scoop bucket add extras

# Install favourite apps
$apps = Get-Content .\apps\apps.txt -Raw 
scoop install $apps

# Install fonts
./fonts.ps1

# Run Update Automatically
./update.ps1

# for NVIM
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |` ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

