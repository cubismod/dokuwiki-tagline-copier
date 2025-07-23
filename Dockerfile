FROM python:3.13@sha256:ce366cb5da7dfd825e71ad9bbea1b6ccc889e090dff88fa7d3ade5b96f312ba5 AS main
COPY --from=ghcr.io/astral-sh/uv:0.7.20@sha256:2fd1b38e3398a256d6af3f71f0e2ba6a517b249998726a64d8cfbe55ab34af5e /uv /uvx /bin/

WORKDIR /app
ADD pyproject.toml uv.lock ./

RUN uv sync --frozen --no-cache

ADD . .

RUN uv sync --frozen --no-cache && uv lock --check
RUN uvx ruff check


CMD ["uv", "run", "main.py"]
