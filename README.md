# es2panda Completion Scripts

> **Note:**
> These completion scripts are automatically generated using a custom Python script generator.
> If you are interested in how they are created or want to review/contribute to the generator, please visit:
> [https://github.com/bobosii/generate-script](https://github.com/bobosii/generate-script)

---

This repository provides advanced command-line completion scripts (Bash, Zsh, Fish) for the `es2panda`, `ark`, and `ark_disasm` commands.

---

## 🚀 Installation

1. **Clone this repository:**
    ```bash
    git clone https://github.com/bobosii/bash-completion.git
    cd bash-completion
    ```

2. **Run the installer script:**
    ```bash
    chmod +x setup-completion.sh
    ./setup-completion.sh
    --------------------------
        Or you can do this:
        bash setup-completion.sh
    ```

    - The script will automatically detect your shell (`bash`, `zsh`, or `fish`).
    - It will try to locate your `es2panda` binary or ask for its path.
    - If `bash-completion` is missing, it will offer to install it (for Bash only).
    - All completion scripts will be copied to the appropriate directories.
    - Your `PATH` will be updated if needed.

3. **Restart your terminal** (or follow the instructions at the end of the script) to activate the completions.

---

## 🖐️ Manual Installation

If you prefer, you can manually copy the completion scripts:

- **Bash:**
    ```bash
    sudo cp bash/_es2panda /usr/share/bash-completion/completions/_es2panda
    sudo cp bash/_ark /usr/share/bash-completion/completions/_ark
    sudo cp bash/_ark_disasm /usr/share/bash-completion/completions/_ark_disasm
    ```

- **Zsh:**
    ```bash
    sudo cp zsh/_es2panda /usr/share/zsh/functions/Completion/Unix/_es2panda
    sudo cp zsh/_ark /usr/share/zsh/functions/Completion/Unix/_ark
    sudo cp zsh/_ark_disasm /usr/share/zsh/functions/Completion/Unix/_ark_disasm
    ```

- **Fish:**
    ```bash
    mkdir -p ~/.config/fish/completions
    cp fish/es2panda.fish ~/.config/fish/completions/es2panda.fish
    cp fish/ark.fish ~/.config/fish/completions/ark.fish
    cp fish/ark_disasm.fish ~/.config/fish/completions/ark_disasm.fish
    ```

Don’t forget to add the directory containing `es2panda` to your `PATH` if it’s not already there.

---

## 💡 Notes

- TAB completion will work for `es2panda`, `ark`, and `ark_disasm` after installation.
- If you move the `es2panda` binary, re-run the installer or update your `PATH`.
- Tested on Ubuntu and macOS. Paths may vary on other systems.

---

