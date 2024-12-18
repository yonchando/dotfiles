Set-Alias c cls
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

$SERVERS = @{
    Local = "127.0.0.1"
    UAT = "192.168.1.1"
    Digi = "192.168.56.56"
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

$Work = "d:\code"

function Select-Directory(){
    $Selected = Get-ChildItem -Path $Work -Depth 1 -Attributes Directory -Name | fzf
    return $Selected
}

function Get-Project() {

    $Select = Select-Directory

    if ($Select) {
        Set-Location $Work/$Select

        return $Select
    }

    return ""
}

Set-Alias -Name cw -Value Get-Project

function Start-Dev() {
    param (
        [string]$Path
    )

    if ($Path) {
        $Select = "$CODE_DIR/laravel/$Path"
        Set-Location $Select
    }
    else {
        $Select = Get-Project
    }

    if ($Select) {
        npm run dev
    }

}

Set-Alias -Name dev -Value Start-Dev
