# colima-setup

このディレクトリは macOS にて Homebrew を使って colima をセットアップ、colima を利用して Docker を使えるようにする Makefile が収められています。

## 必要なもの

- macOS
- [Homebrew](https://brew.sh/)

## 使い方

### 使い方を表示

```bash
make
```

または

```bash
make usage
```

### インストール

Docker、Colima、Docker Composeをインストールします：

```bash
make install
```

このコマンドは以下を実行します：
- Docker、Colima、Docker Composeのインストール
- Docker Buildxプラグインのセットアップ
- Docker Composeプラグインのセットアップ
- マウントディレクトリ（`/Volumes/projects`）の作成

### Colimaの開始・停止

Colimaを開始（CPU 8コア、メモリ12GB、ディスク100GBで起動）：

```bash
make start
```

Colimaを停止：

```bash
make stop
```

### ステータス確認

Colimaの現在の状態を確認：

```bash
make status
```

### テスト

Dockerが正常に動作するかテスト：

```bash
make test
```

hello-worldコンテナが実行されます。

### その他のコマンド

利用可能なコマンドの一覧を表示：

```bash
make usage
```

セットアップガイドのURLを表示：

```bash
make guide
```

アンインストール：

```bash
make uninstall
```

## 個別インストールコマンド

必要に応じて個別にプラグインをインストールできます：

```bash
# Docker Buildxプラグインのみ
make install-docker-buildx

# Docker Composeプラグインのみ
make install-docker-compose

# マウントディレクトリの作成のみ
make mkmountdir
```

## 注意事項

- `make start`で指定されているリソース（CPU 8コア、メモリ12GB、ディスク100GB）は環境に応じて調整してください
- `/Volumes/projects`ディレクトリは管理者権限で作成されます
- 初回起動時は少し時間がかかる場合があります
