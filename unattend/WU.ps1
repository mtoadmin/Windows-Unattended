Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

Install-Module -Name PSWindowsUpdate -Force
Import-Module PSWindowsUpdate


# Check for available updates
$updates = (Get-WindowsUpdate).Count

if ($updates -eq 0) {
    Write-Output "No updates available."
} else {
    Write-Output "Found $updates updates."
    # Install updates
    Install-WindowsUpdate -AcceptAll -IgnoreReboot
}
