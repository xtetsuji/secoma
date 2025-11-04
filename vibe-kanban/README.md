# vibe-kanban

Vibe Kanban の起動を簡単にするための Makefile です。

## 使い方

```sh
make usage
```
サポートしているターゲットの一覧を表示します。

```sh
make run-local
```
ローカルホスト (127.0.0.1) でアプリケーションを起動します。バックエンドは既定でポート 7777 を利用します。

```sh
make run-fullopen
```
全てのインターフェース (0.0.0.0) でアプリケーションを起動します。バックエンドは既定でポート 7777 を利用します。

```sh
make run-local VK_BACKEND_PORT=8888
```
環境変数 `VK_BACKEND_PORT` を上書きしてポート番号を変更できます。`run-fullopen` も同様に指定可能です。
