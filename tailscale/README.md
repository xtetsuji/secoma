# tailscale Makefile ガイド

このディレクトリの Makefile は macOS 向けに次の方針で構成しています。

- GUI は **Mac App Store 版** を推奨  
  - `make install-app` で mas 経由インストール  
  - mas が無い場合は `make open-store` で App Store を開き手動インストール
  - 代替として Homebrew Cask 版 (`make install-cask-gui`) も用意（App Store 版と重複しないよう注意）
- CLI は **Tailscale.app のバイナリを叩くラッパー** を推奨  
  - 用意したラッパーを `make install-wrapper WRAPPER_SRC=./tailscale-wrapper.sh` で配置  
  - Homebrew formula（`brew install tailscale`）は任意。GUI だけで足りる場合は入れなくてよい

主なターゲット

- `make install-app`    : MAS 版 GUI をインストール（既存非MAS版は検知し、FORCE_MAS=1 で上書き可）
- `make install-cask-gui`: Homebrew Cask 版 GUI をインストール（App Store 版がある場合は FORCE_CASK=1 が必要）
- `make open-store`     : App Store の Tailscale ページを開く（mas 無しでも可）
- `make install-wrapper`: ラッパーを `WRAPPER_DEST`（デフォルト `/usr/local/bin/tailscale`）にコピー
- `make install-status` : CLI/GUI のインストール状況とラッパー有無を確認
- `make open-app`       : Tailscale.app を起動
- `make up` / `make down` / `make status` / `make status-peers` : 基本操作
- `make status-json`    : `tailscale status --json` を表示（デバッグ向け）
- `make bugreport`      : `tailscale bugreport` を実行（sudo が必要な場合あり）
- `make uninstall-app-mas`: App Store 版 GUI の削除（App Store 版でない場合は手動削除を推奨）

ラッパーについて

- デフォルトで `WRAPPER_SRC=./tailscale-wrapper.sh`、`WRAPPER_DEST=/usr/local/bin/tailscale`
- 既存ファイルがある場合は `FORCE_WRAPPER=1 make install-wrapper` で上書き
- ラッパーの中では `/Applications/Tailscale.app/Contents/MacOS/Tailscale` を呼ぶ想定

補足

- `make install` は CLI(formula) + GUI(App Store) の両方を入れます。GUI+ラッパー運用だけなら `install-cli` は実行不要です。
- `mas signin` や `mas account` は macOS 26(Tahoe) では動作しないため、サインインは App Store.app で事前に行ってください。
- `brew services` で tailscaled を常駐させることも可能です（例: `brew services start tailscale`）。必要に応じて使ってください。
