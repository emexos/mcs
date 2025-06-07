#!/usr/bin/env bash
set -e

REPO="emexos/mcs"
RAW_BASE="https://raw.githubusercontent.com/$REPO/main"
TMP_BIN="./mcs"
TARGET="/usr/local/bin/mcs"

confirm() {
  read -p "$1 [y/N] " yn
  case "$yn" in
    [Yy]*) return 0 ;;
    *) echo "[x] Aborted"; exit 1 ;;
  esac
}

echo "-======================================-"
echo " -> Install 'mcs' to $TARGET"
confirm "   Proceed with installation to $TARGET?"
confirm "   Are you absolutely sure this is the correct target directory?"

if command -v brew >/dev/null 2>&1; then
  MISSING_PACKAGES=()
  for pkg in mpv cjson; do
    if ! brew list "$pkg" >/dev/null 2>&1; then
      MISSING_PACKAGES+=("$pkg")
    fi
  done

  if [ "${#MISSING_PACKAGES[@]}" -gt 0 ]; then
    echo "-> Missing Homebrew package(s): ${MISSING_PACKAGES[*]}"
    if confirm "   Install now via Homebrew?"; then
      brew install "${MISSING_PACKAGES[@]}"
    else
      echo "[x] Please install: brew install ${MISSING_PACKAGES[*]}  and rerun."
      exit 1
    fi
  fi
else
  for bin in mpv; do
    if ! command -v "$bin" >/dev/null 2>&1; then
      echo "[x] Homebrew not found and '$bin' is missing."
      echo "    Please install Homebrew (https://brew.sh/) and then:"
      echo " -> brew install mpv cjson"
      exit 1
    fi
  done
fi

if [ -f "$TARGET" ]; then
  confirm "  'mcs' already exists at $TARGET. Overwrite?"
fi

curl -fsSL "$RAW_BASE/mcs" -o "$TMP_BIN"
if [ ! -f "$TMP_BIN" ]; then
  echo "-> Error: download failed."
  exit 1
fi

echo "----------------------"
echo " -> chmod +x $TMP_BIN..."
chmod +x "$TMP_BIN"
echo

echo "----------------------------------------"
echo " -> move $TMP_BIN to $TARGET..."
sudo mv "$TMP_BIN" "$TARGET"
echo

CONFIG_DIR="$HOME/.config/mcs"
CONFIG_FILE="$CONFIG_DIR/songs.json"

if [ ! -f "$CONFIG_FILE" ]; then
  echo "-> Creating default config at $CONFIG_FILE"
  mkdir -p "$CONFIG_DIR"
  cat > "$CONFIG_FILE" << 'EOF'
{
  "rick": "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
}
EOF
fi

echo " -> Finish - start the program with \"mcs\""
