# -*- makefile -*-
# macOS 用 yt-dlp セットアップ Makefile
.PHONY: default usage install howto docker-build docker-run compose-build compose-download compose-usage

# デフォルトターゲット: 使用方法の表示
default: usage

# usage: ターゲット一覧と説明を出力
usage:
	@echo "macOS用 yt-dlp セットアップ"
	@echo ""
	@echo "Usage:"
	@echo "  make install         # Homebrew とツールのインストール"
	@echo "  make docker-build    # Dockerイメージのビルド"
	@echo "  make docker-run      # Dockerコンテナの実行例"
	@echo "  make compose-build   # Docker Composeでビルド"
	@echo "  make compose-usage   # Docker Composeの使用方法"
	@echo "  make howto           # 記事とチャットスレッドのURLを表示"

# install: Homebrew がなければインストールし、yt-dlp と ffmpeg を導入
install:
	@echo "macOS環境にyt-dlpとffmpegをインストール中..."
	@command -v brew >/dev/null 2>&1 || (echo "Homebrew をインストール中…" && \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)")
	@echo "yt-dlp をインストール中…"
	brew install yt-dlp/taps/yt-dlp
	@echo "ffmpeg をインストール中…"
	brew install ffmpeg
	@echo "インストール完了！"
	@echo "使用例: yt-dlp 'https://youtube.com/watch?v=VIDEO_ID'"

# docker-build: Dockerイメージをビルド
docker-build:
	@echo "Dockerイメージをビルド中..."
	docker build -t yt-dlp-env .
	@echo "ビルド完了！"

# docker-run: Dockerコンテナの実行例を表示
docker-run:
	@echo "Dockerコンテナの使用例:"
	@echo ""
	@echo "# 使用方法を表示:"
	@echo "docker run --rm yt-dlp-env"
	@echo ""
	@echo "# 動画をダウンロード（現在のディレクトリに保存）:"
	@echo "docker run --rm -v \$$(pwd):/downloads yt-dlp-env download URL='https://youtube.com/watch?v=VIDEO_ID'"
	@echo ""
	@echo "⚠️  重要: -v \$$(pwd):/downloads を忘れないでください！"
	@echo "   これを忘れると、ファイルがコンテナ内に残り、コンテナ削除時に失われます。"

# compose-build: Docker Composeでイメージをビルド
compose-build:
	@echo "Docker Composeでイメージをビルド中..."
	docker compose build
	@echo "ビルド完了！"

# compose-usage: Docker Composeの使用方法を表示
compose-usage:
	@echo "Docker Composeの使用方法:"
	@echo ""
	@echo "# 使用方法を表示:"
	@echo "docker compose run --rm yt-dlp"
	@echo ""
	@echo "# 動画をダウンロード（downloadsディレクトリに保存）:"
	@echo "URL='https://youtube.com/watch?v=VIDEO_ID' docker compose run --rm yt-dlp download"
	@echo ""
	@echo "# より短縮した形:"
	@echo "docker compose run --rm -e URL='https://youtube.com/watch?v=VIDEO_ID' yt-dlp download"
	@echo ""
	@echo "# Makefileを使った最短版:"
	@echo "URL='https://youtube.com/watch?v=VIDEO_ID' make compose-download"
	@echo ""
	@echo "✅ メリット: ボリュームマウントが自動で設定される"
	@echo "✅ ファイルは ./downloads ディレクトリに保存される"

# compose-download: Docker Composeでダウンロード（URL環境変数が必要）
compose-download:
	@if [ -z "$$URL" ]; then \
		echo "エラー: URL環境変数を指定してください"; \
		echo "使用例: URL='https://youtube.com/watch?v=VIDEO_ID' make compose-download"; \
		exit 1; \
	fi
	@echo "Docker Composeでダウンロード中..."
	@mkdir -p downloads
	docker compose run --rm yt-dlp download

# howto: 記事とチャットスレッドのURLを表示
howto:
	@echo "Article: https://zenn.dev/srgr0/articles/youtube-live-recording-from-start-for-mac"
	@echo "Chat:    https://chatgpt.com/g/g-p-67974ca9c59c819196cb60fb81cbdba4-ji-shi-yao-yue/c/6861ffe8-4998-8000-bf1c-e3035608a0d5"
