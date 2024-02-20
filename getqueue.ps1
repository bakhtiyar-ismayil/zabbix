Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn
Get-Queue | Where-Object { $_.DeliveryType -eq 'SmtpDeliveryToMailbox' } | ForEach-Object { $_.MessageCount }
