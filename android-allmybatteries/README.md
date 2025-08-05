# All My Batteries Helper

iOS/iPadOS/macOS 向けバッテリー管理アプリ「All My Batteries」から Android デバイスのバッテリー情報を取得するためのヘルパーアプリのインストールツールです。

## 概要

All My Batteries は Apple 系デバイス（iOS/iPadOS/macOS）向けのバッテリー管理アプリケーションです。All My Batteries Helper は、Apple デバイス上の All My Batteries アプリが Android デバイスのバッテリー残量や充電状態を監視できるようにするための Android 向けヘルパーアプリケーションです。

このプロジェクトでは、Android ヘルパーアプリ（APK）のダウンロードとインストールを自動化するMakefileを提供しています。

## 必要な環境

- Android Debug Bridge (adb) コマンド
- wget コマンド
- Androidデバイスまたはエミュレーター（USB デバッグが有効）

## 使用方法

### APKファイルのダウンロード

```bash
make AllMyBatteriesHelper.apk
```

### アプリのインストール

```bash
make install
```

このコマンドは以下の処理を行います：
1. APKファイルが存在しない場合は自動でダウンロード
2. `adb install -r` コマンドでアプリをインストール（既存アプリがある場合は再インストール）

### 使用方法の確認

```bash
make usage
```

## 注意事項

- Androidデバイスの「開発者向けオプション」で「USBデバッグ」を有効にしてください
- 初回インストール時はデバイス側で「不明なアプリのインストール」を許可する必要がある場合があります
- Android端末の接続方法については `../android-mirroring/Makefile` を参照してください

## APK情報

- ダウンロード元: https://my-batteries.oss-ap-southeast-1.aliyuncs.com/AllMyBatteriesHelper.apk
- このヘルパーアプリは Apple デバイス上の All My Batteries アプリと連携して動作します
- APKファイルは動的にダウンロードされるため、リポジトリには含まれていません

## 動作の仕組み

1. Android デバイスに All My Batteries Helper をインストール
2. Apple デバイス（iPhone/iPad/Mac）で All My Batteries アプリを起動
3. All My Batteries アプリが同一ネットワーク上の Android デバイスを検出
4. Android デバイスのバッテリー情報を Apple デバイス上で監視可能

## 参考資料

- [adbコマンドのオプション参考](https://qiita.com/t2low/items/cb37cec5f864c4748e14)
- [All My Batteries アプリ](https://apps.apple.com/jp/app/allmybatteries/id1621263412)
