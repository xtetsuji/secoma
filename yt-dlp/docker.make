# -*- makefile -*-
# Docker 用 yt-dlp 使用 Makefile
.PHONY: default usage download version

# デフォルトターゲット: 使用方法の表示
default: usage

# usage: ターゲット一覧と説明を出力
usage:
	@echo "Docker環境用 yt-dlp"
	@echo ""
	@echo "Usage:"
	@echo "  make download URL='https://youtube.com/watch?v=...'  # 動画をダウンロード"
	@echo "  make version                                         # yt-dlpのバージョン表示"
	@echo ""
	@echo "Examples:"
	@echo "  make download URL='https://youtube.com/watch?v=VIDEO_ID'"
	@echo "  make download URL='https://youtu.be/VIDEO_ID'"
	@echo ""
	@echo "Output directory: /downloads"

# download: yt-dlpで動画をダウンロード
download:
	@if [ -z "$$URL" ]; then \
		echo "エラー: URLを指定してください"; \
		echo "使用例: make download URL='https://youtube.com/watch?v=VIDEO_ID'"; \
		exit 1; \
	fi
	@echo "ダウンロード開始: $$URL"
	@echo "出力先: /downloads"
	@if ! mountpoint -q /downloads 2>/dev/null; then \
		echo "⚠️  警告: /downloads がマウントされていません"; \
		echo "   ファイルはコンテナ内に保存され、コンテナ削除時に失われます"; \
		echo "   推奨: docker run -v \$$(pwd):/downloads ..."; \
		echo ""; \
	fi
	yt-dlp "$$URL" \
		-o "/downloads/%(uploader)s - %(title)s [%(id)s].%(ext)s" \
		--write-description \
		--write-info-json \
		--write-thumbnail \
		--embed-chapters \
		--embed-metadata
	@echo "ダウンロード完了"
	@if ! mountpoint -q /downloads 2>/dev/null; then \
		echo ""; \
		echo "⚠️  ファイルはコンテナ内の /downloads に保存されました"; \
		echo "   永続化するには -v オプションでボリュームマウントしてください"; \
	fi

# version: yt-dlpとffmpegのバージョンを表示
version:
	@echo "=== yt-dlp version ==="
	yt-dlp --version
	@echo ""
	@echo "=== ffmpeg version ==="
	ffmpeg -version | head -1
