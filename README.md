# dotfiles

Edwin's macOS dotfiles: zsh + Powerlevel10k, WezTerm, tmux and a Neovim setup
for TypeScript, Go, Python and Flutter work. Clone and run `install.sh` on a new
machine.

> Built for Apple Silicon Macs (Homebrew in `/opt/homebrew`).

## What's inside

| Tool | Config | Highlights |
| --- | --- | --- |
| zsh | `home/.zshrc` | Powerlevel10k, autosuggestions, syntax highlighting, zoxide (`cd`), eza (`ls`), direnv, nvm |
| WezTerm | `home/.wezterm.lua` | MesloLGS Nerd Font, custom dark theme, no tab bar (tmux handles that) |
| tmux | `home/.tmux.conf` | Prefix `Ctrl+Space`, vim-style panes, sessions survive reboots (resurrect + continuum) |
| Neovim | `config/nvim/` | lazy.nvim, native LSP + Mason, conform (format on save), nvim-lint, snacks picker, harpoon, oil, Copilot |
| git | `home/.gitconfig` | Shared defaults; your identity goes in `~/.gitconfig.local` |
| Homebrew | `Brewfile` | Everything installed via `brew bundle` |

## Installation

```bash
git clone https://github.com/edwinboon/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

This will:

- Install Homebrew (if not present) and trust the taps listed in the `Brewfile`
- Install all packages from `Brewfile` via `brew bundle`
- Install NVM, Bun and TPM (tmux plugin manager) if not present
- Create `~/.gitconfig.local` with your current git name/email (or from the example)
- Symlink the dotfiles into `~/` and `~/.config/`; existing files are moved to `<file>.bak.<timestamp>`
- Create `~/.zshrc.secrets` from the example file
- Set the desktop wallpaper (skip with `SKIP_WALLPAPER=1 ./install.sh`)

The script is safe to re-run.

### After installing

1. Fill in your tokens in `~/.zshrc.secrets`.
2. Check your name and email in `~/.gitconfig.local`.
3. Start tmux and press `Ctrl+Space` then `I` to install the tmux plugins.
4. Open `nvim` once; lazy.nvim and Mason install plugins, language servers and formatters.

## Using this as a colleague

Fork it rather than cloning directly, then before running `install.sh`:

- Trim the `Brewfile` to the tools you actually need. It is grouped by purpose.
- Replace or delete `assets/wallpaper.jpg`.
- Personal details never live in the repo: secrets go in `~/.zshrc.secrets`, git
  identity in `~/.gitconfig.local`.

## Secrets

Tokens and sensitive variables are **not** tracked in this repo. After
installation, fill in your values in `~/.zshrc.secrets` (see
`home/.zshrc.secrets.example`).

## Key bindings cheat sheet

**tmux** (prefix = `Ctrl+Space`)

| Keys | Action |
| --- | --- |
| `prefix \` / `prefix -` | Split side by side / top and bottom |
| `prefix h/j/k/l` | Move between panes |
| `prefix H/J/K/L` | Resize pane |
| `prefix [` / `prefix ]` | Previous / next window |
| `prefix c` | New window in current directory |
| `prefix r` | Reload config |

**Neovim** (leader = `Space`)

| Keys | Action |
| --- | --- |
| `<leader>ff` / `<leader>fs` | Find files / grep |
| `<leader>fr` | Recent files |
| `<leader>fk` | Search all keymaps |
| `-` / `<leader>-` | Oil file browser / floating |
| `<leader>lg` | lazygit |
| `<leader>h` / `Ctrl+e` | Harpoon: add file / menu |
| `gd` / `gR` / `K` | Definition / references / hover |
| `<leader>vca` / `<leader>rn` | Code action / rename |
| `<leader>mp` | Format file |
| `<leader>xw` / `<leader>xd` | Trouble: workspace / buffer diagnostics |
| `<leader>ot` / `<leader>oa` | opencode: toggle / ask |

## Structure

```
dotfiles/
├── install.sh                   # bootstrap script (safe to re-run)
├── Brewfile                     # Homebrew packages, grouped by purpose
├── assets/
│   └── wallpaper.jpg
├── home/                        # symlinked into ~/
│   ├── .zshrc                   # shell config (without secrets)
│   ├── .zshrc.secrets.example   # secrets template
│   ├── .gitconfig               # shared git defaults
│   ├── .gitconfig.local.example # git identity template
│   ├── .tmux.conf
│   ├── .wezterm.lua
│   └── .p10k.zsh
└── config/
    └── nvim/                    # symlinked to ~/.config/nvim
```

## Keeping the Brewfile in sync

Edit the `Brewfile` by hand so the grouping and comments survive. To see what
is installed but missing from it (or the other way round):

```bash
brew bundle check --file=Brewfile --verbose   # in Brewfile, not installed
brew bundle cleanup --file=Brewfile           # installed, not in Brewfile (dry run)
```
