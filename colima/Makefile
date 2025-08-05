# -*- makefile -*-
# colima setup for macOS Homebrew

GUIDE_URL = "https://www.notion.so/xtetsuji/macOS-Docker-2c8026162c7942f7b77a229f4f35e306#1084d8578c8d8097a65fea5517a38e68"

usage:
	@echo "Usage:"
	@echo "  make install              - Install Docker, Colima, and Docker Compose"
	@echo "    make install-docker-buildx - Install Docker Buildx"
	@echo "    make install-docker-compose - Install Docker Compose plugin"
	@echo "    make mkmountdir           - Create the mount directory"
	@echo "  make uninstall            - Uninstall Docker, Colima, and Docker Compose"
	@echo "  make start                - Start Colima with specified resources"
	@echo "  make stop                 - Stop Colima"
	@echo "  make status               - Show Colima status"
	@echo "  make guide                - Show the setup guide URL"
	@echo "  make test                 - Run a test Docker container"

guide:
	@echo $(GUIDE_URL)

status:
	colima status || true

install:
	brew install docker colima docker-compose
	$(MAKE) install-docker-buildx
	$(MAKE) install-docker-compose
	$(MAKE) mkmountdir

install-docker-buildx:
	brew install docker-buildx
	mkdir ~/.docker/cli-plugins || true
	ln -sfn $(which docker-buildx) ~/.docker/cli-plugins/docker-buildx
	docker buildx install

install-docker-compose:
	mkdir ~/.docker/cli-plugins || true
	ln -sfn $(which docker-compose) ~/.docker/cli-plugins/docker-compose

mkmountdir:
	sudo mkdir -p /Volumes/projects

uninstall:
	brew uninstall docker colima docker-compose

start:
	colima start --cpu 8 --memory 12 --disk 100 --vm-type vz

stop:
	colima stop

test:
	docker run hello-world

