Set-Alias c clear
Set-Alias ll ls

$APIFY = "192.168.100.47"
$NANO_PD = "192.168.100.90"
$UAT = "192.168.100.37"
$PORTAL = "192.168.100.95"
$NOVA = "192.168.100.48"
$PGI = "192.168.100.74"
$EDEN = "192.168.100.89"

$SERVERS = @{
    APIFY   = $APIFY
    NANO_PD = $NANO_PD
    UAT     = $UAT
    PORTAL  = $PORTAL
    NOVA    = $NOVA
    PGI     = $PGI
    EDEN    = $EDEN
}

function Start-SSH {
    param(
        [string]$Server = "",
        [string]$User = "root",
        [Int32]$Port = 2222
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

$CODE_DIR = "D:\CODE"
function Select-Directory() {

    param (
        [string]$Path = '',
        [int]$Depth = 1
    )

    $BaseDIR = if ($Path) { Join-Path $CODE_DIR $Path } else { $CODE_DIR }

    $Selected = Get-ChildItem -Path $BaseDIR -Depth $Depth -Attributes Directory -Name | fzf --bind "alt-c:execute(echo dr:{})+abort"

    if (-not $Selected) {
        return ''
    }

    if ( $Selected.StartsWith("dr:")) {

        $Child = $Selected.Replace("dr:", "").Replace('"', "")

        $ChildPath = if ($Path) { Join-Path $Path $Child } else { $Child }

        $Selected = Select-Directory -Path $ChildPath -Depth 0

        return $Selected
    }

    $path = Join-Path $BaseDIR $Selected

    return $path
}

function Get-Project() {

    param(
        [string]$Path = ''
    )

    $PathLocation = Select-Directory -Path $Path

    if ($PathLocation) {
        Set-Location $PathLocation
    }
}

Set-Alias -Name cw -Value Get-Project

function Start-Dev() {
    param (
        [string]$Path,
        [string]$Command = 'dev'
    )

    if ($Path) {
        $PathLocation = Join-Path $CODE_DIR $Path
        Set-Location $PathLocation
    }
    else {
        $PathLocation = Select-Directory -Path $Path

        if ($PathLocation) {
            Set-Location $PathLocation
        }
    }

    if ($PathLocation) {
        if ($Command -eq 'dev') {
            npm run dev
        }
        else {
            npm run start
        }

    }
}
    
Set-Alias -Name dev -Value Start-Dev

# Git aliases
Set-Alias -Name g -Value git


function Npm-Start() {
    npm run start
}

Set-Alias -Name ds -value Npm-Start
