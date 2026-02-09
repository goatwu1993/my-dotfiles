# Optimized .zshrc with lazy-loading
# Performance profiling - start
zshrc_start=$(date +%s)
echo "Zshrc start at ${zshrc_start}"
zmodload zsh/zprof

# Basic PATH setup
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Optimized plugin list - removed heavy completion plugins (aws, kubectl)
# These will be lazy-loaded instead
plugins=(
    git
    docker
    brew
    gh
    wd
    zsh-autosuggestions
    zsh-completions
)

source $ZSH/oh-my-zsh.sh

# Locale
export LANG=en_US.UTF-8

# Editor
if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
else
   export EDITOR='nvim'
fi

# Source aliases (fast, no lazy-loading needed)
[ -f ~/.sh_aliases ] && source ~/.sh_aliases

# =============================================================================
# Completion setup - optimized to run once
# =============================================================================
autoload -Uz compinit

# Only regenerate compdump once a day for faster startup
# https://gist.github.com/ctechols/ca1035271ad134841284
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

# Load bash completion for AWS CLI (will be lazy-loaded)
autoload bashcompinit && bashcompinit

# zsh-completions
zstyle ':completion:*:*:make:*' tag-order 'targets'
fpath=(/usr/local/share/zsh-completions $fpath)

# =============================================================================
# Path exports - these are fast
# =============================================================================
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="/usr/local/opt/node@16/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export DOTNET_ROOT=/usr/local/share/dotnet
export PATH="$PATH:/usr/local/share/dotnet"

# =============================================================================
# Environment variables - these are fast
# =============================================================================
export DOCKER_SCAN_SUGGEST=false
export BUILDKIT_PROGRESS=plain
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# =============================================================================
# Deferred/Lazy-loaded initializations
# =============================================================================

# FZF - defer loading
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
fi

# Docker init - defer if it exists
if [ -f "${HOME}/.docker/init-zsh.sh" ]; then
    # Fork the sourcing to background to not block shell startup
    (source "${HOME}/.docker/init-zsh.sh" &)
fi

# Rye - quick, load normally
[ -f "$HOME/.rye/env" ] && source "$HOME/.rye/env"

# NVM completion - defer if it exists
if [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ]; then
    # Lazy load NVM
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh" --no-use
    alias nvm='unalias nvm; [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"; nvm $@'
fi

# pnpm
export PNPM_HOME="/Users/peter_wu/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Custom envs - load if exists
[ -f ~/.works ] && source ~/.works

# =============================================================================
# Lazy loading for heavy tools
# =============================================================================
source ~/.zsh-lazy-load.sh

# =============================================================================
# Performance profiling - end
# =============================================================================
zshrc_end=$(date +%s)
echo "Zshrc end at ${zshrc_end}"
zshrc_duration=$((zshrc_end - zshrc_start))
echo "Elapsed time: ${zshrc_duration}s"

# If > threshold, print out the zprof
THRESHOLD=3
if [ $zshrc_duration -gt $THRESHOLD ]; then
    echo "\n⚠️  Shell startup took ${zshrc_duration}s (threshold: ${THRESHOLD}s)"
    echo "Run 'zprof' to see detailed profiling information"
fi
