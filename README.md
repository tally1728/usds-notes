# usds-notes

「かめ@米国データサイエンティスト」さんによる講座のノート

Python入門講座のノート → [データサイエンスのためのPython入門講座（かめ@米国データサイエンティスト）のノート | ゼータへの旅路 / Journey to Zeta](https://zeta.ws/python/usds-python/)

## プロジェクトの構成

- Docker Compose + uv
- Python 3.14 (w/ GIL)
- JupyterLab 4.5
- ライブラリ
  - NumPy 2.4
  - pandas 3.0
  - matplotlib 3.10
  - Seaborn 0.13
  - OpenCV 4.13

Dockerを使っていますが、ローカルにuvがインストールされている場合は、uv単体でも動きます。macOSなどLinux以外では、uv単体の方がメモリ消費が節約できると思います。

LinuxでDocker（実際にはcontainerd+nerdctl）を、またmacOSでuvを利用して、動作確認済です。

## 使い方

### Dockerの場合

JupyterLab を起動
`$ docker compose up`

シェル環境へ
`$ docker compose exec jupyter bash`

### uv単体の場合

ライブラリのインストール
`$ uv sync --frozen`

JupyterLabを開始
`$ uv run jupyter lab --notebook-dir=notebooks`
