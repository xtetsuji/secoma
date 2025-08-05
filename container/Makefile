# https://chatgpt.com/c/68480115-0274-8000-a6ce-a5772521b65a
# Makefile for installing and configuring Apple container CLI and unofficial container-compose

BREW := $(shell command -v brew >/dev/null 2>&1 && echo brew)

.DEFAULT_GOAL := usage

.PHONY: usage all install-container install-compose configure

# Display usage information
usage:
	@echo "Usage: make <target>"
	@echo
	@echo "Available targets:"
	@echo "  install-container   Install Apple container CLI via Homebrew Cask"
	@echo "  install-compose     Install unofficial container-compose (requires Go)"
	@echo "  configure           Reload shell and start container management system"
	@echo "  all                 Install container, install compose, and configure"

# Install Apple container CLI via Homebrew Cask
install-container:
	@echo "==> Installing Apple container CLI via Homebrew..."
	$(BREW) install --cask container

# Install unofficial container-compose (requires Go)
install-compose:
	@echo "==> Installing unofficial container-compose..."
	@command -v go >/dev/null 2>&1 || { \
		echo "Error: Go not found. Please install Go to proceed."; \
		exit 1; \
	}
	@go install github.com/noghartt/container-compose@latest
	@echo "container-compose installed to $$(go env GOPATH)/bin"

# Configuration: prompt user to reload shell and start container management system
configure:
	@echo "==> Please restart your shell (e.g. 'exec $$SHELL -l') to update PATH if needed."
	@echo "==> Starting container management system..."
	@container system start || echo "Warning: container system may require macOS 26 Beta or elevated privileges."

# Combined target: install everything and configure
all: install-container install-compose configure
