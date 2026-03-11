# dotfiles

Edwin's macOS dotfiles. Clone en run `install.sh` op een nieuwe laptop.

## Installatie

```bash
git clone https://github.com/edwinboon/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Dit doet:
- Homebrew installeren (als het er nog niet is)
- Alle packages uit `Brewfile` installeren via `brew bundle`
- Symlinks aanmaken voor alle dotfiles in `~/` en `~/.config/`
- NVM installeren (als het er nog niet is)
- Bun installeren (als het er nog niet is)
- `~/.zshrc.secrets` aanmaken vanuit het example bestand

## Secrets

Tokens en gevoelige variabelen staan **niet** in deze repo. Na installatie vind je `~/.zshrc.secrets` — vul daar je eigen waarden in:

```bash
nano ~/.zshrc.secrets
```

## Structuur

```
dotfiles/
├── install.sh                  # bootstrap script
├── Brewfile                    # homebrew packages
├── home/
│   ├── .zshrc                  # shell config (zonder secrets)
│   ├── .zshrc.secrets.example  # template voor secrets
│   ├── .gitconfig
│   ├── .tmux.conf
│   ├── .wezterm.lua
│   └── .p10k.zsh
└── config/
    └── nvim/                   # neovim config
```

## Brewfile bijwerken

Na het installeren van nieuwe tools:

```bash
brew bundle dump --file=Brewfile --force
```
