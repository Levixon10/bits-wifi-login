#!/usr/bin/env bash
# Installs the script and the systemd user service, then starts it.
set -e
cd "$(dirname "$0")"
install -Dm755 bits-wifi-login "$HOME/.local/bin/bits-wifi-login"
install -Dm644 bits-wifi-login.service "$HOME/.config/systemd/user/bits-wifi-login.service"
systemctl --user daemon-reload
systemctl --user enable --now bits-wifi-login.service
echo "Installed. Now run: bits-wifi-login setup"
