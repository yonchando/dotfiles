Set-Alias c clear
Set-Alias ll ls

$LOCALHOST = "127.0.0.1"

$SERVERS = @{
    LOCAL = $LOCALHOST
}

function Start-SSH {
    param(
        [string]$Server = "",
        [string]$User = "root",
        [Int32]$Port = 22
    )

    if (!$Server) {
        $Server = $SERVERS.Keys | fzf
    }

    if ($Server) {
        $IP = $SERVERS[$Server]

        ssh $User@$IP -p $Port
    }

}

Set-Alias -Name _ssh -Value Start-SSH

function Get-Directory-Path {
    param (
        [string]$Path = ''
    )

    Write-Host $Path
}

$CODE_DIR = "G:\CODE"
function Select-Directory() {

    param (
        [string]$Path = '',
        [int]$Depth = 1
    )

    $BaseDIR = if ($Path) { Join-Path $CODE_DIR $Path } else { $CODE_DIR }

    # CTRL-Y to copy the command into clipboard using pbcopy
    # $FZF_CTRL_R_OPTS = "ctrl-r:reload(Get-ChildItem -Path $CODE_DIR -Depth $Depth -Attributes Directory -Name)"
    # $FZF_CTRL_F_OPTS = "ctrl-f:reload(pwsh -NoProfile -Command ""Get-ChildItem -Name '{}'"")"
    # $FZF_BIND_OPTS = "$FZF_CTRL_R_OPTS, $FZF_CTRL_F_OPTS"

    $Selected = Get-ChildItem -Path $BaseDIR -Depth $Depth -Attributes Directory -Name | fzf

    if (-not $Selected) {
        return ''
    }

    Write-Host "BaseDir: $BaseDIR, Selected: $Selected"

    $ProjectPath = Join-Path $BaseDIR $Selected

    Set-Location -Path $ProjectPath
}

Set-Alias -Name cw -Value Select-Directory

# Git aliases
Set-Alias -Name g -Value git

function Start-Npm-Run() {
    param (
        [string]$Command = "start"
    )

    Write-Output "npm run $Command"

    npm run $Command
}

Set-Alias -Name npms -value Start-Npm-Run

function Start-Ng-Serve() {
    param (
        [int]$Port = 4200
    )

    Write-Output "ng serve --port $Port"

    ng serve --port $Port
}
Set-Alias -Name ngs -Value Start-Ng-Serve
