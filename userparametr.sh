UserParameter=exchange.queue[*],powershell.exe -command "Get-Queue | Where-Object { $_.DeliveryType -eq 'ShadowRedundancy' } | ForEach-Object { $_.MessageCount }"
