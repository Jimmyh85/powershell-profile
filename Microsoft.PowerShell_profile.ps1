# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

 
# Prompt
Import-Module Posh-Git

## Posh Git Colors
$GitPromptSettings.DefaultForegroundColor                      = $null

$GitPromptSettings.BeforeText                                  = " $([char]0xE0A0) "
$GitPromptSettings.BeforeForegroundColor                       = [ConsoleColor]::Yellow
$GitPromptSettings.BeforeBackgroundColor                       = [ConsoleColor]::DarkGray

$GitPromptSettings.DelimText                                   = ' |'
$GitPromptSettings.DelimForegroundColor                        = [ConsoleColor]::Yellow
$GitPromptSettings.DelimBackgroundColor                        = $null

$GitPromptSettings.AfterText                                   = ''
$GitPromptSettings.AfterForegroundColor                        = [ConsoleColor]::Yellow
$GitPromptSettings.AfterBackgroundColor                        = [ConsoleColor]::DarkGray

$GitPromptSettings.FileAddedText                               = '+'
$GitPromptSettings.FileModifiedText                            = '~'
$GitPromptSettings.FileRemovedText                             = '-'
$GitPromptSettings.FileConflictedText                          = '!'

$GitPromptSettings.LocalDefaultStatusSymbol                    = $null
$GitPromptSettings.LocalDefaultStatusForegroundColor           = [ConsoleColor]::White
$GitPromptSettings.LocalDefaultStatusForegroundBrightColor     = [ConsoleColor]::White
$GitPromptSettings.LocalDefaultStatusBackgroundColor           = [ConsoleColor]::DarkGray

$GitPromptSettings.LocalWorkingStatusSymbol                    = '!'
$GitPromptSettings.LocalWorkingStatusForegroundColor           = [ConsoleColor]::DarkRed
$GitPromptSettings.LocalWorkingStatusForegroundBrightColor     = [ConsoleColor]::DarkRed
$GitPromptSettings.LocalWorkingStatusBackgroundColor           = [ConsoleColor]::DarkGray

$GitPromptSettings.LocalStagedStatusSymbol                     = '~'
$GitPromptSettings.LocalStagedStatusForegroundColor            = [ConsoleColor]::White
$GitPromptSettings.LocalStagedStatusBackgroundColor            = [ConsoleColor]::DarkGray

$GitPromptSettings.BranchUntrackedSymbol                       = $null
$GitPromptSettings.BranchForegroundColor                       = [ConsoleColor]::White
$GitPromptSettings.BranchBackgroundColor                       = [ConsoleColor]::DarkGray

$GitPromptSettings.BranchGoneStatusSymbol                      = [char]0x00D7 # Multiplication sign
$GitPromptSettings.BranchGoneStatusForegroundColor             = [ConsoleColor]::DarkGray
$GitPromptSettings.BranchGoneStatusBackgroundColor             = [ConsoleColor]::DarkGray

$GitPromptSettings.BranchIdenticalStatusToSymbol               = [char]0x2261 # Three horizontal lines
$GitPromptSettings.BranchIdenticalStatusToForegroundColor      = [ConsoleColor]::Yellow
$GitPromptSettings.BranchIdenticalStatusToBackgroundColor      = [ConsoleColor]::DarkGray

$GitPromptSettings.BranchAheadStatusSymbol                     = [char]0x2191 # Up arrow
$GitPromptSettings.BranchAheadStatusForegroundColor            = [ConsoleColor]::White
$GitPromptSettings.BranchAheadStatusBackgroundColor            = [ConsoleColor]::DarkBlue

$GitPromptSettings.BranchBehindStatusSymbol                    = [char]0x2193 # Down arrow
$GitPromptSettings.BranchBehindStatusForegroundColor           = [ConsoleColor]::DarkRed
$GitPromptSettings.BranchBehindStatusBackgroundColor           = [ConsoleColor]::DarkGray

$GitPromptSettings.BranchBehindAndAheadStatusSymbol            = [char]0x2195 # Up & Down arrow
$GitPromptSettings.BranchBehindAndAheadStatusForegroundColor   = [ConsoleColor]::Yellow
$GitPromptSettings.BranchBehindAndAheadStatusBackgroundColor   = [ConsoleColor]::DarkGray

$GitPromptSettings.BeforeIndexText                             = ""
$GitPromptSettings.BeforeIndexForegroundColor                  = [ConsoleColor]::White
$GitPromptSettings.BeforeIndexForegroundBrightColor            = [ConsoleColor]::White
$GitPromptSettings.BeforeIndexBackgroundColor                  = [ConsoleColor]::DarkGray

$GitPromptSettings.IndexForegroundColor                        = [ConsoleColor]::White
$GitPromptSettings.IndexForegroundBrightColor                  = [ConsoleColor]::White
$GitPromptSettings.IndexBackgroundColor                        = [ConsoleColor]::DarkGray

$GitPromptSettings.WorkingForegroundColor                      = [ConsoleColor]::DarkRed
$GitPromptSettings.WorkingForegroundBrightColor                = [ConsoleColor]::DarkRed
$GitPromptSettings.WorkingBackgroundColor                      = [ConsoleColor]::DarkGray

$GitPromptSettings.EnableStashStatus                           = $false
$GitPromptSettings.BeforeStashText                             = ' ('
$GitPromptSettings.BeforeStashBackgroundColor                  = [ConsoleColor]::DarkGray
$GitPromptSettings.BeforeStashForegroundColor                  = [ConsoleColor]::DarkRed
$GitPromptSettings.AfterStashText                              = ')'
$GitPromptSettings.AfterStashBackgroundColor                   = [ConsoleColor]::DarkGray
$GitPromptSettings.AfterStashForegroundColor                   = [ConsoleColor]::DarkRed
$GitPromptSettings.StashBackgroundColor                        = [ConsoleColor]::DarkGray
$GitPromptSettings.StashForegroundColor                        = [ConsoleColor]::DarkRed

$GitPromptSettings.ErrorForegroundColor                        = [ConsoleColor]::DarkRed
$GitPromptSettings.ErrorBackgroundColor                        = [ConsoleColor]::DarkGray

# 
# ---
#
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) { $Script:IsAdmin = $true }
 
function prompt {
    if (((Get-Item $pwd).parent.parent.name)) {
        $Path = '..\' + (Get-Item $pwd).parent.name + '\' + (Split-Path $pwd -Leaf)
    } else {
        $Path = $pwd.path
    }
    
    # Write newline
    # Write-Host " "

    # Write ERR for any PowerShell errors
    if ($Error.Count -ne 0) {
        Write-Host " " -NoNewLine
        Write-Host " ↯ ERR " -NoNewLine -BackgroundColor DarkRed -ForegroundColor Yellow
        Write-Host "$([char]0xE0B0)$([char]0xE0B1)" -ForegroundColor DarkRed -BackgroundColor DarkBlue -NoNewline
        $Error.Clear()
    }

    # Write non-zero exit code from last launched process
    if ($LASTEXITCODE -ne "") {
        Write-Host " " -NoNewLine
        Write-Host " ↯ $LASTEXITCODE " -NoNewLine -BackgroundColor DarkRed -ForegroundColor Yellow
        Write-Host "$([char]0xE0B0)$([char]0xE0B1)" -ForegroundColor DarkRed -BackgroundColor DarkBlue -NoNewline
        $LASTEXITCODE = ""
    }
 
    if($Script:IsAdmin) {
        Write-Host " $([char]0xE0A2)" -ForegroundColor Black -BackgroundColor Green -NoNewline
        Write-Host "$([char]0xE0B0)$([char]0xE0B1)" -ForegroundColor Green -BackgroundColor DarkBlue -NoNewline
    }
 
    Write-Host " $($MyInvocation.HistoryId)" -ForegroundColor white -BackgroundColor DarkBlue -NoNewline
    Write-Host "$([char]0xE0B0)$([char]0xE0B1) " -ForegroundColor DarkBlue -BackgroundColor Cyan -NoNewline
    Write-Host ($path).TrimEnd('\') -ForegroundColor White -BackgroundColor Cyan -NoNewline
    if ((Write-VcsStatus *>&1).Length -gt 0) {
        Write-Host "$([char]0xE0B0)$([char]0xE0B1)" -ForegroundColor Cyan -BackgroundColor DarkGray -NoNewline
        Write-Host (Write-VcsStatus) -NoNewline -BackgroundColor DarkGray
        Write-Host "$([char]0xE0B0)$("$([char]0xE0B1)" * $NestedPromptLevel)" -ForegroundColor DarkGray -NoNewline
    } else {
        Write-Host "$([char]0xE0B0)$("$([char]0xE0B1)" * $NestedPromptLevel)" -ForegroundColor Cyan -NoNewline
    }
    ' '
}
 
# Aliases
function ll {
    Get-ChildItem -Force $args
}

#utility functions
function ws { Set-Location "c:\Studies" }

 
# Readline options

# With these bindings, up arrow/down arrow will work like PowerShell/cmd if the current command line is blank.
# If you've entered some text though, it will search the history for commands that start with the currently entered text.
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

## Tab completion
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineOption -ShowToolTips
 
## Colours
Set-PSReadLineOption -Colors @{
    Command = "Blue";
    Parameter="DarkBlue";
    Comment="Green";
    Operator="Gray";
    Variable="Magenta";
    Keyword="Magenta";
    String="DarkGray";
    Type="DarkCyan"
}
 
# AdvancedHistory
Import-Module AdvancedHistory
Enable-AdvancedHistory -Unique


## Import Git-Alias
## See https://github.com/gluons/powershell-git-aliases
Import-Module git-aliases -DisableNameChecking

## Docker aliase

function docker-command {
    docker $args
}

function docker-images {
    docker image $args
}

function docker-volumes {
    docker volume $args
}

function docker-container {
    docker container $args
}

function docker-remove-all-containers {  
    docker container rm -f $(docker container ls -aq)
}

function docker-clear-all {
    docker-remove-all-containers
    docker system prune -f
    docker volume prune -f
}

function docker-GetContainerIPAddress {  
    param (
        [string] $id
    )
    & docker inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $id
}

function docker-AddContainerIpToHosts {  
    param (
        [string] $name
    )
    $ip = docker inspect --format '{{ .NetworkSettings.Networks.nat.IPAddress }}' $name
    $newEntry = "$ip  $name  #added by d2h# `r`n"
    $path = 'C:\Windows\System32\drivers\etc\hosts'
    $newEntry + (Get-Content $path -Raw) | Set-Content $path
}

Set-Alias d docker-command

Set-Alias dc docker-container

Set-Alias dv docker-volumes

Set-Alias di docker-images

Set-Alias dclear docker-clear-all

Set-Alias d2h docker-AddContainerIpToHosts 

Set-Alias dip docker-GetContainerIPAddress

Set-Alias drmf docker-remove-all-containers
