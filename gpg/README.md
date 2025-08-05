# GPG Setup

GPG と SSH を使用した Git コミット署名のセットアップツールです。

## 概要

このMakefileは以下の機能を提供します：
- GPG の初期セットアップ（gnupg、pinentry-mac のインストール）
- GPG キーペアの生成・管理
- Git コミット署名の設定（GPG / SSH 両方対応）
- 公開鍵・秘密鍵のエクスポート
- キーサーバーへの公開鍵送信

## 必要な環境

- macOS
- [Homebrew](https://brew.sh/)
- Git

## セットアップ手順

### 1. GPG のインストール

```bash
make install-gpg
make install-pinentry
```

### 2. GPG キーペアの生成

```bash
make generate
```

対話式でキーペアを生成します。以下の情報を入力してください：
- 鍵の種類（RSA推奨）
- 鍵長（4096bit推奨）
- 有効期限
- 実名とメールアドレス

### 3. キー ID の確認

```bash
make list-keys
```

生成されたキーの長いキー ID をメモしてください。

### 4. Git の設定

#### GPG を使用する場合

```bash
make configure-git-gpg KEY_ID=あなたのキーID
```

#### SSH キーを使用する場合

```bash
make configure-git-ssh SSH_KEY=~/.ssh/id_ed25519
```

## 使用方法

### 基本操作

```bash
make help                    # 使用可能なコマンドを表示
make list-keys              # 秘密鍵一覧を表示
make verify-signature       # 最新コミットの署名を確認
```

### キー管理

```bash
# 公開鍵をエクスポート
make export-public KEY_ID=あなたのキーID

# 秘密鍵をエクスポート（バックアップ用）
make export-secret KEY_ID=あなたのキーID

# 公開鍵をキーサーバーに送信
make send-key KEY_ID=あなたのキーID

# 失効証明書の生成
make revoke KEY_ID=あなたのキーID
```

### 環境変数での設定

頻繁に使用する場合は環境変数で設定できます：

```bash
export KEY_ID=あなたのキーID
export SSH_KEY=~/.ssh/id_ed25519
export EMAIL=you@example.com
```

## 注意事項

- **秘密鍵の管理**: `secret-gpg-key.asc` は機密情報です。安全な場所に保管し、バージョン管理には含めないでください
- **失効証明書**: `revoke.asc` も重要なファイルです。キーを失った場合に使用します
- **pinentry 設定**: インストール後、`~/.gnupg/gpg-agent.conf` に設定を追加し、`gpgconf --kill gpg-agent` を実行してください
- **パスフレーズ**: GPG キーのパスフレーズは安全なものを使用してください

## ファイル出力

このツールは以下のファイルを生成する可能性があります：
- `public-gpg-key.asc` - 公開鍵（共有可能）
- `secret-gpg-key.asc` - 秘密鍵（機密情報）
- `revoke.asc` - 失効証明書（重要）

## トラブルシューティング

### GPG エージェントの問題

```bash
gpgconf --kill gpg-agent
gpg-agent --daemon
```

### pinentry の問題

`~/.gnupg/gpg-agent.conf` に以下を追加：
```
pinentry-program /usr/local/bin/pinentry-mac
```

### Git 署名の確認

```bash
git log --show-signature -1
```

## 参考資料

- [ChatGPT会話ログ](https://chatgpt.com/g/g-p-68401d8d23f08191839688804f9e5dbb-ge-ren-kai-fa/c/6849b01a-9030-8000-a11a-b51248bbb721)
- [GitHub GPG キー設定ガイド](https://docs.github.com/ja/authentication/managing-commit-signature-verification)
- [GPG 公式ドキュメント](https://gnupg.org/documentation/)
