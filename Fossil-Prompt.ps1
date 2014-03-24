. ./Fossil-Helpers.ps1

function prompt {
    write-host ("["+(get-date).ToString("HH:mm:ss")+"] "+(pwd)) -nonewline -foregroundColor Yellow
    if(isCurrentDirectoryFossilRepository)
    {
	$status = fossilStatus
	$currentBranch = $status["BRANCH"]

	Write-Host(' [') -nonewline -foregroundcolor Yellow
	Write-Host($currentBranch) -nonewline -foregroundcolor Cyan
	Write-Host(' +' + $status["ADDED"]) -nonewline -foregroundcolor Yellow
        Write-Host(' ~' + $status["EDITED"]) -nonewline -foregroundcolor Yellow
        Write-Host(' -' + $status["DELETED"]) -nonewline -foregroundcolor Yellow
	Write-Host(']') -nonewline -foregroundcolor Yellow   
    }
    Write-Host('>') -nonewline -foregroundcolor Yellow   
    return " "
}