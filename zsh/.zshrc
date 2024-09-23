# source ~/.bash_profile
#
# start time (milliseconds)
# Profile
zshrc_start=$(date +%s)
echo "Zshrc start at ${zshrc_start}"
zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

plugins=(
    alias-tips
    aws
    brew
    docker
    gh
    git
    kubectl
    wd
    zsh-autosuggestions
    zsh-completions
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

source ~/.sh_aliases
eval $(thefuck --alias)
autoload bashcompinit && bashcompinit

complete -C '/usr/local/bin/aws_completer' aws
# zsh-completions
zstyle ':completion:*:*:make:*' tag-order 'targets'
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit && compinit
compinit

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/openjdk/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Load Angular CLI autocompletion.
#source <(ng completion script)
export PATH="/usr/local/opt/node@16/bin:$PATH"
export DOCKER_SCAN_SUGGEST=false

source ${HOME}/.docker/init-zsh.sh
export PATH="$HOME/.cargo/bin:${PATH}"
## rye
source "$HOME/.rye/env"

export GOPATH="$HOME/go"
export PATH=$PATH:$GOPATH/bin


## Node Environment Manager
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"


[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export BUILDKIT_PROGRESS=plain

# dotnet
export DOTNET_ROOT=/usr/local/share/dotnet
export PATH=$PATH:/usr/local/share/dotnet
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc

# If reach here more then 5 seconds, print out the zprof
# use zprof time
zshrc_end=$(date +%s)
echo "Zshrc end at ${zshrc_end}"
zshrc_duration=$((zshrc_end - zshrc_start))
echo "Elapsed time: $zshrc_duration"
# If > threshold, print out the zprof
THRESHOLD=3
if [ $zshrc_duration -gt $THRESHOLD ]; then
  zprof
fi
