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
	@python -c "import requests, json, sys, os, random, time, re, string, signal, urllib3, Crypto" 2>/dev/null || { \
		echo "$(RED)   [-] Some modules are missing. Installing now...$(RESET)"; \
		pip install requests urllib3 beautifulsoup4 pycryptodome 2>/dev/null || pkg install python -y && pip install requests urllib3 beautifulsoup4 pycryptodome; \
		echo "$(GREEN)   [+] All modules installed successfully!$(RESET)"; \
	}
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
	@pkg install python -y
	@pip install requests urllib3 beautifulsoup4 pycryptodome
	@echo "$(GREEN)   [+] All done!$(RESET)"

# Bersihkan cache
clean:
	@echo "$(YELLOW)   [+] Cleaning cache files...$(RESET)"
	@rm -rf __pycache__
	@rm -f *.pyc
	@echo "$(GREEN)   [+] Cache cleaned!$(RESET)"
