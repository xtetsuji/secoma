# Makefile for installing GitHub Copilot CLI

NPM_PACKAGE = @githubnext/github-copilot-cli
.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install    Install GitHub Copilot CLI globally using npm."
	@echo "  uninstall  Uninstall GitHub Copilot CLI."

# Check for npm before running install or uninstall
.PHONY: check-npm
check-npm:
	@command -v npm >/dev/null 2>&1 || (echo "Error: npm is not installed. Please install Node.js and npm."; exit 1)

.PHONY: install
install: check-npm
	@echo "Installing $(NPM_PACKAGE) globally via npm..."
	npm install -g $(NPM_PACKAGE)
	@echo "Installation complete. Run 'github-copilot-cli auth' to authenticate."

.PHONY: uninstall
uninstall: check-npm
	@echo "Uninstalling $(NPM_PACKAGE)..."
	npm uninstall -g $(NPM_PACKAGE)
	@echo "Uninstallation complete."
