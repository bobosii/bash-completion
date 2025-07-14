#!/usr/bin/env bash

set -e

REPO_URL="https://gitee.com/nurullahahmetarikan/bash-completion.git"
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

# Clone repo
echo "📥 Cloning completion script from repository..."
rm -rf "$CLONE_DIR"
git clone "$REPO_URL" "$CLONE_DIR"

### -------- Install es2panda completion -------- ###
echo "📂 Installing es2panda completion script..."

if [ "$USER_SHELL" = "bash" ]; then
    FILE="$CLONE_DIR/bash/es2panda-completion.sh"
    DEST="/usr/share/bash-completion/completions/_es2panda"
elif [ "$USER_SHELL" = "zsh" ]; then
    FILE="$CLONE_DIR/zsh/_es2panda"
    DEST="/usr/share/functions/Completion/Unix/_es2panda"
elif [ "$USER_SHELL" = "fish" ]; then
    FILE="$CLONE_DIR/bash/es2panda-completion.sh"
    mkdir -p ~/.config/fish/completions
    DEST="$HOME/.config/fish/completions/es2panda.fish"
else
    echo "❌ Unsupported shell: $USER_SHELL"
    exit 1
fi

# Update YAML path in es2panda file
YAML_PATH="$HOME/arkcompiler/ets_frontend/ets2panda/util/options.yaml"
if [ -f "$YAML_PATH" ]; then
    sed -i "s|local yaml_file=.*|local yaml_file=\"$YAML_PATH\"|g" "$FILE"
else
    echo "⚠️ Default es2panda options.yaml not found. Please update manually if needed."
fi

sudo cp "$FILE" "$DEST"

### -------- Install ark completion -------- ###
echo "📂 Installing ark completion script..."

if [ "$USER_SHELL" = "bash" ]; then
    FILE="$CLONE_DIR/bash/ark-completion.sh"
    DEST="/usr/share/bash-completion/completions/_ark"
elif [ "$USER_SHELL" = "zsh" ]; then
    FILE="$CLONE_DIR/zsh/_ark"
    DEST="/usr/share/functions/Completion/Unix/_ark"
fi

# Update YAML path
ARK_YAML="$HOME/arkcompiler/build/runtime_options_gen.yaml"
if [ -f "$ARK_YAML" ]; then
    sed -i "s|local yaml_file=.*|local yaml_file=\"$ARK_YAML\"|g" "$FILE"
else
    echo "⚠️ runtime_options_gen.yaml not found for ark. Please update manually if needed."
fi

sudo cp "$FILE" "$DEST"

### -------- Install ark_disasm completion -------- ###
echo "📂 Installing ark_disasm completion script..."

if [ "$USER_SHELL" = "bash" ]; then
    FILE="$CLONE_DIR/bash/ark_disasm_completion.sh"
    DEST="/usr/share/bash-completion/completions/_ark_disasm"
elif [ "$USER_SHELL" = "zsh" ]; then
    FILE="$CLONE_DIR/zsh/_ark_disasm"
    DEST="/usr/share/functions/Completion/Unix/_ark_disasm"
fi

if [ -f "$FILE" ]; then
    sudo cp "$FILE" "$DEST"
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

