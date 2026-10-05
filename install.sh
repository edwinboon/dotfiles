#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Dotfiles: $DOTFILES_DIR"

if [ "$(uname -s)" != "Darwin" ]; then
  echo "This script targets macOS only." >&2
  exit 1
fi

# Links $1 to $2, moving any real file/dir at $2 aside first. -n stops ln from
# descending into $2 when it is already a symlink to a directory.
link() {
  local src="$1" dst="$2"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    local backup
    backup="$dst.bak.$(date +%Y%m%d%H%M%S)"
    echo "  Backing up $dst -> $backup"
    mv "$dst" "$backup"
  fi

  ln -sfn "$src" "$dst"
  echo "  Linked $dst -> $src"
}

# ---- Homebrew ----
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

# Homebrew refuses to load formulae from third-party taps until they are
# trusted. Trust exactly the taps this Brewfile declares, nothing else.
if brew trust --help &>/dev/null; then
  grep -E '^tap "' "$DOTFILES_DIR/Brewfile" | cut -d'"' -f2 | while read -r tap; do
    brew tap "$tap"
    brew trust --tap "$tap"
  done
fi

echo "==> Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ---- NVM / Bun ----
# Both installers append to ~/.zshrc by default, which is a symlink into this
# repo. Stop them from doing so; the tracked .zshrc already loads both.
if [ ! -d "$HOME/.nvm" ]; then
  echo "==> Installing NVM..."
  curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | PROFILE=/dev/null bash
fi

if [ ! -x "$HOME/.bun/bin/bun" ] && ! command -v bun &>/dev/null; then
  echo "==> Installing Bun..."
  # SHELL=sh makes the installer print instructions instead of editing rc files.
  curl -fsSL https://bun.sh/install | SHELL=/bin/sh bash
fi

# ---- TPM (Tmux Plugin Manager) ----
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "==> Installing TPM..."
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# ---- Git identity ----
# Read before ~/.gitconfig is replaced, so an existing identity carries over.
if [ ! -f "$HOME/.gitconfig.local" ]; then
  git_name="$(git config --global user.name || true)"
  git_email="$(git config --global user.email || true)"

  if [ -n "$git_name" ] && [ -n "$git_email" ]; then
    echo "==> Creating ~/.gitconfig.local with your current git identity..."
    printf '[user]\n\tname = %s\n\temail = %s\n' "$git_name" "$git_email" >"$HOME/.gitconfig.local"
  else
    echo "==> Creating ~/.gitconfig.local from example..."
    cp "$DOTFILES_DIR/home/.gitconfig.local.example" "$HOME/.gitconfig.local"
    echo "  !! Fill in your name and email in ~/.gitconfig.local"
  fi
fi

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
  link "$DOTFILES_DIR/home/$file" "$HOME/$file"
done

# ---- Symlinks: .config ----
echo "==> Creating symlinks for .config..."

mkdir -p "$HOME/.config"
CONFIG_DIRS=(nvim)

for dir in "${CONFIG_DIRS[@]}"; do
  link "$DOTFILES_DIR/config/$dir" "$HOME/.config/$dir"
done

# ---- Secrets file ----
if [ ! -f "$HOME/.zshrc.secrets" ]; then
  echo "==> Creating ~/.zshrc.secrets from example..."
  cp "$DOTFILES_DIR/home/.zshrc.secrets.example" "$HOME/.zshrc.secrets"
  chmod 600 "$HOME/.zshrc.secrets"
  echo "  !! Don't forget to fill in your secrets in ~/.zshrc.secrets"
fi

# ---- Desktop wallpaper ----
# Opt out with SKIP_WALLPAPER=1 ./install.sh
WALLPAPER="$DOTFILES_DIR/assets/wallpaper.jpg"
if [ -z "${SKIP_WALLPAPER:-}" ] && [ -f "$WALLPAPER" ]; then
  echo "==> Setting desktop wallpaper..."
  if osascript -e "tell application \"Finder\" to set desktop picture to POSIX file \"$WALLPAPER\""; then
    echo "  Wallpaper set to $WALLPAPER"
  else
    echo "  Warning: Failed to set desktop wallpaper via osascript" >&2
  fi
fi

echo ""
echo "Done! Open a new terminal or run: source ~/.zshrc"
echo "In tmux, press prefix (Ctrl+Space) + I to install tmux plugins."
