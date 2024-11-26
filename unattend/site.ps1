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
    
    foreach ($suffix in $dnsSuffixes) {
        if (-not [string]::IsNullOrWhiteSpace($suffix)) {
            $domain = $suffix
            Write-Host "Setting variable domain to: *$domain*"
            break
        }
    }
} else {
    Write-Host "No DNS suffixes assigned by DHCP found."
    [System.Environment]::SetEnvironmentVariable('ResourceGroup','ClientAtomstar', 'none')

}

[System.Environment]::SetEnvironmentVariable('ClientAtomstar', $domain, 'Machine')


