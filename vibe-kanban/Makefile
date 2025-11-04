# -*- makefile -*-
# Vibe Kanban の CLI を呼び出すための Makefile エントリーポイント
# VK_BACKEND_PORT はアプリケーションのバックエンドを束縛するポートを指定する。
# 未指定の場合は 7777 が利用される。
VK_BACKEND_PORT ?= 7777

usage:
	@echo "Usage:"
	@echo "  make run-local    Run the application on localhost"
	@echo "  make run-fullopen Run the application on all interfaces (0.0.0.0)"

run-local:
	env \
		BACKEND_PORT=$(VK_BACKEND_PORT) \
		npx vibe-kanban

run-fullopen:
	env \
		HOST=0.0.0.0 \
		BACKEND_PORT=$(VK_BACKEND_PORT) \
		npx vibe-kanban
