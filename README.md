# Dotfiles

My personal dotfiles for macOS setup with automated installation.

## What's Included

- **Shell**: Zsh configuration (`.zshrc`)
- **Editor**: Neovim configuration
- **Terminal Multiplexer**: Tmux configuration (`.tmux.conf`)
- **Terminal Emulator**: WezTerm configuration
- **SSH**: SSH configuration
- **Wallpaper**: Custom background wallpaper
- **Installation Script**: Automated setup script that installs Homebrew and all dependencies

## Quick Start

```bash
# Clone the repository
git clone https://github.com/edwinboon/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Run the installation script
./install.sh
```

## What the Install Script Does

1. Installs Homebrew (if not already installed)
2. Installs essential packages via Homebrew
3. Installs applications via Homebrew Cask
4. Creates symlinks for all configuration files
5. Sets up Neovim
6. Applies wallpaper

## Manual Setup

If you prefer to set things up manually:

```bash
# Create symlinks
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/.ssh/config ~/.ssh/config
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/dotfiles/.config/wezterm ~/.config/wezterm

# Set wallpaper
cp ~/dotfiles/wallpaper.jpg ~/Pictures/wallpaper.jpg
```

## Customization

Feel free to modify any configuration files to suit your needs:

- **Shell**: Edit `.zshrc` for shell customizations
- **Neovim**: Edit `.config/nvim/init.lua` for editor settings
- **Tmux**: Edit `.tmux.conf` for tmux settings
- **WezTerm**: Edit `.config/wezterm/wezterm.lua` for terminal settings

## Updating

To update your dotfiles:

```bash
cd ~/dotfiles
git pull
./install.sh
```

## Requirements

- macOS (tested on recent versions)
- Git (for cloning the repository)
- Internet connection (for installing packages)

## License

MIT License - Feel free to use and modify as needed.