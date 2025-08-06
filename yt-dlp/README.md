# yt-dlp Setup

YouTube動画のダウンロード環境をセットアップするためのツール群です。

## ファイル構成

- `Dockerfile` - yt-dlpとffmpegを含むDockerイメージの定義
- `docker-compose.yml` - Docker Composeの設定ファイル
- `Makefile` - macOS用のインストールとDocker操作コマンド集
- `docker.make` - Docker内で使用されるMakefile
- `chatgpt_url.txt` - 参考にしたChatGPTの会話URL
- `.gitignore` - ダウンロードファイルや一時ファイルの除外設定

## 使用方法

### macOS環境でのローカルインストール
```bash
# yt-dlpとffmpegをインストール
make install

# 使用例
yt-dlp 'https://youtube.com/watch?v=VIDEO_ID'
```

### Docker環境での使用
```bash
# イメージをビルド
make docker-build

# 使用方法を確認
docker run --rm yt-dlp-env

# 動画をダウンロード（現在のディレクトリに保存）
docker run --rm -v $(pwd):/downloads yt-dlp-env download URL='https://youtube.com/watch?v=VIDEO_ID'

# より詳細なダウンロード（メタデータ・サムネイル込み）
docker run --rm -v $(pwd):/downloads yt-dlp-env download URL='https://youtu.be/VIDEO_ID'
```

#### ⚠️ 重要: ボリュームマウントについて
- **`-v $(pwd):/downloads`は必須です**
- これを忘れると、ダウンロードファイルはコンテナ内に残り、コンテナ削除時に失われます
- コンテナ実行時に警告メッセージが表示されます

### Docker Compose版（推奨：よりシンプル）
```bash
# イメージをビルド
make compose-build

# 使用方法を確認
docker compose run --rm yt-dlp

# 動画をダウンロード（./downloadsディレクトリに自動保存）
URL='https://youtube.com/watch?v=VIDEO_ID' docker compose run --rm yt-dlp download

# Makefileを使った短縮版
URL='https://youtube.com/watch?v=VIDEO_ID' make compose-download
```

#### ✅ Docker Composeのメリット
- **ボリュームマウント自動**: `./downloads`ディレクトリが自動でマウントされる
- **コマンドが短い**: 長いdocker runコマンドを覚える必要がない
- **設定の再利用**: 一度設定すれば何度でも使える

### Docker使用例の表示
```bash
make docker-run
```

### 参考情報
```bash
make howto
```

## 参考記事
- [YouTube Live配信を開始時点から録画する方法（Mac対応）](https://zenn.dev/srgr0/articles/youtube-live-recording-from-start-for-mac)
