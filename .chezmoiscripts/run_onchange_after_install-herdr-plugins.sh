#!/bin/bash

# Ensure herdr is installed before trying to install plugns.
if ! command -v herdr &>/dev/null; then
    echo "Herdr is not installed. Skipping plugin installation."
    exit 0
fi

echo "Installing/Updating Herdr plugins..."

herdr sync --lockfile "$HOME/.config/herdr/.plugins.lock"

herdr server reload-config
