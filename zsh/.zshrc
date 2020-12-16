# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

# Path to your oh-my-zsh installation.
export ZSH="/Users/wuzhaoyang/.oh-my-zsh"

ZSH_THEME="robbyrussell"

HYPHEN_INSENSITIVE="true"


# ==========================================================
# Settings
# ==========================================================
#setopt correct
#unsetopt correctall
export LSCOLORS='Exfxcxdxbxegedabagacad'
export LS_COLORS='di=1;34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt INC_APPEND_HISTORY
unsetopt HIST_BEEP
setopt share_history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"
setopt AUTO_CD
setopt ALWAYS_TO_END
setopt AUTO_LIST
setopt AUTO_MENU
setopt AUTO_PARAM_SLASH
setopt COMPLETE_IN_WORD
unsetopt MENU_COMPLETE
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';
typeset -aU path;

# ==========================================================
# Plugin
# ==========================================================
plugins=(\
	git \
	wd \
	zsh-autosuggestions \
	zsh-completions \
	alias-tips \
	kubectl \
)

source $ZSH/oh-my-zsh.sh


# ==========================================================
# Personal alias
# ==========================================================
alias gs="git status"

# ==========================================================
# Conda
# ==========================================================
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/wuzhaoyang/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/wuzhaoyang/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/wuzhaoyang/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/wuzhaoyang/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ==========================================================
# Iterm2
# ==========================================================
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


# ==========================================================
# Alias
# ==========================================================
source ~/.sh_aliases
