# -*- makefile -*-
# macOS 向け Tailscale セットアップ Makefile
# - CLI: Homebrew からインストール
# - GUI: Mac App Store (mas CLI) からインストール

BREW    := $(shell command -v brew >/dev/null 2>&1 && echo brew)
MAS     := $(shell command -v mas  >/dev/null 2>&1 && echo mas)
APP_ID  ?= 1475387142   # Tailscale (Mac App Store)
APP_NAME ?= Tailscale
APP_PATH ?= /Applications/Tailscale.app
APP_RECEIPT := $(APP_PATH)/Contents/_MASReceipt/receipt
APP_BIN ?= $(APP_PATH)/Contents/MacOS/Tailscale
FORCE_MAS ?= 0
FORCE_CASK ?= 0
WRAPPER_SRC ?= ./tailscale-wrapper.sh
WRAPPER_DEST ?= /usr/local/bin/tailscale
FORCE_WRAPPER ?= 0

.DEFAULT_GOAL := usage

.PHONY: usage install install-cli install-app install-cask-gui open-app open-store status up down uninstall-cli \
        uninstall-app-mas \
        check-brew check-mas install-status install-wrapper check-wrapper-src \
        cli-version cli-update status-peers status-json bugreport

usage:
	@echo "Tailscale セットアップ"
	@echo ""
	@echo "Usage: make <target>"
	@echo "  install        Homebrew 版 CLI と Mac App Store 版 GUI をまとめてインストール"
	@echo "                 ※ CLI は Tailscale.app ラッパー利用が推奨。formula は任意"
	@echo "  install-cli    Homebrew の formula から tailscale CLI (tailscaled/CLI) をインストール"
	@echo "  install-app    mas で Mac App Store 版 Tailscale.app (APP_ID=$(APP_ID)) をインストール"
	@echo "                 既存の Tailscale.app が非 App Store 版なら停止します (FORCE_MAS=1 で上書き)"
	@echo "  install-cask-gui Homebrew Cask で GUI をインストール (App Store 版がある場合は停止: FORCE_CASK=1 で上書き)"
	@echo "  open-app       Tailscale.app を起動"
	@echo "  open-store     Mac App Store の Tailscale ページを開く (手動インストール用)"
	@echo "  install-status 現在のインストール状態を表示 (CLI/GUI/mas アカウント)"
	@echo "  install-wrapper tailscale ラッパースクリプトをコピー (WRAPPER_SRC->WRAPPER_DEST, FORCE_WRAPPER=1 で上書き)"
	@echo "  cli-version    tailscale CLI のバージョンを表示"
	@echo "  cli-update     Homebrew formula tailscale をアップデート"
	@echo "  status-peers   tailscale status --peers を表示"
	@echo "  status-json    tailscale status --json を表示（デバッグ用途）"
	@echo "  bugreport      tailscale bugreport を実行（sudo が必要な場合あり）"
	@echo "  status         tailscale status を表示"
	@echo "  up             sudo tailscale up でログイン (ブラウザが開きます)"
	@echo "  down           tailscale down で切断"
	@echo "  uninstall-cli  Homebrew の tailscale をアンインストール"
	@echo "  uninstall-app-mas mas でインストールした Tailscale.app を削除 (App Store 版のみ)"

# CLI+GUI をまとめてインストール
install: install-cli install-app

# Homebrew formula から CLI を導入
install-cli: check-brew
	@echo "Homebrew 版 tailscale をインストールします..."
	$(BREW) install --formula tailscale

# mas で App Store 版 GUI を導入（既存版の判定付き）
install-app: check-mas
	@if [ -d "$(APP_PATH)" ] && [ ! -f "$(APP_RECEIPT)" ] && [ "$(FORCE_MAS)" != "1" ]; then \
		echo "Tailscale.app が既に存在しますが、Mac App Store のレシートが見つかりません。"; \
		echo "多重インストールを避けるため処理を中止します。"; \
		echo "選択肢:"; \
		echo " 1) 手動で $(APP_PATH) を削除してから再度 'make install-app'"; \
		echo " 2) 既存アプリを残したまま上書きする: FORCE_MAS=1 make install-app"; \
		exit 1; \
	fi
	@if [ -f "$(APP_RECEIPT)" ] && [ "$(FORCE_MAS)" != "1" ]; then \
		echo "Tailscale.app はすでに Mac App Store 版がインストールされています。スキップします。"; \
		exit 0; \
	fi
	@echo "Mac App Store から Tailscale (APP_ID=$(APP_ID)) をインストールします..."
	$(MAS) install $(APP_ID)
	@echo "インストール完了後、初回は Tailscale.app を起動してサインインしてください。"

# Cask で GUI を導入（App Store 版がある場合は警告）
install-cask-gui: check-brew
	@if [ -f "$(APP_RECEIPT)" ] && [ "$(FORCE_CASK)" != "1" ]; then \
		echo "Tailscale.app は既に Mac App Store 版がインストールされています。上書きする場合は FORCE_CASK=1 を指定してください。"; \
		exit 1; \
	fi
	@echo "Homebrew Cask で Tailscale GUI をインストールします..."
	$(BREW) install --cask tailscale

# GUI を起動
open-app:
	@echo "Tailscale.app を起動します..."
	open -a "$(APP_NAME)" || echo "Tailscale.app が見つかりませんでした。Mac App Store からインストール済みか確認してください。"

# App Store の Tailscale ページを開く
open-store:
	@echo "Mac App Store の Tailscale ページを開きます..."
	open "macappstore://itunes.apple.com/app/id$(APP_ID)"

# インストール状態のサマリ表示
install-status:
	@echo "==> CLI (brew formula):"
	@CLI_BIN=$$(command -v tailscale 2>/dev/null); \
	if [ -n "$$CLI_BIN" ]; then \
		echo "tailscale CLI: $$CLI_BIN"; \
		if command -v brew >/dev/null 2>&1 && [ "$$CLI_BIN" = "$$(brew --prefix)/bin/tailscale" ]; then \
			echo "origin: Homebrew formula"; \
		elif grep -q "$(APP_BIN)" "$$CLI_BIN" 2>/dev/null; then \
			echo "origin: wrapper -> $(APP_BIN)"; \
		else \
			echo "origin: custom/unknown"; \
		fi; \
		tailscale version || true; \
	else \
		echo "tailscale CLI: not found"; \
	fi
	@command -v brew >/dev/null 2>&1 && brew list --formula tailscale >/dev/null 2>&1 && echo "brew formula tailscale: installed" || echo "brew formula tailscale: not installed"
	@echo ""
	@echo "==> GUI (Tailscale.app):"
	@if [ -d "$(APP_PATH)" ]; then \
		echo "Found: $(APP_PATH)"; \
		if [ -f "$(APP_RECEIPT)" ]; then \
			echo "Receipt: App Store version detected"; \
		else \
			echo "Receipt: not found (likely non-App-Store build)"; \
		fi; \
	else \
		echo "Tailscale.app not found at $(APP_PATH)"; \
	fi
	@echo ""
	@echo "==> mas (App Store CLI):"
	@if command -v mas >/dev/null 2>&1; then \
		echo "mas: installed at $$(command -v mas)"; \
		echo "account status: macOS の仕様変更で CLI からは取得できない可能性があります。App Store.app でサインイン状態を確認してください。"; \
	else \
		echo "mas: not installed"; \
	fi

# ラッパースクリプトを所定パスへコピー
install-wrapper: check-wrapper-src
	@if [ -e "$(WRAPPER_DEST)" ] && [ "$(FORCE_WRAPPER)" != "1" ]; then \
		echo "既に $(WRAPPER_DEST) が存在します。上書きする場合は FORCE_WRAPPER=1 を指定してください。"; \
		exit 1; \
	fi
	@if ! grep -q "$(APP_BIN)" "$(WRAPPER_SRC)" 2>/dev/null; then \
		echo "警告: WRAPPER_SRC に $(APP_BIN) への参照が見つかりません。MAS 版実行パスが異なる可能性があります。"; \
	fi
	install -m 0755 "$(WRAPPER_SRC)" "$(WRAPPER_DEST)"
	@echo "ラッパーを $(WRAPPER_DEST) にインストールしました。"

# CLI バージョン表示
cli-version:
	@command -v tailscale >/dev/null 2>&1 && tailscale version || { echo "tailscale CLI が見つかりません"; exit 1; }

# CLI を Homebrew でアップデート
cli-update: check-brew
	$(BREW) upgrade tailscale

# ピア一覧付きのステータス
status-peers:
	tailscale status --peers || true

# JSON 形式のステータス
status-json:
	tailscale status --json || true

# バグレポート生成（sudo が必要な場合あり）
bugreport:
	sudo tailscale bugreport || tailscale bugreport || true

# 接続状態を表示
status:
	tailscale status || true

# ログイン（ブラウザ認証）
up:
	@echo "ブラウザでのログインが必要です。sudo が求められる場合があります。"
	sudo tailscale up

# 切断
down:
	sudo tailscale down || true

# CLI のアンインストール
uninstall-cli: check-brew
	@echo "Homebrew 版 tailscale をアンインストールします..."
	$(BREW) uninstall --formula tailscale || true

# App Store 版 GUI のアンインストール
uninstall-app-mas: check-mas
	@if [ ! -f "$(APP_RECEIPT)" ] && [ "$(FORCE_MAS)" != "1" ]; then \
		echo "Mac App Store 版のレシートが見つかりません。App Store 版でない場合は手動削除してください。"; \
		echo "強制的に mas uninstall を実行する場合は FORCE_MAS=1 を指定してください。"; \
		exit 1; \
	fi
	$(MAS) uninstall $(APP_ID) || { \
		echo "mas uninstall が失敗しました。App Store.app からの削除を試してください。"; \
		exit 1; \
	}

# Homebrew 存在チェック
check-brew:
	@command -v brew >/dev/null 2>&1 || { \
		echo "Homebrew が見つかりません。https://brew.sh/ を参照してインストールしてください。"; \
		exit 1; \
	}

# mas 存在チェック
check-mas: check-brew
	@command -v mas >/dev/null 2>&1 || { \
		echo "mas が見つかりません。次のいずれかを実施してください:"; \
		echo "  - Homebrew で mas をインストール: 'brew install mas'"; \
		echo "  - もしくは Mac App Store から手動で Tailscale.app をインストールしてください"; \
		exit 1; \
	}

# ラッパーのソースファイル存在チェック
check-wrapper-src:
	@if [ ! -f "$(WRAPPER_SRC)" ]; then \
		echo "WRAPPER_SRC が見つかりません: $(WRAPPER_SRC)"; \
		echo "例: WRAPPER_SRC=/path/to/your/tailscale-wrapper.sh make install-wrapper"; \
		exit 1; \
	fi
