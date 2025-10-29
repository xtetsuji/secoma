# -*- makefile -*-
# (xtetsuji private chat memo) https://chatgpt.com/g/g-p-67974ca9c59c819196cb60fb81cbdba4-ji-shi-yao-yue/c/68b70d01-56fc-8330-b4a6-6ad1a1a82bcc 

# Makefile — macOS + Homebrew 前提: Codex CLI セットアップ & 初期設定
SHELL := /bin/bash
CODEX_PKG := @openai/codex
HOME := $(HOME)
GLOBAL_CONFIG := $(HOME)/.codex/config.toml
PROJECT_CONFIG := ./.codex/config.toml

.PHONY: usage brew-check install install-npm install-npm-active check configure-global configure-project init open-config uninstall

# 最初のターゲットは usage
usage:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Common targets:"
	@echo "  install            Install codex via Homebrew (preferred)"
	@echo "  install-npm        (helper) npm-based install (commented guidance)"
	@echo "  install-npm-active Actually run npm install -g @openai/codex"
	@echo "  check              Verify node/npm/codex (prints versions)"
	@echo "  configure-global   Create example ~/.codex/config.toml"
	@echo "  configure-project  Create example .codex/config.toml in this repo"
	@echo "  init               check -> install -> configure-global -> configure-project"
	@echo "  open-config        Open global config in VSCode (if 'code' is available)"
	@echo "  uninstall          Uninstall codex (Homebrew or npm)"
	@echo ""
	@echo "Notes:"
	@echo "  - This Makefile prefers Homebrew: 'brew install codex'."
	@echo "  - npm-based installation is provided as a helper only."
	@echo "  - echo lines are hidden (prefixed with @); other commands are shown."

# Homebrew の存在確認（失敗時は案内）
brew-check:
	command -v brew >/dev/null 2>&1 || { echo "Homebrew が見つかりません: https://brew.sh/ からインストールしてください"; exit 1; }
	@echo "Homebrew found."

# 環境チェック（node/npm/codex の有無確認）
check:
	command -v node >/dev/null 2>&1 || (echo "node not found; consider: brew install node"; exit 1)
	node --version
	npm --version
	command -v codex >/dev/null 2>&1 && codex --version || echo "codex not installed (use 'make install' to install via Homebrew)"

# Homebrew によるインストール（推奨）
install: brew-check
	brew install codex
	@echo "Installed codex via Homebrew. Run 'codex' to start."

# 補助: npm によるインストールを実行しない（案内）
install-npm:
	@echo "npm によるインストールは補助です。実行する場合は 'make install-npm-active' を使ってください."
	@echo "参考: npm install -g $(CODEX_PKG)"

# npm によるインストールを実際に行うルール（必要なら実行）
install-npm-active:
	npm install -g $(CODEX_PKG)
	@echo "Installed $(CODEX_PKG) via npm."

# グローバル設定ファイルの作成（~/.codex/config.toml の雛形）
configure-global:
	mkdir -p $(HOME)/.codex
	cat > $(GLOBAL_CONFIG) <<'EOF'
# ~/.codex/config.toml  (example)
model = "o4-mini"
model_provider = "openai"

[profiles.local]
model = "o4-mini"
sandbox_mode = "read-only"

[profiles.dev]
model = "gpt-5"
sandbox_mode = "workspace-write"

[sandbox_workspace_write]
writable_roots = ["/Users/$(USER)/projects", "/tmp/codex-scratch"]
network_access = false

ask_for_approval = "prompt"

log_level = "info"
history_enabled = true
history_max_messages = 500

[mcp_servers.example]
url = "https://mcp.example.local"
auth_env = "EXAMPLE_MCP_TOKEN"
EOF
	@echo "Wrote example global config to $(GLOBAL_CONFIG)"

# プロジェクト単位設定（./.codex/config.toml）
configure-project:
	mkdir -p ./.codex
	cat > $(PROJECT_CONFIG) <<'EOF'
# .codex/config.toml (project-local example)
model = "o4-mini"
model_provider = "openai"
sandbox_mode = "workspace-write"

[sandbox_workspace_write]
writable_roots = ["./", "./scripts"]
network_access = false

project_guidance_file = "AGENTS.md"
EOF
	@echo "Wrote example project config to $(PROJECT_CONFIG)"

# 一括初期化: check -> install -> configs
init: check install configure-global configure-project
	@echo "Initialization complete. Edit $(GLOBAL_CONFIG) and $(PROJECT_CONFIG) as needed."

# グローバル設定ファイルを VSCode で開く（'code' がある場合）
open-config:
	command -v code >/dev/null 2>&1 && code $(GLOBAL_CONFIG) || echo "No 'code' command in PATH; open $(GLOBAL_CONFIG) manually"

# アンインストール（Homebrew 優先、なければ npm でのアンインストール案内）
uninstall:
	@if command -v brew >/dev/null 2>&1; then \
		echo "Uninstalling via Homebrew..."; \
		brew uninstall --force codex || true; \
		echo "Uninstalled codex (Homebrew)."; \
	else \
		echo "Homebrew not found; to uninstall npm-installed package run: npm uninstall -g $(CODEX_PKG)"; \
	fi
