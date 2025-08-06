# ベースイメージとして Ubuntu 22.04 を使用
FROM ubuntu:22.04

# 必要なパッケージをインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       python3-pip \
       ffmpeg \
       make \
       curl \
    && rm -rf /var/lib/apt/lists/* \
    # yt-dlp を pip3 でインストール
    && pip3 install yt-dlp

# 作業ディレクトリをルートに設定
WORKDIR /

# ダウンロード用ディレクトリを作成
RUN mkdir -p /downloads

# ボリュームマウントポイントを宣言
VOLUME ["/downloads"]

# ホストの docker.make をコンテナの Makefile としてコピー
COPY docker.make ./Makefile

# デフォルトコマンドは make (デフォルトターゲット: usage)
ENTRYPOINT ["make"]
