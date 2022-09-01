<#.Notes

This is the fourth script in a series of five (7Y Project 2018)

This script is designed to to search a given drive/directory for archive folders ~\_7Y_ and to compress them into their parent

It requires a confirmation that should be removed, if running autonomously.

Nothing will be outputted by this script. It cannot be reversed once run without the use of another script, program, or manual moving of files.

Be careful!

#>

[CmdletBinding()]
Param(
    [Parameter(mandatory=$true)]
    [ValidateScript({Test-Path $_ -PathType 'any'})]
    [string] $InputFilePath
)
#this sets the filepath parameter to mandatory, so you will need to input your own filepath!

$Confirmation = Read-Host "Are you SURE you want to proceed with this operation? All files in the given directory           
be moved to new directories! This action is not easily reversible. Your selected directory is $InputFilePath. 
Enter 'Yes' to proceed"

if ($Confirmation -eq "Yes") {

    Push-Location $InputFilePath
    $Prefix = '_7Y_'
    
    Get-ChildItem -directory -Filter "$Prefix*" -Recurse |
        Compress-Archive -destination $InputFilePath\"_7Y_.zip" -force -compressionlevel optimal

    Get-ChildItem $InputDirectory -exclude *.zip -recurse | Where-Object {$_.Name -like "_7Y_"} |
        Remove-Item -recurse -force
}

else{
    Read-Host "Action aborted!"
}