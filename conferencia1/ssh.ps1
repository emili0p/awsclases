Write-Host "Instalando OpenSSH Server..."

$ssh = Get-WindowsCapability -Online |
    Where-Object Name -like 'OpenSSH.Server*'

if ($ssh.State -ne "Installed") {
    Add-WindowsCapability -Online `
        -Name OpenSSH.Server~~~~0.0.1.0
}

Write-Host "Iniciando servicio SSH..."
Start-Service sshd

Write-Host "Configurando inicio automático..."
Set-Service -Name sshd -StartupType Automatic

Write-Host "Configurando Firewall..."

if (-not (Get-NetFirewallRule -Name sshd -ErrorAction SilentlyContinue)) {
    New-NetFirewallRule `
        -Name sshd `
        -DisplayName "OpenSSH Server" `
        -Enabled True `
        -Direction Inbound `
        -Protocol TCP `
        -Action Allow `
        -LocalPort 22
}

Write-Host ""
Write-Host "Estado del servicio:"
Get-Service sshd

Write-Host ""
Write-Host "Direcciones IPv4:"
Get-NetIPAddress -AddressFamily IPv4 |
    Where-Object {$_.IPAddress -notlike "127.*"} |
    Select-Object IPAddress

Write-Host ""
Write-Host "Instalación completada."
