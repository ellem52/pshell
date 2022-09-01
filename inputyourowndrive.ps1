<#.Notes

This is the first script in a series of five (7Y Project 2018)

This script is designed to to search a given drive/directory for files older than 2555 days (7 years).

It outputs any such files into a .csv file, and lists the directory name, the name of the file, the "last touch" and the "creation date."

If there are no files older than 7 years inside the directory, the file will read accordingly. 

By default, the results from each directory will be appended to the end of a single .csv file, and it will not overwrite the file, so duplicate 
entries may exist if the script is run more than once for the same directory.

#>

[cmdletBinding()]
Param
( 
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType 'any'})]  
    [string] $InputDirectory,
    [Parameter(Mandatory=$true)]
    [string] $OutputFileName 
)
#this sets the filepath parameter to mandatory, so you will need to input your own filepath!

$time = (get-date).adddays(-2555)
#time gets todays date, minus 2555 days (7 years)

$directoryInfo = Get-ChildItem $InputDirectory -recurse -exclude *.Dll,*.exe,*.QB | measure-object
$fileNo = Get-ChildItem $InputDirectory -recurse | Where-Object {$_.LastWriteTime -lt $time} | measure-object
# These are used as the conditions for the if statements
# directoryInfo gets the number of files in the directory; fileNo gets the number of files older than 7 years in the directory

If ($directoryinfo.count -gt 0 -and $fileno.count -ge 1){
    Get-ChildItem $InputDirectory -recurse -exclude *.Dll,*.exe,*.QB  |
        Where-Object {$_.LastWriteTime -le $time} |
            Select-Object -property directory,name, @{n="Last Touched"; E={$_.LastWriteTime.toString("MM/dd/yyyy")}}, 
            @{n="Created"; E={$_.CreationTime.toString("MM/dd/yyyy")}} |
    Export-CSV ~\desktop\"$OutputFileName.csv" -noclobber -append -notypeinformation  
}

Elseif ($directoryInfo.count -gt 0 -and $fileno.count -eq 0){
    Read-Host "There are no files older than 7 years in this directory. Press enter to exit. -- $InputDirectory " 
}

Elseif ($directoryInfo.count -eq 0){
    Read-Host "There are no files in this directory! Press enter to exit. -- $InputDirectory"
}