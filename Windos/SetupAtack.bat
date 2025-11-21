@echo off
setlocal enabledelayedexpansion
title Verificacao Completa - AttackBox Windows
cls

echo ================================================
echo     VERIFICACAO COMPLETA DO ATTACKBOX WINDOWS
echo ================================================
echo.

echo [DEBUG] Script iniciou corretamente.
echo.

:: ====== 1. CHECAR DEFENDER ======
echo [1/9] Verificando Windows Defender...
powershell -command "Get-MpComputerStatus | Format-List" > defender.tmp 2>nul

if %errorlevel%==0 (
    echo [OK] Defender consultado.
) else (
    echo [ERRO] Falha consultando Defender.
)

echo.

:: ====== 2. CHECAR SSH ======
echo [2/9] Verificando servico SSH...
sc query sshd >nul 2>&1
if %errorlevel%==0 (
    echo [OK] SSH instalado.
) else (
    echo [FALHOU] SSH nao encontrado.
)
echo.

:: ====== 3. PORTA 22 ======
echo [3/9] Verificando porta 22...
netstat -ano | findstr :22 >nul
if %errorlevel%==0 (
    echo [OK] Porta 22 aberta.
) else (
    echo [FALHOU] Porta 22 nao esta aberta.
)
echo.

:: ====== 4. CHOCOLATEY ======
echo [4/9] Testando Chocolatey...
choco -v >nul 2>&1
if %errorlevel%==0 (
    echo [OK] Chocolatey encontrado.
) else (
    echo [FALHOU] Chocolatey nao encontrado.
)
echo.

:: ====== 5. TOOLS ======
echo [5/9] Verificando ferramentas...
for %%t in (nmap python git rustc code) do (
    %%t --version >nul 2>&1
    if !errorlevel!==0 (
        echo [OK] Ferramenta %%t instalada.
    ) else (
        echo [FALHOU] %%t nao encontrada.
    )
)
echo.

:: ====== 6. PERFIL POWERSHELL ======
echo [6/9] Verificando perfil PowerShell...
powershell -command "if (Test-Path $PROFILE) { exit 0 } else { exit 1 }"
if %errorlevel%==0 (
    echo [OK] Perfil existe.
) else (
    echo [FALHOU] Perfil nao existe.
)
echo.

:: ====== 7. WSL ======
echo [7/9] Verificando WSL...
wsl -l -v > wsl.tmp 2>&1

findstr /i "kali" wsl.tmp >nul
if !errorlevel!==0 (
    echo [OK] Kali encontrado.
) else (
    echo [FALHOU] Kali nao detectado.
)

findstr /i "2" wsl.tmp >nul
if !errorlevel!==0 (
    echo [OK] WSL2 ativo.
) else (
    echo [FALHOU] WSL esta no modo 1.
)
echo.

:: ====== 8. ENERGIA ======
echo [8/9] Plano de energia...
powercfg /getactivescheme | findstr /i "High" >nul
if !errorlevel!==0 (
    echo [OK] Alto desempenho ativo.
) else (
    echo [FALHOU] Modo de energia nao eh o melhor.
)
echo.

:: ====== 9. SERVICOS ======
echo [9/9] Verificando servicos desativados...
for %%s in (diagtrack wsearch SysMain) do (
    sc query %%s | findstr /i "STOPPED" >nul
    if !errorlevel!==0 (
        echo [OK] %%s desativado.
    ) else (
        echo [FALHOU] %%s ativo.
    )
)
echo.

echo.
echo FINALIZADO — pressione uma tecla para sair.
pause >nul

exit
