# gallery-dl 用 Makefile

このリポジトリは、`gallery-dl` のインストールと簡単な実行を `make` で扱うための最小構成です。

## できること

- `make install`  
  `gallery-dl` のインストールを試みます（`brew` があれば `pipx` と `aria2` も導入）。
- `make example-config`  
  `~/.config/gallery-dl/config.json` のサンプルを作成します。
- `make download URL="https://x.com/<user>/media"`  
  指定 URL を `gallery-dl` でダウンロードします（cookies 必須）。
- `make update`  
  `gallery-dl` を更新します。
- `make uninstall`  
  `gallery-dl` をアンインストールします。

## 前提

- macOS 想定
- `make`
- `python3`
- X(Twitter) 取得時は Netscape 形式の cookies ファイル  
  デフォルト: `~/.config/gallery-dl/twitter_cookies.txt`

## 使い方

```bash
make install
make example-config
make download URL="https://x.com/username/media"
```

## 補足

- `download` ターゲットは `--cookies` を明示指定して実行します。
- 取得先 URL や cookies パスは実行時に上書きできます。

```bash
make download URL="https://x.com/someone/media" COOKIES="$HOME/.config/gallery-dl/my_cookies.txt"
```

## 注意点

- X(Twitter) の仕様変更や認証要件の変更により、cookies があっても取得できないことがあります。
- 各サービスの利用規約・法令を守って利用してください。
