#!/usr/bin/env bash

set -e

REPO_URL="https://github.com/bobosii/bash-completion.git"
CLONE_DIR="$HOME/.es2panda-completion-tmp"

echo "🔍 Detecting your shell..."
USER_SHELL=$(basename "$SHELL")
echo "➡️ Shell detected: $USER_SHELL"

# Detect es2panda binary path
if [ -x "$HOME/arkcompiler/build/bin/es2panda" ]; then
    ES2PANDA_PATH="$HOME/arkcompiler/build/bin"
else
    echo "⚠️ Could not find es2panda binary in default location: $HOME/arkcompiler/build/bin"
    read -rp "🔧 Please enter the full path to the directory containing the 'es2panda' binary: " ES2PANDA_PATH
    if [ ! -x "$ES2PANDA_PATH/es2panda" ]; then
        echo "❌ 'es2panda' not found at $ES2PANDA_PATH. Exiting."
        exit 1
    fi
fi
echo "✅ es2panda found at: $ES2PANDA_PATH"

# Check for bash-completion
if ! command -v complete &> /dev/null; then
    echo "⚠️ bash-completion not found."
    read -rp "Do you want to install 'bash-completion'? [y/n]: " INSTALL_BC
    if [[ "$INSTALL_BC" == "y" || "$INSTALL_BC" == "Y" ]]; then
        sudo apt update
        sudo apt install bash-completion -y
    else
        echo "❌ bash-completion is required for Bash support. Exiting."
        exit 1
    fi
fi

# Check for yq
if ! command -v yq &> /dev/null; then
    echo "⚠️ 'yq' is required but not found."
    read -rp "Do you want to install 'yq'? [y/n]: " INSTALL_YQ
    if [[ "$INSTALL_YQ" == "y" || "$INSTALL_YQ" == "Y" ]]; then
        if command -v snap &> /dev/null; then
            echo "📦 Installing 'yq' via snap..."
            sudo snap install yq
        else
            echo "📦 Installing 'yq' via apt..."
            sudo apt update
            sudo apt install -y yq
        fi
    else
        echo "❌ 'yq' is required for completion scripts. Exiting."
        exit 1
    fi
fi


# Clone repo
echo "📥 Cloning completion script from repository..."
rm -rf "$CLONE_DIR"
git clone "$REPO_URL" "$CLONE_DIR"

### -------- Set file paths & destinations -------- ###
case "$USER_SHELL" in
  bash)
    ES2PANDA_FILE="$CLONE_DIR/bash/_es2panda"
    ES2PANDA_DEST="/usr/share/bash-completion/completions/_es2panda"
    ARK_FILE="$CLONE_DIR/bash/_ark"
    ARK_DEST="/usr/share/bash-completion/completions/_ark"
    ARK_DISASM_FILE="$CLONE_DIR/bash/_ark_disasm"
    ARK_DISASM_DEST="/usr/share/bash-completion/completions/_ark_disasm"
    ;;
  zsh)
    ES2PANDA_FILE="$CLONE_DIR/zsh/_es2panda"
    ES2PANDA_DEST="/usr/share/zsh/functions/Completion/Unix/_es2panda"
    ARK_FILE="$CLONE_DIR/zsh/_ark"
    ARK_DEST="/usr/share/zsh/functions/Completion/Unix/_ark"
    ARK_DISASM_FILE="$CLONE_DIR/zsh/_ark_disasm"
    ARK_DISASM_DEST="/usr/share/zsh/functions/Completion/Unix/_ark_disasm"
    ;;
  fish)
    if [ ! -d "$HOME/.config/fish/completions" ]; then
      mkdir -p "$HOME/.config/fish/completions"
    fi
    ES2PANDA_FILE="$CLONE_DIR/fish/es2panda.fish"
    ES2PANDA_DEST="$HOME/.config/fish/completions/es2panda.fish"
    ARK_FILE="$CLONE_DIR/fish/ark.fish"
    ARK_DEST="$HOME/.config/fish/completions/ark.fish"
    ARK_DISASM_FILE="$CLONE_DIR/fish/ark_disasm.fish"
    ARK_DISASM_DEST="$HOME/.config/fish/completions/ark_disasm.fish"
    ;;
  *)
    echo "❌ Unsupported shell: $USER_SHELL"
    exit 1
    ;;
esac

### -------- Install es2panda completion -------- ###
if [ -f "$ES2PANDA_FILE" ]; then
  YAML_PATH="$HOME/arkcompiler/ets_frontend/ets2panda/util/options.yaml"
  if [ -f "$YAML_PATH" ]; then
    sed -i "s|local yaml_file=.*|local yaml_file=\"$YAML_PATH\"|g" "$ES2PANDA_FILE"
  else
    echo "⚠️ Default es2panda options.yaml not found. Please update manually if needed."
  fi
  sudo cp "$ES2PANDA_FILE" "$ES2PANDA_DEST"
fi

### -------- Install ark completion -------- ###
if [ -f "$ARK_FILE" ]; then
  ARK_YAML="$HOME/arkcompiler/build/runtime_options_gen.yaml"
  if [ -f "$ARK_YAML" ]; then
    sed -i "s|local yaml_file=.*|local yaml_file=\"$ARK_YAML\"|g" "$ARK_FILE"
  else
    echo "⚠️ runtime_options_gen.yaml not found for ark. Please update manually if needed."
  fi
  sudo cp "$ARK_FILE" "$ARK_DEST"
fi

### -------- Install ark_disasm completion -------- ###
if [ -f "$ARK_DISASM_FILE" ]; then
  sudo cp "$ARK_DISASM_FILE" "$ARK_DISASM_DEST"
else
  echo "⚠️ ark_disasm completion script not found!"
fi

### -------- Add PATH if not exists -------- ###
echo "🔧 Updating PATH..."
EXPORT_LINE="export PATH=\"$ES2PANDA_PATH:\$PATH\""

case "$USER_SHELL" in
    bash) PROFILE="$HOME/.bashrc" ;;
    zsh)  PROFILE="$HOME/.zshrc" ;;
    fish)
        PROFILE="$HOME/.config/fish/config.fish"
        EXPORT_LINE="set -gx PATH $ES2PANDA_PATH \$PATH"
        ;;
esac

if ! grep -Fxq "$EXPORT_LINE" "$PROFILE"; then
    echo "$EXPORT_LINE" >> "$PROFILE"
    echo "✅ PATH updated in $PROFILE"
else
    echo "ℹ️ PATH already set in $PROFILE"
fi

echo "✅ All completions installed!"
echo "💡 Please restart your terminal or run:"
echo "source $PROFILE"

