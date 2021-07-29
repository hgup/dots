# download the font
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
curl $fontUrl -o firaCode.zip

# install the files$source = 'Montserrat.zip'
$source = 'firaCode.zip'
$fontsFolder = 'apps/fonts'

Expand-Archive -Path $source -DestinationPath $fontsFolder

foreach ($font in Get-ChildItem -Path $fontsFolder -File) {
    $dest = "C:\Windows\Fonts\$font"
    if (Test-Path -Path $dest) {
        "Font $font already installed."
    }
    else {
        $font | Copy-Item -Destination $dest
    }
}


