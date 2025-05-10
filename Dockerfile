FROM python:3.13@sha256:3abe339a3bc81ffabcecf9393445594124de6420b3cfddf248c52b1115218f04 AS main
COPY --from=ghcr.io/astral-sh/uv:0.6.17@sha256:4a6c9444b126bd325fba904bff796bf91fb777bf6148d60109c4cb1de2ffc497 /uv /uvx /bin/

WORKDIR /app
ADD pyproject.toml uv.lock ./

RUN uv sync --frozen --no-cache

ADD . .

RUN uv sync --frozen --no-cache && uv lock --check
RUN uvx ruff check


CMD ["uv", "run", "main.py"]
