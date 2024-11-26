# Get network adapter configuration
$adapters = Get-NetAdapter | Where-Object { $_.Status -eq 'Up' }

# Initialize an array to store DNS suffixes
$dnsSuffixes = @()

foreach ($adapter in $adapters) {
    # Get DNS client configuration for the adapter
    $dnsClientConfig = Get-DnsClient -InterfaceIndex $adapter.IfIndex

    # Check if DNS client configuration is available
    if ($dnsClientConfig -ne $null) {
        # Retrieve DNS suffixes from DNS client configuration
        $dnsSuffixes += $dnsClientConfig.ConnectionSpecificSuffix
    }
}

# Output the DNS suffixes
if ($dnsSuffixes.Count -gt 0) {
    Write-Host "DNS Suffixes assigned by DHCP:"
    $dnsSuffixes | ForEach-Object { Write-Host $_ }
    
    # Set $domain variable if there's only one DNS suffix
    if ($dnsSuffixes.Count -eq 1) {
        $domain = $dnsSuffixes[0]
        Write-Host "Setting variable \$domain to: $domain"
    }
} else {
    Write-Host "No DNS suffixes assigned by DHCP found."
}

$username = "AddToDomain"
$password = ConvertTo-SecureString "Zorglup-732!" -AsPlainText -Force

$ou = "OU=Postes,DC=toussaint,DC=ca"

$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Add-Computer -DomainName $domain -OUPath $ou -Credential $credential -Restart
