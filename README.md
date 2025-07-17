# Bash Completion Scripts

This repository provides shell completion scripts for the following CLI tools used in the ArkCompiler project:

* `es2panda`
* `ark`
* `ark_disasm`

These completions offer:

* Dynamic suggestions for main and sub-options using `yq` to parse `yaml` files.
* Support for Bash, Zsh, and Fish shells.
* Intelligent completion of file paths (e.g., for `--debug-file:<path>`).

## 📊 Supported Shells

* ✅ Bash
* ✅ Zsh
* ✅ Fish

---

## ⚙️ Automatic Installation (Recommended)

First, clone this repository:

```bash
git clone https://github.com/bobosii/bash-completion.git
cd bash-completion
```

Then run the provided installation script:

```bash
chmod +x install.sh
./install.sh
```

This will:

* Detect your current shell.
* Copy the appropriate completion files to standard system/user paths.
* Patch hardcoded YAML paths based on your environment.
* Add `es2panda` to your shell’s `PATH`.

Once complete, restart your terminal or run the appropriate source command:

* Bash: `source ~/.bashrc`
* Zsh: `source ~/.zshrc`
* Fish: `source ~/.config/fish/config.fish`

---

## 🛠️ Manual Installation

### ⚠️ Default assumptions

The script assumes that:

* Your ArkCompiler build is located in: `$HOME/arkcompiler/build/bin/es2panda`
* Your YAML option files are at:

  * `$HOME/arkcompiler/ets_frontend/ets2panda/util/options.yaml` (for es2panda)
  * `$HOME/arkcompiler/build/runtime_options_gen.yaml` (for ark)

If not, you'll need to manually edit the paths in the completion files.

---

### 1. Bash

1. Copy the completion script:

```bash
sudo cp bash/_es2panda /usr/share/bash-completion/completions/es2panda
sudo cp bash/_ark /usr/share/bash-completion/completions/ark
sudo cp bash/_ark_disasm /usr/share/bash-completion/completions/ark_disasm
```

2. Make sure `bash-completion` is installed:

```bash
sudo apt install bash-completion
```

3. Add this line to your `~/.bashrc` if `es2panda` is not already in `PATH`:

```bash
export PATH="$HOME/arkcompiler/build/bin:$PATH"
```

4. Reload your shell:

```bash
source ~/.bashrc
```

---

### 2. Zsh

1. Copy the scripts:

```bash
sudo cp zsh/_es2panda /usr/share/zsh/functions/Completion/Unix/
sudo cp zsh/_ark /usr/share/zsh/functions/Completion/Unix/
sudo cp zsh/_ark_disasm /usr/share/zsh/functions/Completion/Unix/
```

2. Make sure you have this in your `~/.zshrc`:

```zsh
autoload -Uz compinit
compinit
```

3. Add `es2panda` to your path if needed:

```zsh
export PATH="$HOME/arkcompiler/build/bin:$PATH"
```

4. Reload Zsh:

```zsh
source ~/.zshrc
```

---

### 3. Fish

1. Copy the scripts:

```bash
mkdir -p ~/.config/fish/completions
cp fish/es2panda.fish ~/.config/fish/completions/es2panda.fish
cp fish/ark.fish ~/.config/fish/completions/ark.fish
cp fish/ark_disasm.fish ~/.config/fish/completions/ark_disasm.fish
```

2. Add to your `config.fish`:

```fish
set -gx PATH $HOME/arkcompiler/build/bin $PATH
```

3. Reload Fish:

```fish
source ~/.config/fish/config.fish
```

---

## 🧰 Dependencies

Make sure you have [`yq`](https://github.com/mikefarah/yq) installed, as the completions use it to dynamically parse YAML files.

Install it via:

```bash
sudo snap install yq

---

## 🥺 Testing Locally

To test a completion script locally without installing globally, source it manually:
(Before testing locally please give file extensions.)

* For Bash:

  ```bash
  source bash/_es2panda
  ```

* For Zsh:

  ```zsh
  fpath=(./zsh $fpath)
  autoload -Uz _es2panda
  compinit
  ```

* For Fish:

  ```fish
  source fish/es2panda.fish
  ```

