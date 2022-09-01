<#.Notes

This script is the second in a series of 2 (J_Data 2018)

It serves to search a production directory, and a restore directory for inconsistencies.

It outputs to a .csv which will clobber if run multiple times. To avoid this, add -noclobber and -append to the export-csv cmdlet

#>

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType 'any'})]
    [string] $ProductionDir,
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType 'any'})]
    [string] $RestoreDir
)

$PD = Get-ChildItem $ProductionDir -recurse -file
$RD = Get-ChildItem $RestoreDir -Recurse -file

Compare-Object $PD -DifferenceObject $RD -property directory,name,lastwritetime |
        Export-CSV ~\desktop\"J_dataDifferences.csv" -notypeinformation