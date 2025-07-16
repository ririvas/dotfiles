# NVIM Configuration

Built with LazyVim.

## Plugins

### Roslyn

We use seblyng/roslyn.nvim for c# lsp. However, this is just a plugin to interface with roslyn.
Roslyn needs to be installed separately.

The plugin page has a guide for installing roslyn via custom mason repositories or manually.
The simplest method was to use the script in the custom mason repo, Crashdummyy/roslynLanguageServer.

```Bash
#!/bin/bash

if ! command -v unzip &> /dev/null
then
    echo "unzip is required. Please install it"
    exit 1
fi

rid="linux-x64"
targetDir="$HOME/.local/share/nvim/roslyn"
latestVersion=$(curl -s https://api.github.com/repos/Crashdummyy/roslynLanguageServer/releases | grep tag_name | head -1 | cut -d '"' -f4)

[[ -z "$latestVersion" ]] && echo "Failed to fetch the latest package information." && exit 1

echo "Latest version: $latestVersion"

asset=$(curl -s https://api.github.com/repos/Crashdummyy/roslynLanguageServer/releases | grep "releases/download/$latestVersion" | grep "$rid"| cut -d '"' -f 4)

echo "Downloading: $asset"

curl -Lo "./roslyn.zip" -k "$asset"

echo "Remove old installation"
rm -rf $targetDir/*

unzip "./roslyn.zip" -d "$targetDir/"
rm "./roslyn.zip"

```

```

```
