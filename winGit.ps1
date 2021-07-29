$gitDownload = "https://github.com/git-for-windows/git/releases/download/v2.32.0.windows.2/Git-2.32.0.2-64-bit.exe"
$user = "elabs"

# Installing git
curl $gitDownload -o gitInstaller.exe
./gitInstaller.exe

# checkout to windows
cd ~
git clone https://github.com/$user/dots
cd dots
git checkout windows

