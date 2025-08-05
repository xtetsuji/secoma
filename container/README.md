# Apple Container CLI Setup

Apple container CLI と非公式 container-compose のインストール・設定ツールです。

## 概要

このMakefileは以下をセットアップします：
- Apple container CLI（Homebrew Cask経由）
- 非公式 container-compose（Go経由）

## 必要な環境

- macOS 26 Beta（container systemの動作に必要）
- [Homebrew](https://brew.sh/)
- [Go](https://golang.org/)（container-composeのインストールに必要）

## 使用方法

### 使い方を表示

```bash
make
```

または

```bash
make usage
```

### すべてインストール・設定

```bash
make all
```

このコマンドは以下の処理を順次実行します：
1. Apple container CLI のインストール
2. container-compose のインストール
3. システムの設定

### 個別インストール

```bash
make install-container  # Apple container CLI のみ
make install-compose    # container-compose のみ
make configure          # 設定のみ
```

## 注意事項

- container systemの動作にはmacOS 26 Betaまたは管理者権限が必要な場合があります
- インストール後はシェルの再起動が必要な場合があります（`exec $SHELL -l`）
- container-composeは非公式ツールです
- Go がインストールされていない場合、container-compose のインストールは失敗します

## インストール詳細

### Apple container CLI
- Homebrew Cask経由でインストール
- `brew install --cask container` を実行

### container-compose
- Go のツールチェーンを使用してインストール
- `go install github.com/noghartt/container-compose@latest` を実行
- `$GOPATH/bin` にインストールされます

## 参考資料

- [ChatGPT会話ログ](https://chatgpt.com/c/68480115-0274-8000-a6ce-a5772521b65a)
- [container-compose GitHub](https://github.com/noghartt/container-compose)
