# install uv (if missing)
command -v uv >/dev/null || curl -LsSf https://astral.sh/uv/install.sh | sh

uv tool install harlequin
uv tool install sqlit-tui --with mssql-python
