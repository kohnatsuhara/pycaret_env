# Docker env for PYCARET

## dockerのバージョン
- Docker version 24.0.2, build cb74dfc
- Docker Compose version v2.18.1
    - Docker Composeはv2.0.0以上を利用してください

## Docker内使用環境
- 使用イメージ：jupyter/base-notebook:latest
    - latestタグはビルドタイミングの最新のバージョンを持ってくる
    - ビルドタイミングによってバージョンがずれるかも
- pythonバージョン
    - 3.8
- pycaretバージョン
    - pycaret[full]==3.1.0

## 利用方法
1. 当リポジトリをクローン
2. クローンしたローカルリポジトリにターミナルでアクセス
3. 下記コマンドにて、dockerイメージのビルド＆コンテナの立ち上げ
    - `docker compose up -d --build`
    - コンテナの立ち上げのみ（初回以降）は`docker compose up -d`
4. 3.で立ち上げ後下記コマンドにてコンテナの状態確認
    - `docker compose ps -a`
5. 立ち上がっているのを確認したらブラウザで下記URLにアクセス
    - `localhost:8888`
    - jupyter labが立ち上がります。
6. 下記コマンドにてコンテナを終了
    - `docker compose down`

## 備考
- ローカルリポジトリ内(以降、ホストと呼ぶ)のディレクトリ`./workspace`とコンテナ内の`/home/jovyan/workspace`をマウントしています。
- 利用方法6.でコンテナを終了すると、コンテナは削除されますが上記のマウントにより`/workspace`内のファイルはホスト側に残ります。
- コンテナを終了後にコンテナを立ち上げなおすと、コンテナ内の`/workspace`は再度マウントされホスト側に残ったファイルに再度アクセスできます。
- 上記理由からコンテナ内でのファイル出力は`/home/jovyan/workspace`以下のパスを指定してください。
