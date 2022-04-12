
#oh-my-posh prompt init pwsh --config "C:\Users\dadro\Documents\oh-my-posh\themes\amro.omp.json" | Invoke-Expression

Import-Module mymodule

function pro { vim $profile }

function Set-vcvars { Invoke-BatchFile "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" }
function ecmake { cmake.exe -DCMAKE_EXPORT_COMPILE_COMMANDS=1 @Args }

## Настройка клавиш
##=--------
Import-Module PSReadLine
## поиск в истории по нажатию стрелок
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
## bash like complete
Set-PSReadLineKeyHandler -Key Tab -Function Complete

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView



function prompt1 {

    #Assign Windows Title Text
    $host.ui.RawUI.WindowTitle = "$pwd"

    #Configure current user, current folder and date outputs
    $CmdPromptCurrentFolder = Split-Path -Path $pwd -Leaf
    $CmdPromptUser = [Security.Principal.WindowsIdentity]::GetCurrent();
    $Date = Get-Date -Format 'dddd hh:mm:ss tt'

    # Test for Admin / Elevated
    $IsAdmin = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

    #Calculate execution time of last cmd and convert to milliseconds, seconds or minutes
    $LastCommand = Get-History -Count 1
    if ($lastCommand) { $RunTime = ($lastCommand.EndExecutionTime - $lastCommand.StartExecutionTime).TotalSeconds }

    if ($RunTime -ge 60) {
        $ts = [timespan]::fromseconds($RunTime)
        $min, $sec = ($ts.ToString("mm\:ss")).Split(":")
        $ElapsedTime = -join ($min, " min ", $sec, " sec")
    }
    else {
        $ElapsedTime = [math]::Round(($RunTime), 2)
        $ElapsedTime = -join (($ElapsedTime.ToString()), " sec")
    }


    #Decorate the CMD Prompt
    Write-Host ""
    # Git branch
    Write-BranchName
    Write-host ($(if ($IsAdmin) { "[ADMIN]" } else { '' })) -BackgroundColor DarkRed -ForegroundColor White -NoNewline
    Write-Host "$($CmdPromptUser.Name.split("\")[1]) " -ForegroundColor White -NoNewline
    If ($CmdPromptCurrentFolder -like "*:*")
        {Write-Host " $CmdPromptCurrentFolder "  -ForegroundColor White -NoNewline}
        else {Write-Host ".\$CmdPromptCurrentFolder\ "  -ForegroundColor White -NoNewline}

    Write-Host " $date " -ForegroundColor White
    Write-Host "[$elapsedTime] " -NoNewline -ForegroundColor Green
    return "> "
} #end prompt function


function prompt {
    #Assign Windows Title Text
    $host.ui.RawUI.WindowTitle = "$pwd"

    $IsAdmin = (New-Object Security.Principal.WindowsPrincipal ([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    $base = $Env:USERNAME
    $path = "$($executionContext.SessionState.Path.CurrentLocation)"
    $userPrompt = "$('>' * ($nestedPromptLevel + 1)) "

    Write-Host "`n$base " -NoNewline -ForegroundColor "Magenta"
    #Write-Host "`n$base " -NoNewline -ForegroundColor "Cyan"

    Write-Host $path -NoNewline -ForegroundColor "green"
    Write-BranchName -NoNewLine
    Write-Host ''

    return $userPrompt
}
