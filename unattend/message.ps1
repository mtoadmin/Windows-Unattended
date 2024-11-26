Add-Type -AssemblyName PresentationCore, PresentationFramework

$MessageboxTitle = "Titre du message contextuel de test"
$MessageboxBody = "Êtes-vous sûr de vouloir arrêter l'exécution de ce script ?"
$MessageIcon = [System.Windows.MessageBoxImage]::Warning
$ButtonType = [System.Windows.MessageBoxButton]::YesNo

# Affiche la boîte de dialogue et stocke le résultat dans une variable
$dialogResult = [System.Windows.MessageBox]::Show($MessageboxBody, $MessageboxTitle, $ButtonType, $MessageIcon)

# Vérifie la valeur de retour
if ($dialogResult -eq [System.Windows.MessageBoxResult]::Yes) {
    Write-Host "L'utilisateur a cliqué sur Oui."
} else {
    Write-Host "L'utilisateur a cliqué sur Non."
}
