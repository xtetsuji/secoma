# -*- makefile -*-

APK_URL = https://my-batteries.oss-ap-southeast-1.aliyuncs.com/AllMyBatteriesHelper.apk
APK_FILE = AllMyBatteriesHelper.apk

usage:
	@echo "Usage:"
	@echo "  make AllMyBatteriesHelper.apk  # APKファイルをダウンロードする"
	@echo "  make install                   # adbを使ってAPKファイルをインストールする"

AllMyBatteriesHelper.apk:
	wget $(APK_URL)

# adb install を使って apk ファイルをインストール
# -r オプションは既存のアプリケーションを保持しながら新しいバージョンを再インストールするためのもの
install: $(APK_FILE)
	adb install -r $(APK_FILE)

# adb オプション参考
# https://qiita.com/t2low/items/cb37cec5f864c4748e14

# 接続については android-mirroring/Makefile に色々書いたのでそちらを参照
