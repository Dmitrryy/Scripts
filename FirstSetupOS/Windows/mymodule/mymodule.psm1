
function Invoke-BatchFile
{
   param([string]$Path, [string]$Parameters)

   $tempFile = [IO.Path]::GetTempFileName()

   ## Store the output of cmd.exe.  We also ask cmd.exe to output
   ## the environment table after the batch file completes
   cmd.exe /c " `"$Path`" $Parameters && set > `"$tempFile`" "

   ## Go through the environment variables in the temp file.
   ## For each of them, set the variable in our local environment.
   Get-Content $tempFile | Foreach-Object {
       if ($_ -match "^(.*?)=(.*)$")
       {
            Set-Content "env:\$($matches[1])" $matches[2]
       }
   }

   Remove-Item $tempFile
}


function Write-BranchName () {
    param(
        [string]$BranchColour = "Yellow",
        [string]$HeadColour = "red"
    )
    $branch = ""
    $branch += git rev-parse --abbrev-ref HEAD

    if ($branch -eq "") {
    }
    elseif ($branch -eq "HEAD") {
        # we're probably in detached HEAD state, so print the SHA
        $branch = git rev-parse --short HEAD
        Write-Host " ($branch)" -ForegroundColor $HeadColour @Args
    }
    else {
        # we're on an actual branch, so print it
        Write-Host " ($branch)" -ForegroundColor $BranchColour @Args
    }
}

Export-ModuleMember -Function *

