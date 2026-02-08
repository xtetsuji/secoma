# Makefile for gallery-dl on macOS
# Usage examples:
#  make install
#  make example-config      # creates ~/.config/gallery-dl/config.json and a note about cookies
#  make download URL="https://x.com/feetimages/media"
#  make update
#  make uninstall
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail -c
.PHONY: install check example-config download update uninstall help

BREW := $(shell command -v brew 2>/dev/null || true)

# Where to store cookies (Netscape cookies.txt recommended)
COOKIES ?= $(HOME)/.config/gallery-dl/twitter_cookies.txt
CONFIG ?= $(HOME)/.config/gallery-dl/config.json
# Default URL (override by calling: make download URL="https://x.com/username/media")
URL ?= https://x.com/username/media

check:
	@command -v python3 >/dev/null 2>&1 || { echo "ERROR: python3 not found in PATH."; exit 1; }

install: check
	@echo "=== Installing gallery-dl (macOS friendly) ==="
	@if [ -n "$(BREW)" ]; then \
	  echo "Homebrew found — installing pipx and aria2 via brew..."; \
	  brew install pipx || { echo "ERROR: failed to install pipx via brew."; exit 1; }; \
	  if ! brew install aria2; then \
	    echo "WARN: failed to install aria2. Continue without aria2."; \
	  fi; \
	  pipx ensurepath || echo "WARN: pipx ensurepath failed. Please ensure PATH includes pipx."; \
	else \
	  echo "Homebrew not found — will try to install pipx via pip3."; \
	  python3 -m pip install --user pipx || { echo "ERROR: failed to install pipx via pip."; exit 1; }; \
	  python3 -m pipx ensurepath || echo "WARN: pipx ensurepath failed. Please ensure PATH includes pipx."; \
	fi
	@echo "Installing gallery-dl via pipx..."
	@if command -v pipx >/dev/null 2>&1; then \
	  pipx install --force gallery-dl || { echo "ERROR: pipx failed to install gallery-dl."; exit 1; }; \
	else \
	  echo "ERROR: pipx not available in PATH. Please restart your shell or add pipx to PATH."; \
	  exit 1; \
	fi
	@command -v gallery-dl >/dev/null 2>&1 || { echo "ERROR: gallery-dl command is still unavailable."; exit 1; }
	@echo "Note: If you want parallel downloads, install aria2 (brew install aria2)."
	@echo "Install finished. gallery-dl path: $$(command -v gallery-dl || true)"

# create a minimal config.json and a placeholder for cookies path
example-config:
	@mkdir -p "$(HOME)/.config/gallery-dl"
	@if [ -f "$(CONFIG)" ]; then \
	  backup="$(CONFIG).bak.$$(date +%Y%m%d%H%M%S)"; \
	  cp "$(CONFIG)" "$$backup"; \
	  echo "Backed up existing config to $$backup"; \
	fi
	@cat > "$(CONFIG)" <<-'JSON'
	{
	    "extractor": {
	        "twitter": {
	            "cookies": "~/.config/gallery-dl/twitter_cookies.txt",
	            "metadata": false,
	            "filename": "%(uploader)s/%(id)s.%(extension)s",
	            "size": "original"
	        }
	    },
	    "output": {
	        "directory": "downloads"
	    }
	}
	JSON
	@echo "Wrote example config to $(CONFIG)"
	@echo "Create your cookies in Netscape 'cookies.txt' format at: $(COOKIES)"
	@echo "Tip: use a browser extension like 'Cookie-Editor' or 'EditThisCookie' to export Netscape cookies.txt."

# simple download target: always uses --cookies option
download:
	@echo "=== gallery-dl: download start ==="
	@if ! command -v gallery-dl >/dev/null 2>&1; then \
	  echo "ERROR: gallery-dl command not found. Run: make install"; \
	  exit 1; \
	fi
	@if [ ! -f "$(COOKIES)" ]; then \
	  echo "ERROR: cookies file not found at $(COOKIES); export your authenticated cookies as Netscape cookies.txt and save to this path."; \
	  exit 1; \
	fi
	@if [ -z "$(URL)" ]; then \
	  echo "ERROR: set URL, e.g. make download URL=\"https://x.com/feetimages/media\""; \
	  exit 1; \
	fi
	@echo "Using cookies: $(COOKIES)"
	@echo "Downloading from: $(URL)"
	@gallery-dl --cookies "$(COOKIES)" "$(URL)"
	@echo "=== gallery-dl: download finished ==="

# upgrade gallery-dl (pipx)
update:
	@echo "Updating gallery-dl..."
	@if command -v pipx >/dev/null 2>&1; then \
	  if ! pipx upgrade gallery-dl; then \
	    echo "gallery-dl is not installed in pipx yet. Installing..."; \
	    pipx install --force gallery-dl; \
	  fi; \
	else \
	  python3 -m pip install --user --upgrade gallery-dl; \
	fi
	@command -v gallery-dl >/dev/null 2>&1 || { echo "ERROR: gallery-dl command is still unavailable after update."; exit 1; }
	@echo "Update finished."

uninstall:
	@echo "Uninstalling gallery-dl..."
	@if command -v pipx >/dev/null 2>&1; then \
	  if pipx list | grep -q "package gallery-dl"; then \
	    pipx uninstall gallery-dl; \
	  else \
	    echo "gallery-dl is not installed via pipx."; \
	  fi; \
	else \
	  if python3 -m pip show gallery-dl >/dev/null 2>&1; then \
	    python3 -m pip uninstall -y gallery-dl; \
	  else \
	    echo "gallery-dl is not installed in pip user environment."; \
	  fi; \
	fi
	@echo "Uninstall finished."

help:
	@echo "Makefile targets:"
	@echo "  make check             # verify required commands exist"
	@echo "  make install           # install pipx, aria2 (via brew if available), and gallery-dl"
	@echo "  make example-config    # create ~/.config/gallery-dl/config.json (edit as needed) and note cookies path"
	@echo "  make download URL=...  # download media from given URL (requires cookies at: $(COOKIES))"
	@echo "  make update            # upgrade gallery-dl"
	@echo "  make uninstall         # uninstall gallery-dl"
