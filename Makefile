# Makefile untuk XyTools

.PHONY: run check_network check_python install

# ===== TARGET UTAMA =====
run: check_network check_python
	@echo -e "\033[1;32m[✔] Semua pengecekan selesai.\033[0m"
	@echo -e "\033[1;36m[🚀] Menjalankan XyTools.pyc...\033[0m"
	@python3 XyTools.pyc

# ===== CEK JARINGAN =====
check_network:
	@echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	@echo -e "\033[1;36m       🌐  CHECKING NETWORK STABILITY  \033[0m"
	@echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	@ping -c 2 8.8.8.8 > /dev/null 2>&1 && \
		echo -e "\033[1;32m[✔] Jaringan stabil (8.8.8.8 reachable).\033[0m" || \
		(echo -e "\033[1;31m[!] Jaringan tidak stabil! Cek koneksi internet Anda.\033[0m" && exit 1)
	@echo -e ""

# ===== CEK PYTHON =====
check_python:
	@echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	@echo -e "\033[1;36m       🐍  CHECKING PYTHON VERSION      \033[0m"
	@echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	@python3 --version | grep -q "Python 3" && \
		echo -e "\033[1;32m[✔] Python 3 terinstall: $$(python3 --version)\033[0m" || \
		(echo -e "\033[1;31m[!] Python 3 tidak ditemukan! Install dulu: pkg install python\033[0m" && exit 1)
	@echo -e ""

# ===== INSTALL =====
# Hanya dijalankan dengan: make install
install:
	@echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	@echo -e "\033[1;36m       ⚙️  RUNNING INSTALL.SH           \033[0m"
	@echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
	@bash install.sh
