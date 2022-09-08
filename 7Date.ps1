<#.7 Year Project Date with formatting for RoboCopy #>
$date = (Get-Date).addDays(-2555)
$7date = ‘{0:yyyyMMdd}’ -f [DateTime]$date
echo $7date
<.# add pause below for stand-alone testing #>
