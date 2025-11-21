@echo off
title AttackBox Windows - Configuração Completa
color 0a

echo ================================================
echo   CONFIGURAÇÃO DO NOTEBOOK 2 – ARMA WINDOWS
echo ================================================
echo.

:: --- Criar diretórios principais ---
echo [1/12] Criando estrutura de pastas...
mkdir C:\AttackBox
mkdir C:\AttackBox\Tools
mkdir C:\AttackBox\Bloodhound
mkdir C:\AttackBox\Payloads
mkdir C:\AttackBox\PostEx
mkdir C:\AttackBox\WordPayloads
mkdir C:\AttackBox\WSL
echo OK.
echo.


:: --- Ativar recursos do Windows necessários ---
echo [2/12] Ativando WSL2 e VirtualMachinePlatform...
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
echo OK.
echo.

:: --- Instalar WSL2 + Kali ---
echo [3/12] Instalando WSL2 com Kali Linux...
wsl --install -d kali-linux
echo OK. Quando acabar, abra o Kali pelo menos 1 vez para finalizar.
echo.


:: --- Instalar .NET para rodar ferramentas C#/.NET ---
echo [4/12] Instalando .NET Runtime 6...
powershell -Command "Invoke-WebRequest https://download.visualstudio.microsoft.com/download/pr/493a2a52-baaa-4e8f-b1b2-f809f3bbcc22/2f4e8e15870d5840b3c2b8b016c04a2a/dotnet-runtime-6.0.36-win-x64.exe -OutFile C:\AttackBox\dotnet.exe"
C:\AttackBox\dotnet.exe /quiet /norestart
echo OK.
echo.


:: --- Baixar SharpHound ---
echo [5/12] Baixando SharpHound...
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/BloodHoundAD/BloodHound/master/Collectors/SharpHound.ps1 -OutFile C:\AttackBox\Bloodhound\SharpHound.ps1"
echo OK.
echo.

:: --- Baixar BloodHound GUI ---
echo [6/12] Baixando BloodHound GUI...
powershell -Command "Invoke-WebRequest https://github.com/BloodHoundAD/BloodHound/releases/download/v5.0.0/BloodHound-win32-x64.zip -OutFile C:\AttackBox\Bloodhound\bloodhound.zip"
powershell -Command "Expand-Archive C:\AttackBox\Bloodhound\bloodhound.zip C:\AttackBox\Bloodhound\BH"
echo OK.
echo.

:: --- Baixar Powerview ---
echo [7/12] Baixando Powerview.ps1...
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Recon/PowerView.ps1 -OutFile C:\AttackBox\PostEx\PowerView.ps1"
echo OK.
echo.

:: --- Baixar EvilWinRM ---
echo [8/12] Baixando EvilWinRM...
powershell -Command "Invoke-WebRequest https://github.com/Hackplayers/evil-winrm/archive/refs/heads/master.zip -OutFile C:\AttackBox\Tools\evilwinrm.zip"
powershell -Command "Expand-Archive C:\AttackBox\Tools\evilwinrm.zip C:\AttackBox\Tools\EvilWinRM"
echo OK.
echo.

:: --- Payloads Office / HTA / MSI templates ---
echo [9/12] Baixando templates de payloads Office/HTA/MSI...
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/redcanaryco/atomic-red-team/master/atomics/T1218.005/src/hta_payload.hta -OutFile C:\AttackBox\Payloads\template.hta"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/benrpearson/security-macros/master/payload.docm -OutFile C:\AttackBox\WordPayloads\payload.docm"
echo OK.
echo.

:: --- Ferramentas de pós exploração .NET ---
echo [10/12] Baixando executáveis úteis (.NET)...
powershell -Command "Invoke-WebRequest https://github.com/Flangvik/SharpCollection/archive/refs/heads/master.zip -OutFile C:\AttackBox\PostEx\SharpCollection.zip"
powershell -Command "Expand-Archive C:\AttackBox\PostEx\SharpCollection.zip C:\AttackBox\PostEx\SharpCollection"
echo OK.
echo.

:: --- Configurações opcionais para não interferência ---
echo [11/12] Ajustando Defender (opcional)...
echo REM :: Defender OFF - Se quiser habilitar, remova o REM
REM powershell -Command "Set-MpPreference -DisableRealtimeMonitoring $true"
echo OK.
echo.

:: --- Configurar PATH ---
echo [12/12] Adicionando ferramentas ao PATH...
setx PATH "%PATH%;C:\AttackBox\Tools;C:\AttackBox\PostEx;C:\AttackBox\Bloodhound\BH"
echo OK.
echo.

echo ================================================
echo     AMBIENTE DE ATAQUE WINDOWS PRONTO
echo ================================================
echo - BloodHound instalado
echo - SharpHound instalado
echo - Powerview instalado
echo - EvilWinRM instalado
echo - Payloads Office/HTA/MSI prontos
echo - Estrutura completa configurada
echo.
echo Reinicie o PC para ativar o WSL2 corretamente.
pause
