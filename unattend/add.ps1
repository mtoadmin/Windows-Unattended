# Initialize $domain variable
$domain = "No domain"

Set-PSDebug -Trace 1

$domain1 = "toussaint.ca"
$ou1 = "OU=Postes,DC=toussaint,DC=ca"

$domain2 = "capimmobilier.ca"
$ou2 = "OU=Postes,DC=capimmobilier,DC=ca"

$domain3 = "capgestion.ca"
$ou3 = "OU=Postes,DC=capgestion,DC=ca"

#$domain="capimmobilier.ca"

$domain=$env:ClientAtomstar

$username = "AddToDomain"
$password = ConvertTo-SecureString "Zorglup-732!" -AsPlainText -Force

$MaxAttempts = 10
$Attempt = 0
$Success = $false

Write-Host "Compare to: *$domain1*"

if ($domain -eq $domain1) {
    $ou = $ou1
} elseif ($domain -eq $domain2) {
    $ou = $ou2
} elseif ($domain -eq $domain3) {
    $ou = $ou3

} else {
    $ou = $null  # Define default value if $domain is not equal to any domain
}

$ou

$credential = New-Object System.Management.Automation.PSCredential($username, $password)

while ($Attempt -lt $MaxAttempts -and -not $Success) {
    try {
        # Increment attempt counter
        $Attempt++
        Write-Host "Attempt $Attempt of $MaxAttempts"

        # Attempt to add the computer to the domain
        Add-Computer -DomainName $domain -OUPath $ou -Credential $credential -Force -ErrorAction Stop
        Write-Host "The computer has been successfully added to the domain '$DomainName'."
        $Success = $true
    }
    catch {
        # If an error occurs, display the attempt number and the error
        Write-Host "Attempt $Attempt failed: $($_.Exception.Message)"
        
        # If this was not the last attempt, pause for 30 seconds before retrying
        if ($Attempt -lt $MaxAttempts) {
            Write-Host "Waiting for 3 seconds before next attempt..."
            Start-Sleep -Seconds 3
        }
    }
}

if (-not $Success) {
    Write-Host "Failed to add the computer to the domain after $MaxAttempts attempts."
}



Start-Sleep -Seconds 15

Restart-Computer





