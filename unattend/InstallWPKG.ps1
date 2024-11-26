# Define the variable $domain with three different values
$domain1 = "toussaint.ca"
$domain2 = "immovex.local"
$domain3 = "capgestion.ca"
$domain4 = "capimmobilier.ca"

# Initialize the $parameters variable
$parameters = $null

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

    # Check if any DNS suffix matches with the predefined domains and set $parameters accordingly
    foreach ($suffix in $dnsSuffixes) {
        if ($suffix -eq $domain1) {
            $parameters = "/S /WpkgCommand \\toussaint.ca\dfs\wpkg\wpkg.js"
            break
        }
        elseif ($suffix -eq $domain2) {
            $parameters = "parameters_for_domain2"
            break
        }
        elseif ($suffix -eq $domain3) {
            $parameters = "parameters_for_domain3"
            break
        }
        elseif ($suffix -eq $domain4) {
            $parameters = "parameters_for_domain4"
            break
        }
    }

    # If none of the DNS suffixes match with the predefined domains, set $parameters to indicate an unknown domain
    if (-not $parameters) {
        Write-Host "Unknown domain"
    }
} else {
    Write-Host "No DNS suffixes assigned by DHCP found."
}

# Output the value of $parameters
$parameters

$executablePath = "C:\windows\Wpkg-GP-0.18b1_x64.exe"

Start-Process -FilePath $executablePath -ArgumentList $parameters




