#!/usr/bin/env bash
set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Dotfiles: $DOTFILES_DIR"

# ---- Homebrew ----
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "==> Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ---- Symlinks: home dotfiles ----
echo "==> Creating symlinks for home dotfiles..."

HOME_FILES=(
  .zshrc
  .gitconfig
  .tmux.conf
  .wezterm.lua
  .p10k.zsh
)

for file in "${HOME_FILES[@]}"; do
  src="$DOTFILES_DIR/home/$file"
  dst="$HOME/$file"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  Backing up $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi

  ln -sf "$src" "$dst"
  echo "  Linked $dst -> $src"
done

# ---- Symlinks: .config ----
echo "==> Creating symlinks for .config..."

CONFIG_DIRS=(nvim)

for dir in "${CONFIG_DIRS[@]}"; do
  src="$DOTFILES_DIR/config/$dir"
  dst="$HOME/.config/$dir"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    echo "  Backing up $dst -> $dst.bak"
    mv "$dst" "$dst.bak"
  fi

  ln -sf "$src" "$dst"
  echo "  Linked $dst -> $src"
done

# ---- NVM ----
if [ ! -d "$HOME/.nvm" ]; then
  echo "==> Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
fi

# ---- Bun ----
if ! command -v bun &>/dev/null; then
  echo "==> Installing Bun..."
  curl -fsSL https://bun.sh/install | bash
fi

# ---- TPM (Tmux Plugin Manager) ----
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "==> Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# ---- Secrets file ----
if [ ! -f "$HOME/.zshrc.secrets" ]; then
  echo "==> Creating ~/.zshrc.secrets from example..."
  cp "$DOTFILES_DIR/home/.zshrc.secrets.example" "$HOME/.zshrc.secrets"
  echo "  !! Don't forget to fill in your secrets in ~/.zshrc.secrets"
fi

# ---- Desktop wallpaper ----
WALLPAPER="$DOTFILES_DIR/assets/wallpaper.jpg"
if [ -f "$WALLPAPER" ]; then
  echo "==> Setting desktop wallpaper..."
  osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$WALLPAPER\""
  echo "  Wallpaper set to $WALLPAPER"
fi

echo ""
echo "Done! Open a new terminal or run: source ~/.zshrc"
