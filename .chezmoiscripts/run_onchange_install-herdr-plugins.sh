#!/bin/bash

# Ensure herdr is installed before trying to install plugns.
if ! command -v herdr &>/dev/null; then
    echo "Herdr is not installed. Skipping plugin installation."
    exit 0
fi

echo "Installing/Updating Herdr plugins..."

PLUGINS=(
    "jeffarese/herdr-bar"
    "ChmaraX/herdr-nvim"
)

for plugin in "${PLUGINS[@]}"; do
    herdr plugin install "$plugin" --yes
done

herdr server reload-config
