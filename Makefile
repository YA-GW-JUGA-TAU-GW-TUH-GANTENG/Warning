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

run:
	@clear
	@echo "$(CYAN)   >>> STARTING UP XYTOOLS ENGINE...$(RESET)"
	@sleep 0.5
	@echo "$(YELLOW)   [+] Checking required Python modules...$(RESET)"
	@python -c "import requests, json, sys, os, random, time, re, string, signal, urllib3" 2>/dev/null || { \
		echo "$(RED)   [-] Some Python modules are missing. Installing now...$(RESET)"; \
		pip install requests urllib3 2>/dev/null || pkg install python -y && pip install requests urllib3; \
		echo "$(GREEN)   [+] Python modules installed successfully!$(RESET)"; \
	}
	@sleep 0.5
	@echo "$(YELLOW)   [+] Checking required system packages...$(RESET)"
	@command -v mpv >/dev/null 2>&1 || { \
		echo "$(RED)   [-] mpv not found. Installing...$(RESET)"; \
		pkg install mpv -y 2>/dev/null || apt install mpv -y 2>/dev/null || echo "$(YELLOW)   [!] mpv installation failed. Please install manually: pkg install mpv$(RESET)"; \
	}
	@command -v lolcat >/dev/null 2>&1 || { \
		echo "$(RED)   [-] lolcat not found. Installing...$(RESET)"; \
		pkg install lolcat -y 2>/dev/null || gem install lolcat 2>/dev/null || apt install lolcat -y 2>/dev/null || echo "$(YELLOW)   [!] lolcat installation failed. Please install manually: pkg install lolcat$(RESET)"; \
	}
	@command -v termux-media-player >/dev/null 2>&1 || { \
		echo "$(YELLOW)   [+] termux-media-player not found. Installing as fallback...$(RESET)"; \
		pkg install termux-media-player -y 2>/dev/null || echo "$(YELLOW)   [!] termux-media-player not installed. mpv will be used.$(RESET)"; \
	}
	@sleep 0.5
	@echo "$(GREEN)   [+] Core modules and system packages loaded.$(RESET)"
	@sleep 0.3
	@echo "$(CYAN)   [+] Injecting UI components...$(RESET)"
	@sleep 0.3
	@echo "$(YELLOW)   [+] Finalizing system initialization...$(RESET)"
	@sleep 0.5
	@echo "$(GREEN)   ✅ SYSTEM READY.$(RESET)"
	@echo ""
	@sleep 1
	@if [ -f "$(PWD)/XyTools.py" ]; then \
		python "$(PWD)/XyTools.py"; \
	elif [ -f "$(PWD)/XyTools.pyc" ]; then \
		python "$(PWD)/XyTools.pyc"; \
	else \
		echo "$(RED)   [ERROR] File XyTools.py atau .pyc tidak ditemukan di $(PWD)!$(RESET)"; \
		echo "$(YELLOW)   Pastikan file berada di folder yang sama dengan Makefile.$(RESET)"; \
	fi

# Install dependencies paksa (jika user mau manual)
install:
	@echo "$(CYAN)   [+] Installing all required dependencies...$(RESET)"
	@pkg install python mpv lolcat termux-media-player -y
	@pip install requests urllib3
	@echo "$(GREEN)   [+] All done!$(RESET)"

# Bersihkan cache
clean:
	@echo "$(YELLOW)   [+] Cleaning cache files...$(RESET)"
	@rm -rf __pycache__
	@rm -f *.pyc
	@echo "$(GREEN)   [+] Cache cleaned!$(RESET)"
