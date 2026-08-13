# ============================================
# Makefile untuk XyTools - Auto Install Module (BENERAN INSTALL)
# ============================================

.PHONY: run install clean

# Warna buat teks
GREEN  = \033[1;32m
RED    = \033[1;31m
YELLOW = \033[1;33m
CYAN   = \033[1;36m
WHITE  = \033[1;37m
RESET  = \033[0m

# File utama
TARGET = XyTools.py
TARGET_O = XyTools.pyc

# ============================================
# RUN (Auto-check & Install semuanya)
# ============================================
run:
	@clear
	@echo "$(CYAN)   >>> STARTING UP XYTOOLS ENGINE...$(RESET)"
	@sleep 0.5
	
	# ===== 1. CEK PYTHON & PIP =====
	@echo "$(YELLOW)   [+] Checking Python & pip...$(RESET)"
	@command -v python3 >/dev/null 2>&1 || { \
		echo "$(RED)   [-] Python3 not found. Installing...$(RESET)"; \
		pkg install python -y 2>/dev/null || apt install python3 -y 2>/dev/null || { \
			echo "$(RED)   [ERROR] Failed to install Python. Please install manually!$(RESET)"; \
			exit 1; \
		}; \
	}
	@command -v pip >/dev/null 2>&1 || { \
		echo "$(RED)   [-] pip not found. Installing...$(RESET)"; \
		python3 -m ensurepip 2>/dev/null || pkg install python-pip -y 2>/dev/null || { \
			echo "$(RED)   [ERROR] Failed to install pip. Please install manually!$(RESET)"; \
			exit 1; \
		}; \
	}
	
	# ===== 2. CEK & INSTALL PYTHON MODULES =====
	@echo "$(YELLOW)   [+] Checking required Python modules...$(RESET)"
	@python3 -c "import requests, json, sys, os, random, time, re, string, signal, urllib3" 2>/dev/null || { \
		echo "$(RED)   [-] Some Python modules are missing. Installing now...$(RESET)"; \
		pip install requests urllib3 colorama beautifulsoup4 pycryptodome 2>/dev/null || { \
			echo "$(RED)   [-] pip install failed. Trying apt install...$(RESET)"; \
			apt install python3-requests python3-urllib3 python3-colorama python3-bs4 -y 2>/dev/null || { \
				echo "$(RED)   [-] apt install failed. Retrying with pip...$(RESET)"; \
				pip install requests urllib3 colorama beautifulsoup4 pycryptodome; \
			}; \
		}; \
		echo "$(GREEN)   [+] Python modules installed successfully!$(RESET)"; \
	}
	
	# ===== 3. CEK & INSTALL SYSTEM PACKAGES =====
	@echo "$(YELLOW)   [+] Checking required system packages...$(RESET)"
	@command -v mpv >/dev/null 2>&1 || { \
		echo "$(RED)   [-] mpv not found. Installing...$(RESET)"; \
		pkg install mpv -y 2>/dev/null || apt install mpv -y 2>/dev/null || echo "$(YELLOW)   [!] mpv installation failed. Please install manually: pkg install mpv$(RESET)"; \
	}
	@command -v lolcat >/dev/null 2>&1 || { \
		echo "$(RED)   [-] lolcat not found. Installing...$(RESET)"; \
		pkg install lolcat -y 2>/dev/null || gem install lolcat 2>/dev/null || apt install lolcat -y 2>/dev/null || echo "$(YELLOW)   [!] lolcat installation failed. Please install manually: pkg install lolcat$(RESET)"; \
	}
	@command -v cloudflared >/dev/null 2>&1 || { \
		echo "$(YELLOW)   [+] cloudflared not found. Installing for tunneling...$(RESET)"; \
		pkg install cloudflared -y 2>/dev/null || curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64 -o /data/data/com.termux/files/usr/bin/cloudflared && chmod +x /data/data/com.termux/files/usr/bin/cloudflared 2>/dev/null || echo "$(YELLOW)   [!] cloudflared installation failed. Tunnel features may not work.$(RESET)"; \
	}
	
	# ===== 4. FINAL CHECK =====
	@sleep 0.5
	@echo "$(GREEN)   [+] All dependencies verified.$(RESET)"
	@sleep 0.3
	
	# ===== 5. JALANKAN TOOLS =====
	@if [ -f "$(PWD)/$(TARGET)" ]; then \
		echo "$(CYAN)   [+] Running $(TARGET)...$(RESET)"; \
		python3 "$(PWD)/$(TARGET)"; \
	elif [ -f "$(PWD)/$(TARGET_O)" ]; then \
		echo "$(CYAN)   [+] Running $(TARGET_O)...$(RESET)"; \
		python3 "$(PWD)/$(TARGET_O)"; \
	else \
		echo "$(RED)   [ERROR] File $(TARGET) atau $(TARGET_O) tidak ditemukan di $(PWD)!$(RESET)"; \
		echo "$(YELLOW)   Pastikan file berada di folder yang sama dengan Makefile.$(RESET)"; \
		exit 1; \
	fi

# ============================================
# INSTALL PAKSA (Jika user mau manual)
# ============================================
install:
	@echo "$(CYAN)   [+] Installing all required dependencies...$(RESET)"
	@pkg install python mpv lolcat cloudflared termux-media-player -y
	@pip install requests urllib3 colorama beautifulsoup4 pycryptodome
	@echo "$(GREEN)   [+] All dependencies installed!$(RESET)"

# ============================================
# BERSIHKAN CACHE
# ============================================
clean:
	@echo "$(YELLOW)   [+] Cleaning cache files...$(RESET)"
	@rm -rf __pycache__
	@rm -f *.pyc *.pyo
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@echo "$(GREEN)   [+] All cache cleaned!$(RESET)"
