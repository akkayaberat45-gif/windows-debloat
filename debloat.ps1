# Windows Debloat - gereksiz uygulamalari kaldirir
# Varsayilan: sadece LISTELER, hicbir sey silmez.
# Silmek icin:  .\debloat.ps1 -Apply
# Yonetici PowerShell'de calistir.

param([switch]$Apply)

$apps = @(
    'Microsoft.BingNews',
    'Microsoft.BingWeather',
    'Microsoft.BingSearch',
    'Microsoft.GetHelp',
    'Microsoft.Getstarted',
    'Microsoft.MicrosoftOfficeHub',
    'Microsoft.MicrosoftSolitaireCollection',
    'Microsoft.MixedReality.Portal',
    'Microsoft.Microsoft3DViewer',
    'Microsoft.MSPaint',            # Paint 3D (eski), klasik Paint etkilenmez
    'Microsoft.People',
    'Microsoft.SkypeApp',
    'Microsoft.WindowsFeedbackHub',
    'Microsoft.WindowsMaps',
    'Microsoft.YourPhone',
    'Microsoft.ZuneMusic',
    'Microsoft.ZuneVideo',
    'Microsoft.Todos',
    'Microsoft.PowerAutomateDesktop',
    'Microsoft.549981C3F5F10',      # Cortana
    'Clipchamp.Clipchamp',
    'MicrosoftTeams',
    'MSTeams',
    'Microsoft.XboxApp',
    'Microsoft.XboxGamingOverlay',
    'Microsoft.XboxGameOverlay',
    'Microsoft.XboxIdentityProvider',
    'Microsoft.XboxSpeechToTextOverlay',
    'Microsoft.Xbox.TCUI',
    'king.com.CandyCrushSaga',
    'king.com.CandyCrushSodaSaga'
)

foreach ($a in $apps) {
    $pkgs = Get-AppxPackage -Name $a -ErrorAction SilentlyContinue
    if (-not $pkgs) { continue }
    foreach ($p in $pkgs) {
        if ($Apply) {
            Write-Host "Kaldiriliyor: $($p.Name)" -ForegroundColor Yellow
            Remove-AppxPackage -Package $p.PackageFullName -ErrorAction SilentlyContinue
        } else {
            Write-Host "Bulundu (silinmedi): $($p.Name)" -ForegroundColor Cyan
        }
    }
}

if (-not $Apply) {
    Write-Host "`nHicbir sey silinmedi. Silmek icin: .\debloat.ps1 -Apply" -ForegroundColor Green
} else {
    Write-Host "`nBitti. Bilgisayari yeniden baslat." -ForegroundColor Green
}
