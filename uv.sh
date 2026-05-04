# install uv (if missing)
command -v uv >/dev/null || curl -LsSf https://astral.sh/uv/install.sh | sh

uv tool install harlequin
uv tool install sqlit-tui --with mssql-python
uv tool install mssql-cli

MSSQL_VENV_PYTHON="$HOME/.local/share/uv/tools/mssql-cli/bin/python"
grep -q "$MSSQL_VENV_PYTHON" "$HOME/.local/bin/mssql-cli" ||
    sed -i "s|^python -m|$MSSQL_VENV_PYTHON -m|" "$HOME/.local/bin/mssql-cli"
