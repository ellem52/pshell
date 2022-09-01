<#.Notes

This is the second script in a series of five (7Y Project 2018)

This script is designed to to search a given drive/directory for files older than 2555 days (7 years) and prepend them with _7Y_

It requires a confirmation that should be removed, if running autonomously. 

Nothing will be outputted by this script. It cannot be reversed once run without the use of another script, program, or manual renaming of files.

Be careful!

#>

[cmdletBinding()]
Param( 
    [Parameter(Mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType 'any'})]  
    [string] $InputDirectory 
    )
#this sets the filepath parameter to mandatory, so you will need to input your own filepath!

$time = (get-date).adddays(-2555)
#$time gets Todays date, minus 2555 days (~7 years)

$Confirmation = read-host "Are you SURE you want to proceed with this operation? All files in the given directory           
be prepended with _7Y_! This action is not easily reversable. Your selected directory is $InputDirectory. 
Enter yes to proceed"     

$Confirmation = "Yes"

If ($Confirmation -eq "Yes") {                                                                                   #Require a mandatory confirmation... Remove if automated.

        $directoryInfo = Get-ChildItem $InputDirectory -recurse -Exclude "_7Y_*",*.Dll,*.exe,*.QB | measure-object
        $fileNo = Get-ChildItem $InputDirectory -recurse | Where-Object {$_.LastWriteTime -lt $time} | measure-object
        #These are used as the conditions for the if statements
        #directoryInfo gets the number of files in the directory; fileNo gets the number of "old" files in the directory

    If ($directoryinfo.count -gt 0 -and $fileno.count -ge 1){        #check: Files in directory and Files older than 7 years in the directory
        Get-ChildItem $InputDirectory -recurse -Exclude "_7Y_*",*.Dll,*.exe,*.QB | #Get all items that are not exe, dll, or qb files -- simply add or remove extensions with commas
            Where-Object {$_.LastWriteTime -le $time} | #refine the "get" to only include items older than $time
        rename-item -NewName {"_7Y_"+ $_.Name} #This is the part that prepends those files with _7Y_
    }
    Elseif ($directoryInfo.count -gt 0 -and $fileno.count -eq 0){    #check: Files in the directory, but none older than  years.
        Read-Host "There are no files older than 7 years in this directory. Press enter to exit. -- $InputDirectory " 
    }
    Elseif ($directoryInfo.count -eq 0){                             #check: No files in the directory.
        Read-Host "There are no files in this directory! Press enter to exit. -- $InputDirectory"
    }
}

else{
    "Action aborted!"
}