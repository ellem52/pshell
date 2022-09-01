<#.Notes

This script is the first in a series of 2 (J_Data 2018)

It serves to search the production directory recursively for files that have been edited since the restore date (in this case, 6/28)

These files need to be copied to the new restore, as the original restore will not reflect any edits made to those documents.
    - This will be handled manually

It outputs to a .csv which will clobber if run multiple times. To avoid this, add -noclobber and -append to the export-csv cmdlet

#>

[Cmdletbinding()]
Param(
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType 'any'})]
    [string] $ProductionDir
)

$RestoreDate = "06/28/2018"

Get-Childitem $ProductionDir -recurse -file |
    Where-Object {$_.LastWriteTime -gt $RestoreDate} | Select-Object directory,name,@{n="Last Touched"; E={$_.LastWriteTime.toString("MM/dd/yyyy")}} |
        Export-CSV ~\desktop\"6_28LWT.csv" -notypeinformation