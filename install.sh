#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}=== Dotfiles Installation Script ===${NC}"
echo ""

# Get the directory where the script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if running on macOS
if [[ "$OSTYPE" != "darwin*" ]]; then
    echo -e "${RED}Error: This script is designed for macOS${NC}"
    exit 1
fi

# Install Homebrew if not already installed
echo -e "${YELLOW}Checking for Homebrew...${NC}"
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Installing Homebrew...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo -e "${GREEN}Homebrew already installed${NC}"
fi

# Update Homebrew
echo -e "${YELLOW}Updating Homebrew...${NC}"
brew update

# Install essential packages
echo -e "${YELLOW}Installing essential packages...${NC}"
brew install git
brew install neovim
brew install tmux
brew install zsh
brew install stow
brew install ripgrep
brew install fd
brew install fzf
brew install bat
brew install eza
brew install git-delta
brew install lazygit
brew install gh

# Install applications via Cask
echo -e "${YELLOW}Installing applications...${NC}"
brew install --cask wezterm

# Create necessary directories
echo -e "${YELLOW}Creating necessary directories...${NC}"
mkdir -p ~/.config/nvim
mkdir -p ~/.config/wezterm
mkdir -p ~/.ssh
mkdir -p ~/Pictures

# Backup existing files
echo -e "${YELLOW}Backing up existing configuration files...${NC}"
backup_dir=~/dotfiles_backup_$(date +%Y%m%d_%H%M%S)
mkdir -p "$backup_dir"

for file in .zshrc .tmux.conf; do
    if [ -f ~/$file ] && [ ! -L ~/$file ]; then
        echo -e "${YELLOW}Backing up existing $file${NC}"
        mv ~/$file "$backup_dir/"
    fi
done

if [ -d ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
    echo -e "${YELLOW}Backing up existing nvim config${NC}"
    mv ~/.config/nvim "$backup_dir/"
fi

if [ -d ~/.config/wezterm ] && [ ! -L ~/.config/wezterm ]; then
    echo -e "${YELLOW}Backing up existing wezterm config${NC}"
    mv ~/.config/wezterm "$backup_dir/"
fi

# Create symlinks
echo -e "${YELLOW}Creating symlinks...${NC}"

ln -sf "$DOTFILES_DIR/.zshrc" ~/.zshrc
echo -e "${GREEN}Linked .zshrc${NC}"

ln -sf "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf
echo -e "${GREEN}Linked .tmux.conf${NC}"

ln -sf "$DOTFILES_DIR/.config/nvim" ~/.config/nvim
echo -e "${GREEN}Linked nvim config${NC}"

ln -sf "$DOTFILES_DIR/.config/wezterm" ~/.config/wezterm
echo -e "${GREEN}Linked wezterm config${NC}"

# Handle SSH config carefully
if [ -f "$DOTFILES_DIR/.ssh/config" ]; then
    if [ -f ~/.ssh/config ] && [ ! -L ~/.ssh/config ]; then
        echo -e "${YELLOW}Backing up existing SSH config${NC}"
        mv ~/.ssh/config "$backup_dir/"
    fi
    ln -sf "$DOTFILES_DIR/.ssh/config" ~/.ssh/config
    chmod 600 "$DOTFILES_DIR/.ssh/config"
    echo -e "${GREEN}Linked SSH config${NC}"
fi

# Set wallpaper
if [ -f "$DOTFILES_DIR/wallpaper.jpg" ]; then
    echo -e "${YELLOW}Setting wallpaper...${NC}"
    cp "$DOTFILES_DIR/wallpaper.jpg" ~/Pictures/wallpaper.jpg
    osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$HOME/Pictures/wallpaper.jpg\" as POSIX file"
    echo -e "${GREEN}Wallpaper set${NC}"
fi

# Set Zsh as default shell if not already
if [ "$SHELL" != "$(which zsh)" ]; then
    echo -e "${YELLOW}Setting Zsh as default shell...${NC}"
    chsh -s $(which zsh)
    echo -e "${GREEN}Zsh set as default shell${NC}"
fi

# Install fzf key bindings
echo -e "${YELLOW}Setting up fzf...${NC}"
$(brew --prefix)/opt/fzf/install --all --no-bash --no-fish

echo ""
echo -e "${GREEN}=== Installation Complete! ===${NC}"
echo -e "${YELLOW}Please restart your terminal or run: source ~/.zshrc${NC}"
echo ""
if [ -d "$backup_dir" ] && [ "$(ls -A $backup_dir)" ]; then
    echo -e "${YELLOW}Your old configuration files have been backed up to: $backup_dir${NC}"
fi
