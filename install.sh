#!/bin/bash

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

# ===== DETEKSI PIP / PIP3 =====
if command -v pip3 &> /dev/null; then
    PIP_CMD="pip3"
elif command -v pip &> /dev/null; then
    PIP_CMD="pip"
else
    echo -e "${RED}[!] pip/pip3 tidak ditemukan! Install python-pip: pkg install python-pip${NC}"
    exit 1
fi
echo -e "${GREEN}[✔] Menggunakan perintah: $PIP_CMD${NC}"

# ===== INSTALL MODUL PYTHON =====
echo -e "${YELLOW}[*] Memastikan modul Python terinstall...${NC}"

MODULES=("requests" "urllib3" "beautifulsoup4" "pycryptodome" "lolcat")
for mod in "${MODULES[@]}"; do
    echo -e "${YELLOW}[+] Menginstall $mod (force)...${NC}"
    $PIP_CMD install --upgrade --force-reinstall $mod
    if [ $? -ne 0 ]; then
        echo -e "${RED}[!] Gagal install $mod. Coba manual: $PIP_CMD install $mod${NC}"
    else
        echo -e "${GREEN}[✔] $mod berhasil diinstall/update.${NC}"
    fi
done

# ===== INSTALL APLIKASI TERMUX =====
APPS=("php" "cloudflared" "mpv" "node" "ruby")
for app in "${APPS[@]}"; do
    echo -e "${YELLOW}[+] Menginstall $app...${NC}"
    pkg install $app -y
    if [ $? -ne 0 ]; then
        echo -e "${RED}[!] Gagal install $app. Coba manual: pkg install $app${NC}"
    else
        echo -e "${GREEN}[✔] $app berhasil diinstall.${NC}"
    fi
done

# ===== FALLBACK LOLCAT (KALAU PIP GAGAL, PAKE GEM) =====
echo -e "${YELLOW}[*] Mengecek apakah lolcat (program) bisa dipanggil...${NC}"
if command -v lolcat &> /dev/null; then
    echo -e "${GREEN}[✔] lolcat (program) sudah terinstall.${NC}"
else
    echo -e "${YELLOW}[+] Mencoba install lolcat via Ruby (gem)...${NC}"
    if command -v gem &> /dev/null; then
        gem install lolcat
        if [ $? -ne 0 ]; then
            echo -e "${RED}[!] Gagal install lolcat via gem. Coba manual: gem install lolcat${NC}"
        else
            echo -e "${GREEN}[✔] lolcat berhasil diinstall via gem.${NC}"
        fi
    else
        echo -e "${YELLOW}[!] Ruby/gem tidak ditemukan. Abaikan lolcat.${NC}"
    fi
fi

echo -e "${GREEN}\n[✔] SEMUA DEPENDENSI SIAP!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# ===== JALANKAN TOOLS =====
echo -e "${YELLOW}[*] Menjalankan XyTools.py...${NC}"
python3 XyTools.pyc
