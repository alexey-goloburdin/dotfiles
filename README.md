My dot files for `~/.config` directory — nvim, tmux, alacritty etc.

Install:

```bash
sudo apt install -y git curl wget tmux gcc ripgrep fzf build-essential

# Alacritty themes
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# zsh settings
echo "source \$HOME/.config/zsh/env.zsh" >> ~/.zshrc
echo "source \$HOME/.config/zsh/aliases.zsh" >> ~/.zshrc

# Install nodejs and pyright LSP server for Python
# https://nodejs.org/en/download/package-manager
# choose linux and nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
nvm install 23
node -v
npm -v

npm i -g npm
npm i -g pyright

# Install typescript LSP server
npm install -g typescript-language-server typescript

# Packer for nvim
mkdir -p ~/.local/share/nvim/site/pack/packer/start/

git clone --depth 1 https://github.com/wbthomason/packer.nvim \
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Build telescope for nvim
cd ~/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim
make
```
