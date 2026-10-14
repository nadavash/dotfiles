#!/bin/bash

# Ensure herdr is installed before trying to install plugns.
if ! command -v herdr &>/dev/null; then
    echo "Herdr is not installed. Skipping plugin installation."
    exit 1
fi

echo "Installing/Updating Herdr plugins..."

herdr plugin install jeffarese/herdr-bar --yes
herdr plugin install ChmaraX/herdr-nvim --yes

herdr server reload-config
