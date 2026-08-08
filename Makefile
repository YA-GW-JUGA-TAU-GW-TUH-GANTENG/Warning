# ============================================
# Makefile untuk XyTools - Auto Install Module
# ============================================

.PHONY: run install clean

# Warna buat teks
GREEN  = \033[1;32m
RED    = \033[1;31m
YELLOW = \033[1;33m
CYAN   = \033[1;36m
WHITE  = \033[1;37m
RESET  = \033[0m

# ===== CEK JARINGAN =====
check_network:
	@echo "$(CYAN)   [+] Checking network connection...$(RESET)"
	@ping -c 1 8.8.8.8 > /dev/null 2>&1 || { \
		echo "$(RED)   ❌ JARINGAN TIDAK STABIL / TIDAK TERHUBUNG!$(RESET)"; \
		echo "$(YELLOW)   💡 SARAN:$(RESET)"; \
		echo "  1. Cek WiFi/data seluler Anda."; \
		echo "  2. Aktifkan mode pesawat selama 5 detik, lalu matikan."; \
		echo "  3. Restart modem/router Anda."; \
		echo "  4. Pindah ke lokasi dengan sinyal lebih kuat."; \
		echo "$(RED)   ⚠️  Tools tidak bisa dijalankan tanpa internet!$(RESET)"; \
		exit 1; \
	}
	@echo "$(GREEN)   ✅ Jaringan stabil. Melanjutkan...$(RESET)"
	@sleep 0.5

# ===== CEK & INSTALL LOLCAT =====
check_lolcat:
	@echo "$(YELLOW)   [+] Checking lolcat...$(RESET)"
	@command -v lolcat > /dev/null 2>&1 || { \
		echo "$(CYAN)   [+] lolcat belum terinstall. Menginstall sekarang...$(RESET)"; \
		pkg install lolcat -y > /dev/null 2>&1 || apt install lolcat -y > /dev/null 2>&1 || echo "$(RED)   [!] Gagal install lolcat. Lanjut tanpa warna.$(RESET)"; \
	}
	@echo "$(GREEN)   [+] lolcat siap!$(RESET)"
	@sleep 0.3

# ===== CEK MODULE PYTHON =====
check_python:
	@echo "$(YELLOW)   [+] Checking required Python modules...$(RESET)"
	@python -c "import requests, json, sys, os, random, time, re, string, signal, urllib3" 2>/dev/null || { \
		echo "$(CYAN)   [+] Installing missing Python modules...$(RESET)"; \
		pip install requests urllib3 beautifulsoup4 pycryptodome 2>/dev/null || pkg install python -y && pip install requests urllib3 beautifulsoup4 pycryptodome; \
		echo "$(GREEN)   [+] All Python modules installed!$(RESET)"; \
	}
	@echo "$(GREEN)   [+] Python modules ready.$(RESET)"
	@sleep 0.3

# ===== RUN UTAMA =====
run: check_network check_lolcat check_python
	@clear
	@echo "$(CYAN)   >>> STARTING UP XYTOOLS ENGINE...$(RESET)"
	@sleep 0.5
	@echo "$(GREEN)   [+] Core modules loaded.$(RESET)"
	@sleep 0.3
	@echo "$(CYAN)   [+] Injecting UI components...$(RESET)"
	@sleep 0.3
	@echo "$(YELLOW)   [+] Finalizing system initialization...$(RESET)"
	@sleep 0.5
	@echo "$(GREEN)   ✅ SYSTEM READY.$(RESET)"
	@echo ""
	@sleep 1
	@if [ -f $(PWD)/XyTools.py ]; then \
		python $(PWD)/XyTools.py; \
	elif [ -f $(PWD)/XyTools.pyc ]; then \
		python $(PWD)/XyTools.pyc; \
	else \
		echo "$(RED)   [ERROR] File XyTools.py atau .pyc tidak ditemukan!$(RESET)"; \
	fi

# Install dependencies paksa (jika user mau manual)
install:
	@echo "$(CYAN)   [+] Installing all required dependencies...$(RESET)"
	@pkg install python lolcat -y
	@pip install requests urllib3 beautifulsoup4 pycryptodome
	@echo "$(GREEN)   [+] All done!$(RESET)"

# Bersihkan cache
clean:
	@echo "$(YELLOW)   [+] Cleaning cache files...$(RESET)"
	@rm -rf __pycache__
	@rm -f *.pyc
	@echo "$(GREEN)   [+] Cache cleaned!$(RESET)"
