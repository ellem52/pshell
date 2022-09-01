<#.Notes

This is the fifth and final script in a series of five (7Y Project 2018)

This script is designed to automatically search through REMCo directories for _7Y_.zip files and to delete them

This is irreversable without a server restore. Be careful!

#>

$FileSystem = (Get-PSDrive -psprovider filesystem | where-object {[char[]]"C","D" -notcontains $_.name} | Select-object root).root
#FileSystem gets all accessible "drives"; excludes C:\ and D:\

$Confirmation = Read-Host "Are you SURE you want to proceed with this operation? All files named _7Y_.zip in every
REMCo directory will be permanently deleted. Enter 'Raymond Batista is a nub' to continue"

if ($Confirmation -eq "Raymond Batista is a nub") {

    Get-ChildItem $FileSystem -recurse | Where-Object {$_.Name -match "_7Y_.zip"} | Remove-Item -force
}

Else{
    Read-Host "Action Aborted!"
}