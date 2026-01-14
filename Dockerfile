FROM ghcr.io/astral-sh/uv:python3.14-trixie

# コンテナ内の作業ディレクトリ
WORKDIR /app

# キャッシュを利用するために、まず依存関係ファイルだけをコピー
COPY pyproject.toml uv.lock ./

# uv を使用して依存関係をインストール
# --frozen: lockファイルとの乖離を許さない
# --mount=type=cache: ホストのキャッシュを利用して高速化
RUN --mount=type=cache,target=/root/.cache/uv \
  uv sync --frozen --no-install-project

# ノートブックなどのソースコードをコピー
COPY . .

# パスを通す（uv sync で作成された .venv/bin を優先）
ENV PATH="/app/.venv/bin:$PATH"

# Jupyter Lab を起動
# 0.0.0.0 でホストからのアクセスを許可
CMD ["uv", "run", "jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser", "--notebook-dir=/app/notebooks"]
