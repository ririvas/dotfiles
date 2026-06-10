# install uv (if missing)
command -v uv >/dev/null || curl -LsSf https://astral.sh/uv/install.sh | sh

uv tool install harlequin
uv tool install sqlit-tui --with mssql-python

uv python install 3.9 --native-tls
uv tool install mssql-cli --python 3.9
