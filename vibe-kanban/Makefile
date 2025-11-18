# -*- makefile -*-

VK_BACKEND_PORT ?= 7777

usage:
	@echo "Usage:"
	@echo "  make run-plain"
	@echo "  make run-local    Run the application on localhost"
	@echo "  make run-fullopen Run the application on all interfaces (0.0.0.0)"

run-plain:
	npx vibe-kanban

run-local:
	env \
		BACKEND_PORT=$(VK_BACKEND_PORT) \
		npx vibe-kanban

run-fullopen:
	env \
		HOST=0.0.0.0 \
		BACKEND_PORT=$(VK_BACKEND_PORT) \
		npx vibe-kanban
