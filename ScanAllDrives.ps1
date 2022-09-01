<#.Notes

This is and alternate version of the first script in a series of five (7Y Project 2018)

This script is designed to automatically search through REMCo directories (excluding the local C:\ and D:\) for files older than 2555 days (7 years).

It outputs any such files into a .csv file, and lists the directory name, the name of the file, the "last touch" and the "creation date."

If there are no files older than 7 years inside the directory, the file will read accordingly. 

By default, the results from each directory will be appended to the end of a single .csv file, and it will not overwrite the file, so duplicate 
entries may exist if the script is run more than once for the same directory.

#>

$FileSystem = (Get-PSDrive -psprovider filesystem | where-object {[char[]]"C","D" -notcontains $_.name} | Select-object root).root
#FileSystem gets all accessible "drives"; excludes C:\ and D:\

$time = (get-date).adddays(-2555)
#Time gets todays date, minus 2555 days (7 years)

$directoryInfo = Get-ChildItem $FileSystem -exclude *.Dll,*.exe,*.QB | measure-object
$fileno = $directoryinfo | Where-Object {$_.lastwritetime -lt (get-date).adddays(-2555)} | measure-object
<# These are used as the conditions for the if statement
$directoryInfo is the number of files in the directory, where $fileno is the number of files in the directory that are older than 7 years. 
These "parameters" are uselss in this version of the script, because the first if statement should ALWAYS pass for REMCO. #>

If ($directoryinfo.count -gt 0 -and $fileno.count -ge 1){
    Get-ChildItem $FileSystem -recurse -exclude *.Dll,*.exe,*.QB |
        Where-Object {$_.lastwritetime -le $time} |
            Select-Object -property directory,name, @{name="Last Touched"; Expression={$_.LastWriteTime.ToString("MM/dd/yyyy")}}, 
            @{n="Created"; E={$_.creationtime.tostring("MM/dd/yyyy")}} |
    Export-CSV ~\desktop\"OutdatedFiles.csv" -notypeinformation  
}

Elseif ($directoryinfo.count -gt 0 -and $fileno.count -lt 1){
    Read-Host "There are no files older than 7 years in this directory! Press enter to exit. -- $FileSystem"
}

Elseif ($directoryinfo.count -eq 0){
    Read-Host "There are no files in this directory! Press enter to exit. -- $FileSystem "
} 