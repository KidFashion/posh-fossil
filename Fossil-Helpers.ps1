# Inspired by Mark Embling
# http://www.markembling.info/view/my-ideal-powershell-prompt-with-git-integration

function isCurrentDirectoryFossilRepository {
    if ((test-path "_FOSSIL_") -eq $TRUE) {
	return $TRUE
    }

    $checkIn = (Get-Item .).parent
    while ($checkIn -ne $NULL) {
	$pathToTest = $checkIn.fullname + "/_FOSSIL_"
	if ((Test-path $pathToTest) -eq $TRUE) {
	    return $TRUE
	} else {
	    $checkIn = $checkIn.parent
	}
    }

    return $FALSE
}

function fossilBranchName {
    $currentBranch = ''
    fossil branch | foreach {
        if ($_ -match "^\* (.*)") {
            $currentBranch += $matches[1]
        }
    }
    return $currentBranch
}

function fossilStatus {
$added = 0
$untracked = $FALSE
$modified = 0
$deleted = 0
$ahead = $FALSE
$aheadCount = 0
    $branch = fossilBranchName
$output = fossil status
    $output | % {
	if ($_ -match "DELETED") {
            $deleted += 1
	}
	elseif (($_ -match "EDITED") -or ($_ -match "RENAMED")) {
            $modified += 1
	}
	elseif ($_ -match "ADDED") {
            $added += 1
	}
	elseif ($_ -match "Untracked files:") {
            $untracked = $TRUE
        }
    }

    return @{
	"ADDED" = $added
	"EDITED" = $modified
	"DELETED" = $deleted
	"BRANCH" = $branch
    }

}
