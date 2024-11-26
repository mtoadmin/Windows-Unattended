# Set-PSDebug -Trace 1

# Define the domain you want to query the CNAME record for
$domainName = "michel.postes.toussaint.ca"

# Specify the DNS zone where you want to add the CNAME record
$zoneName = "postes.toussaint.ca"

# Specify the alias name for the CNAME record (the CNAME you're creating)
$hostNameAlias = $env:username





# Optionally, specify a DNS server. Remove or set to $null to use the system default
$dnsServer = "tDC1.toussaint.ca"

# Perform the DNS query
try {
    $cnameRecord = Resolve-DnsName -Name $domainName -Type CNAME -Server $dnsServer -ErrorAction Stop
    # Display the CNAME record information
    Write-Host "CNAME Record for $domainName"
    Write-Host "Canonical Name: $($cnameRecord.NameHost)"
}
catch {
    Write-Error "An error occurred while querying the DNS record: $_"
}

$targetHostName=  $env:computername + "." + $env:ClientAtomstar
$targetHostName

if ($($cnameRecord.NameHost) -eq $targetHostName) {
    write-host "tiguidou"
} else {
try {
   $reponse = Read-Host "Voulez vous utiliser cet ordinateur pour l'accès à distance (oui/non) ?"

   if ($reponse -eq "oui") {
    		Add-DnsServerResourceRecordCName -Name $hostNameAlias -HostNameAlias $targetHostName -ZoneName $zoneName -ComputerName $dnsServer -ErrorAction Stop
    		Write-Host "Successfully added CNAME record: $hostNameAlias -> $targetHostName"
	} else {
	Write-Host "Aucun changement"
  }
}
catch {
    Write-Error "Failed to add CNAME record: $_"
}




}