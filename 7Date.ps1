$date = (Get-Date).addDays(-2555)
$7date = ‘{0:yyyyMMdd}’ -f [DateTime]$date
echo $7date