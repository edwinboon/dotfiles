# dotfiles

Edwin's macOS dotfiles. Clone and run `install.sh` on a new machine.

## Installation

```bash
git clone https://github.com/edwinboon/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

This will:
- Install Homebrew (if not present)
- Install all packages from `Brewfile` via `brew bundle`
- Create symlinks for all dotfiles in `~/` and `~/.config/`
- Install NVM (if not present)
- Install Bun (if not present)
- Install TPM — Tmux Plugin Manager (if not present)
- Create `~/.zshrc.secrets` from the example file

## Secrets

Tokens and sensitive variables are **not** tracked in this repo. After installation, fill in your values in `~/.zshrc.secrets`:

```bash
nano ~/.zshrc.secrets
```

## Structure

```
dotfiles/
├── install.sh                  # bootstrap script
├── Brewfile                    # homebrew packages
├── home/
│   ├── .zshrc                  # shell config (without secrets)
│   ├── .zshrc.secrets.example  # secrets template
│   ├── .gitconfig
│   ├── .tmux.conf
│   ├── .wezterm.lua
│   └── .p10k.zsh
└── config/
    └── nvim/                   # neovim config
```

## Updating the Brewfile

After installing new tools:

```bash
brew bundle dump --file=Brewfile --force
```
