# ---- Java ----
# Must be above the instant prompt preamble to avoid Powerlevel10k console I/O warnings.
# Stderr is silenced so a missing JDK version doesn't produce output during init.
if command -v /usr/libexec/java_home &>/dev/null; then
  export JAVA_HOME=$(/usr/libexec/java_home -v 17 2>/dev/null)
fi

# Suppress any remaining instant-prompt warnings (belt-and-suspenders).
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Theme + plugins installed via Homebrew
[[ -r /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]] && source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ -r /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] && source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -r /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ---- History setup ----
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

# ---- completion using arrow keys (based on history) ----
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ---- Eza (better ls) -----
alias ls="eza --icons=always"

# ---- Zoxide (better cd) ----
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

# ---- Direnv ----
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# ---- eo cli autocompletion ----
source <(eo completion zsh)

# ---- Pnpm ----
alias pn="pnpm"

# ---- Homebrew ----
eval "$(/opt/homebrew/bin/brew shellenv)"

# ---- NVM ----
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# ---- PNPM path ----
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ---- Go ----
export PATH="$HOME/go/bin:$PATH"

# ---- PostgreSQL ----
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# ---- Envman ----
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# ---- Bun completions ----
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ---- Bun ----
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ---- Secrets (not tracked in git) ----
# Put things like NPM_TOKEN in ~/.zshrc.secrets
[[ -f ~/.zshrc.secrets ]] && source ~/.zshrc.secrets
