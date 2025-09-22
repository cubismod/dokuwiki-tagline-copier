FROM python:3.13@sha256:2deb0891ec3f643b1d342f04cc22154e6b6a76b41044791b537093fae00b6884 AS main
COPY --from=ghcr.io/astral-sh/uv:0.8.19@sha256:0ca07117081b2c6a8dd813d2badacf76dceecaf8b8a41d51b5d715024ffef7d8 /uv /uvx /bin/

WORKDIR /app
ADD pyproject.toml uv.lock ./

RUN uv sync --frozen --no-cache

ADD . .

RUN uv sync --frozen --no-cache && uv lock --check
RUN uvx ruff check


CMD ["uv", "run", "main.py"]
