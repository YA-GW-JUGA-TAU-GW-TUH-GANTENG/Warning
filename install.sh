#!/bin/bash

# Warna biar cantik
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;36m'
NC='\033[0m'

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${BLUE}        🔧  INSTALLER XyTools  🔧"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# ===== CEK PYTHON =====
echo -e "${YELLOW}[*] Mengecek Python 3...${NC}"
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}[!] Python3 tidak ditemukan! Install dulu: pkg install python${NC}"
    exit 1
else
    echo -e "${GREEN}[✔] Python3 terinstall.${NC}"
fi

# ===== CEK & INSTALL DEPENDENSI (MODULE PYTHON) =====
echo -e "${YELLOW}[*] Mengecek modul Python yang dibutuhkan...${NC}"

MODULES=("requests" "urllib3")
for mod in "${MODULES[@]}"; do
    if python3 -c "import $mod" &> /dev/null; then
        echo -e "${GREEN}[✔] $mod sudah terinstall.${NC}"
    else
        echo -e "${YELLOW}[+] Menginstall $mod...${NC}"
        pip install $mod
        if [ $? -ne 0 ]; then
            echo -e "${RED}[!] Gagal install $mod. Coba manual: pip install $mod${NC}"
        fi
    fi
done

# ===== CEK & INSTALL APLIKASI EKSTERNAL =====
APPS=("php" "cloudflared" "mpv" "lolcat" "node")
for app in "${APPS[@]}"; do
    if command -v $app &> /dev/null; then
        echo -e "${GREEN}[✔] $app sudah terinstall.${NC}"
    else
        echo -e "${YELLOW}[+] Menginstall $app...${NC}"
        pkg install $app -y
        if [ $? -ne 0 ]; then
            echo -e "${RED}[!] Gagal install $app. Coba manual: pkg install $app${NC}"
        fi
    fi
done

# ===== CEK BEAUTIFULSOUP (Opsional buat JEC) =====
if python3 -c "import bs4" &> /dev/null; then
    echo -e "${GREEN}[✔] beautifulsoup4 sudah terinstall.${NC}"
else
    echo -e "${YELLOW}[+] Menginstall beautifulsoup4...${NC}"
    pip install beautifulsoup4
fi

echo -e "${GREEN}\n[✔] SEMUA DEPENDENSI SIAP!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# ===== JALANKAN TOOLS =====
echo -e "${YELLOW}[*] Menjalankan XyTools.py...${NC}"
python3 XyTools.pyc
