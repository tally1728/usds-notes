FROM ubuntu:25.10

# パッケージリスト更新とアップグレードをセットで実行
RUN apt-get update && apt-get upgrade -y \
  && apt-get install -y --no-install-recommends \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# コンテナ内の作業ディレクトリ
WORKDIR /app

# Install Python
# --mount=type=cache: ホストのキャッシュを利用して高速化
ENV UV_PYTHON_CACHE_DIR=/root/.cache/uv/python
RUN --mount=type=cache,target=/root/.cache/uv \
  --mount=type=bind,source=.python-version,target=.python-version \
  uv python install

# 依存関係をインストール
# --locked: lockファイルを変更しない
# --no-install-project: only dependencies
ENV UV_LINK_MODE=copy
RUN --mount=type=cache,target=/root/.cache/uv \
  --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
  --mount=type=bind,source=.python-version,target=.python-version \
  --mount=type=bind,source=uv.lock,target=uv.lock \
  uv sync --locked --no-install-project

# ノートブックなどのソースコードをコピー
COPY . .

# Sync the project
RUN --mount=type=cache,target=/root/.cache/uv \
  uv sync --locked

# パスを通す（uv sync で作成された .venv/bin を優先）
ENV PATH="/app/.venv/bin:$PATH"

# Jupyter Lab を起動
# 0.0.0.0 でホストからのアクセスを許可
CMD ["uv", "run", "jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--notebook-dir=/app/notebooks"]
