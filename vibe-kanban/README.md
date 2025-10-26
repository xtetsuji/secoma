# vibe-kanban

Vibe Kanban の起動を簡単にするための Makefile です。

## 使い方

```sh
make run-local
```
ローカルホスト (127.0.0.1) でアプリケーションを起動します。

```sh
make run-fullopen
```
全てのインターフェース (0.0.0.0) でアプリケーションを起動します。

```sh
make run-local VK_BACKEND_PORT=8888
```

ポート番号を変更してアプリケーションを起動します。
