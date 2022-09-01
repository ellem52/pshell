<#.Notes

This is the third script in a series of five (7Y Project 2018)

This script is designed to to search a given drive/directory for files prepended with _7Y_ and to move them.

It requires a confirmation that should be removed, if running autonomously.

The files will be moved from their directory, to a new sub-directory with _7Y_ in its name.

Nothing will be outputted by this script. It cannot be reversed once run without the use of another script, program, or manual renaming of files.

Be careful!

#>

[CmdletBinding()]
Param(
    [Parameter(mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType 'any'})]
    [string] $InputFilePath
)
#this sets the filepath parameter to mandatory, so you will need to input your own filepath!

$directoryInfo = Get-ChildItem $InputFilePath -recurse | Measure-Object 
$7Yno = Get-ChildItem $InputFilePath -recurse | Where-Object {$_.Name -like '_7Y_*.*'} | Measure-Object
#These are used as the conditions for the if statements
#directoryInfo gets the number of files in the directory; 7Yno gets the number of files prepended with _7Y_ in the directory

$Confirmation = Read-Host "Are you SURE you want to proceed with this operation? All files in the given directory           
be moved to new directories! This action is not easily reversible. Your selected directory is $InputFilePath. 
Enter 'Yes' to proceed"

if ($Confirmation -eq "Yes") {

    if ($directoryInfo.count -gt 0 -and $7Yno.count -gt 0){   #Check: Files in directory and files prepended with _7Y_ in directory.
    
    Push-Location $InputFilePath
    $Prefix = '_7Y_'
    
    Get-ChildItem -File -Filter "$Prefix*" -Recurse |         
        Where-Object {$_.Directory.Name -ne $Prefix} |
            ForEach-Object {
                $DirPrefix = "$($_.Directory)\$Prefix"
                If (!(Test-Path $DirPrefix)){
                mkdir $DirPrefix | Out-Null
                }
        $_ | Move-Item -Destination $DirPrefix
        }

    }

    if ($directoryInfo.count -gt 0 -and $7Yno.count -eq 0){   #Check: Files in directory, but no files prepended with _7Y_ in directory.
        Read-Host "There are no files prepended with _7Y_ in this directory!"
    }
    
    if ($directoryInfo.count -eq 0){                            #Check: No files in directory.
        Read-Host "There are no files in this directory!"
    }
}