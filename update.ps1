# well-known SID for admin group
if ('S-1-5-32-544' -notin [System.Security.Principal.WindowsIdentity]::GetCurrent().Groups) {
    throw 'Script must run as admin!'
}

# CONFIG PATHS
# terminal emulator and nvim
$terminalConfig = "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\"
$nvimConfig = "$env:LocalAppData\nvim\"
# gitbash
$git = cmd /c where git
$gitLoc = $git[1][0..($git[1].Length-13)] -join ''
$gitBashProfile = "$gitLoc\etc\profile.d"

# DELETE EXISTING
rm "$nvimConfig\init.vim"
rm "$terminalConfig\settings.json"
rm "$gitBashProfile\bash_profile.sh"
rm "$gitBashProfile\git-prompt.sh"

# APP SPECIFIC SETTINGS (creating links):
new-item -itemtype symboliclink -path $nvimConfig -name init.vim -value .\init.vim
new-item -itemtype symboliclink -path $terminalConfig -name settings.json -value .\windowsTerminalsettings.json
new-item -itemtype symboliclink -path $gitBashProfile -name bash_profile.sh -value .\apps\bash_profile.sh
new-item -itemtype symboliclink -path $gitBashProfile -name git-prompt.sh -value .\apps\git-prompt.sh

