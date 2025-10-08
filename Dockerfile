FROM python:3.13@sha256:322065eea3a904d6d35050a44c1e52650c5a98a060ee115714a17b7bba130582 AS main
COPY --from=ghcr.io/astral-sh/uv:0.8.23@sha256:94390f20a83e2de83f63b2dadcca2efab2e6798f772edab52bf545696c86bdb4 /uv /uvx /bin/

WORKDIR /app
ADD pyproject.toml uv.lock ./

RUN uv sync --frozen --no-cache

ADD . .

RUN uv sync --frozen --no-cache && uv lock --check
RUN uvx ruff check


CMD ["uv", "run", "main.py"]
