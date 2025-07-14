# es2panda-completion Installation

## 1.Bash
⚠️ Note: By default, the arkcompiler directory is assumed to be located at $HOME/arkcompiler.
If your installation and build files is in a different location, make sure to replace the paths in the script and instructions with your actual directory.
### 1.1. Clone the repository

```bash
https://gitee.com/nurullahahmetarikan/bash-completion.git
cd bash-completion/bash
```
### 1.2. Update the path in the completion script
Open the file es2panda-completion.sh and find this line:
```bash
local yaml_file="/home/your-pc-name/arkcompiler/ets_frontend/ets2panda/util/options.yaml"
```
Change the path to your PC username and correct directory.

### 1.3. Copy the completion script to bash completion directory
```bash
sudo cp es2panda-completion.sh /usr/share/bash-completion/completions/es2panda
```

### 1.4 Add es2panda to your PATH
Add this line to your ~/.bashrc or ~/.bash_profile:
```bash
export PATH="/home/your-pc-name/arkcompiler/build/bin:$PATH"
```
### 1.5 Reload shell configuration
```bash
source ~/.bashrc
```
Or restart your terminal.
