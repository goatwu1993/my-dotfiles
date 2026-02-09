#!/usr/bin/env zsh
# Lazy loading helper functions

# Generic lazy load function
# Usage: lazy_load <command> <init_function>
lazy_load() {
    local command=$1
    local init_func=$2

    eval "
    $command() {
        unfunction $command
        $init_func
        $command \"\$@\"
    }
    "
}

# Lazy load AWS CLI completion
lazy_init_aws() {
    complete -C '/usr/local/bin/aws_completer' aws
}

# Lazy load kubectl completion
lazy_init_kubectl() {
    if command -v kubectl &> /dev/null; then
        source <(kubectl completion zsh)
    fi
}

# Lazy load thefuck
lazy_init_thefuck() {
    if command -v thefuck &> /dev/null; then
        eval $(thefuck --alias)
    fi
}

# Lazy load conda
lazy_init_conda() {
    __conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
            . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
        else
            export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
        fi
    fi
    unset __conda_setup
}

# Set up lazy loading for AWS
if command -v aws &> /dev/null; then
    lazy_load aws lazy_init_aws
fi

# Set up lazy loading for kubectl
if command -v kubectl &> /dev/null; then
    lazy_load kubectl lazy_init_kubectl
fi

# Set up lazy loading for thefuck
if command -v thefuck &> /dev/null; then
    lazy_load fuck lazy_init_thefuck
fi

# Set up lazy loading for conda
if [ -d "/usr/local/Caskroom/miniconda/base" ]; then
    lazy_load conda lazy_init_conda
fi
