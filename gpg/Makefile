# Makefile for GPG and SSH-based Git commit signing setup
# Variables: override via CLI or export
KEY_ID   ?= YOUR_KEY_ID_HERE
SSH_KEY  ?= $(HOME)/.ssh/id_ed25519
EMAIL    ?= you@example.com

.PHONY: help install-gpg install-pinentry generate list-keys export-public export-secret \
        configure-git-gpg configure-git-ssh send-key revoke check-key-id verify-signature

help:
	@echo "Available targets:"
	@echo "  install-gpg           brew install gnupg"
	@echo "  install-pinentry      brew install pinentry-mac and configure gpg-agent"
	@echo "  generate              interactively generate a new GPG key"
	@echo "  list-keys             list secret keys with long key IDs"
	@echo "  export-public         export public key to public-gpg-key.asc"
	@echo "  export-secret         export secret key to secret-gpg-key.asc"
	@echo "  configure-git-gpg     set Git to use GPG signing"
	@echo "  configure-git-ssh     set Git to use SSH key for commit signing"
	@echo "  send-key              send public key to keys.openpgp.org"
	@echo "  revoke                generate a revocation certificate"
	@echo "  check-key-id          verify KEY_ID is set correctly"
	@echo "  verify-signature      show commit signature verification"

install-gpg:
	brew install gnupg

install-pinentry:
	brew install pinentry-mac
	@echo "Add 'pinentry-program /usr/local/bin/pinentry-mac' to ~/.gnupg/gpg-agent.conf"
	@echo "Then run: gpgconf --kill gpg-agent"

generate:
	gpg --full-generate-key

list-keys:
	gpg --list-secret-keys --keyid-format LONG

export-public: check-key-id
	gpg --armor --export $(KEY_ID) > public-gpg-key.asc
	@echo "Public key exported to public-gpg-key.asc"

export-secret: check-key-id
	gpg --armor --export-secret-keys $(KEY_ID) > secret-gpg-key.asc
	@echo "Secret key exported to secret-gpg-key.asc"

configure-git-gpg:
	git config --global user.signingkey $(KEY_ID)
	git config --global commit.gpgsign true
	git config --global gpg.program gpg
	@echo "Git configured with GPG signing key $(KEY_ID)"

configure-git-ssh:
	git config --global user.signingkey $(SSH_KEY)
	git config --global commit.gpgsign true
	git config --global gpg.format ssh
	git config --global gpg.program ssh
	@echo "Git configured to use SSH key $(SSH_KEY) for signing"

send-key:
	gpg --keyserver hkps://keys.openpgp.org --send-keys $(KEY_ID)
	@echo "Key $(KEY_ID) sent to keys.openpgp.org"

revoke:
	gpg --output revoke.asc --gen-revoke $(KEY_ID)
	@echo "Revocation certificate generated at revoke.asc"

check-key-id:
	if [ "$(KEY_ID)" = "YOUR_KEY_ID_HERE" ] || [ -z "$(KEY_ID)" ]; then echo "Error: KEY_ID is not set. Please override KEY_ID"; exit 1; fi
	@echo "KEY_ID is set to $(KEY_ID)"

verify-signature:
	git log --show-signature -1
