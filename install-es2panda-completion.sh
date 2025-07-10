#!/bin/bash

COMPLETION_FILE="$HOME/.es2panda-completion.bash"
BASHRC="$HOME/.bashrc"

if [[ "$1" == "uninstall" ]]; then
    echo "[!] Kaldırma işlemi başlatılıyor..."

    # 1. .bashrc'den satırları kaldır
    sed -i '/es2panda-completion.bash/d' "$BASHRC"
    sed -i '/arkcompiler\/build\/bin/d' "$BASHRC"

    # 2. Tamamlama dosyasını sil
    if [ -f "$COMPLETION_FILE" ]; then
        rm "$COMPLETION_FILE"
        echo "[✓] $COMPLETION_FILE silindi."
    fi

    echo "[✓] .bashrc içinden kaldırıldı."
    echo "[i] Değişikliklerin aktif olması için 'source ~/.bashrc' çalıştır."
    exit 0
fi

# Kurulum
cp es2panda-completion.bash "$COMPLETION_FILE"

if ! grep -q "es2panda-completion.bash" "$BASHRC"; then
    echo 'source ~/.es2panda-completion.bash' >> "$BASHRC"
    echo 'export PATH="/home/hw-intern2/arkcompiler/build/bin:$PATH"' >> "$BASHRC"
    echo '[✓] Tamamlama ve PATH .bashrc dosyasına eklendi.'
else
    echo '[i] Zaten eklenmiş.'
fi

echo "[i] Değişikliklerin aktif olması için 'source ~/.bashrc' çalıştır."

