spicetify spotify-updates block --bypass-admin
spicetify
spicetify backup
spicetify upgrade
spicetify restore backup apply

Write-Host "Press any key to continue..."
$Host.UI.RawUI.FlushInputBuffer()   # Make sure buffered input doesn't "press a key" and skip the ReadKey().
$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
