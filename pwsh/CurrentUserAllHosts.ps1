# For Latest PowerShell on All
# --------------------------------------------------

# Keybind
Set-PSReadlineOption -EditMode "Emacs"

# History Suggestion
Set-PSReadLineOption -PredictionSource "History"

# History
# https://github.com/kelleyma49/PSFzf
Import-Module PSFzf
Enable-PsFzfAliases
# Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'

# Location commands
# https://github.com/vors/ZLocation
Import-Module ZLocation

# Prompt
function Prompt {
    $PromptString = "PS " + $(Get-Location) + ">"

    $IsPrivileged = (
        [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([System.Security.Principal.WindowsBuiltInRole] "Administrator")
    $PromptColor = $IsPrivileged ? [ConsoleColor]::Red : [ConsoleColor]::DarkMagenta

    Write-Host $PromptString -NoNewline -ForegroundColor $PromptColor

    return " "
}

# Alias
function GitStatus { git status $Args }
function GitDiffCached { git diff --cached $Args }
function GitDiff { git diff $Args }
function GitBranch { git branch $Args }
function GitGraph { git graph $Args }
Set-Alias -name s -Value GitStatus
Set-Alias -name gd -Value GitDiff
Set-Alias -name gdc -Value GitDiffCached
Set-Alias -name gb -Value GitBranch
Set-Alias -name gr -Value GitGraph
