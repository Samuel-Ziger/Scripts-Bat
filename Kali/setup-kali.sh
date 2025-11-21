#!/bin/bash

echo "========================================"
echo "   Kali Linux - Setup Completo Automático"
echo "========================================"

# 1. Atualizar o sistema
echo "[1] Atualizando o sistema..."
sudo apt update && sudo apt full-upgrade -y

# 2. Instalar Kali Full
echo "[2] Instalando meta-pacotes do Kali..."
sudo apt install kali-linux-large -y
# OU para tudo mesmo:
# sudo apt install kali-linux-everything -y

# 3. Ativar performance da CPU
echo "[3] Otimizando CPU..."
sudo apt install cpufrequtils -y
sudo cpufreq-set -g performance

# 4. Instalar ferramentas Red Team
echo "[4] Instalando ferramentas de brute-force..."
sudo apt install hydra medusa ncrack -y

echo "[4] Instalando ferramentas de enumeração..."
sudo apt install gobuster seclists bloodhound bloodhound.py -y

echo "[4] Instalando SQLmap..."
sudo apt install sqlmap -y

echo "[4] Instalando ExploitDB, Metasploit e Veil..."
sudo apt install exploitdb metasploit-framework veil-evasion -y

echo "[4] Instalando utilidades de rede..."
sudo apt install net-tools netcat-traditional -y

echo "[4] Instalando WPScan..."
sudo apt install wpscan -y

# 5. Criar diretórios de ataque
echo "[5] Criando diretórios padrão..."
mkdir -p ~/recon ~/exploit ~/bruteforce ~/enum ~/loot ~/wordlists

# 6. Baixar wordlists pesados
echo "[6] Baixando SecLists..."
cd ~/wordlists
sudo git clone https://github.com/danielmiessler/SecLists.git

# 7. Otimizar rede
echo "[7] Otimizando rede para scans..."
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.core.somaxconn = 65535' | sudo tee -a /etc/sysctl.conf
echo 'fs.file-max = 100000' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# 8. Instalar ferramentas específicas
echo "[8] Instalando Masscan..."
sudo apt install masscan -y

echo "[8] Instalando Ffuf..."
sudo apt install ffuf -y

echo "[8] Instalando Golang e Kerbrute..."
sudo apt install golang -y
go install github.com/ropnop/kerbrute@latest

# 9. WordPress hacking – WPScan Gem
echo "[9] Instalando WPScan via Gem..."
sudo gem install wpscan

# 10. Docker
echo "[10] Instalando Docker..."
sudo apt install docker.io docker-compose -y
sudo systemctl enable docker --now

# 11. Timeshift
echo "[11] Instalando Timeshift..."
sudo apt install timeshift -y

# 12. OpenSSH Server
echo "[12] Instalando SSH Server..."
sudo apt install openssh-server -y
sudo systemctl enable ssh --now

echo "========================================"
echo "   SETUP FINALIZADO!"
echo " Reinicie a máquina para aplicar tudo."
echo "========================================"
