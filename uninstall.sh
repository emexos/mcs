#!/usr/bin/env bash
set -e

REPO="emexos/mcs"
TARGET="/usr/local/bin/mcs"
CONFIG_DIR="$HOME/.config/mcs"

confirm() {
  read -p "$1 [y/N] " yn
  case "$yn" in
    [Yy]*) return 0 ;;
    *) echo "[x] Aborted"; exit 1 ;;
  esac
}

echo "-========================================-"
echo " -> Uninstall 'mcs' from $TARGET"
confirm "   Proceed with uninstallation?"

if [ -f "$TARGET" ]; then
  sudo rm "$TARGET"
  echo " -> Removed $TARGET"
else
  echo "[!] $TARGET not found"
fi

if [ -d "$CONFIG_DIR" ]; then
  confirm "   Remove configuration directory at $CONFIG_DIR?"
  rm -rf "$CONFIG_DIR"
  echo " -> Removed $CONFIG_DIR"
else
  echo "[!] Configuration directory not found at $CONFIG_DIR"
fi

echo " -> Uninstall complete"
