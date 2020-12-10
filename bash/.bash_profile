#!/bin/bash

# * Base PATH
# * Change this will cause command not found
PATH="/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin"
export PATH


# * conda
# added by Anaconda3 2019.07 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/peter/anaconda3/bin/conda' shell.bash hook 2>/dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/peter/anaconda3/etc/profile.d/conda.sh" ]; then
# . "/Users/peter/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/peter/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

#################
#### * PATH  ####
#################
# curl
export PATH="/usr/local/opt/curl/bin:$PATH"
# arping
export PATH="/usr/local/sbin:$PATH"
#  Scala
export PATH="$PATH:/usr/local/share/scala/bin"
# nvm script is slow. Move to Alias to speed up terminal initialization
# vscode
export EDITOR='code -w'
export PATH=$PATH:$HOME/bin
# Spark
export SPARK_HOME=/usr/local/Cellar/apache-spark/2.4.5/libexec/
export PATH=/usr/local/Cellar/apache-spark/2.4.5/libexec/sbin/:$PATH
export PYSPARK_DRIVER_PYTHON=/usr/local/Caskroom/miniconda/base/envs/py3.7.0/bin/python
# yarn
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
# maven@3.5
export PATH="/usr/local/opt/maven@3.5/bin:$PATH"
# Airflow
export AIRFLOW_HOME=~/airflow
# tmux
export TERM=xterm-256color
# nvm
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node
# thefuck
eval $(thefuck --alias)
# jenv
export JENV_ROOT=/usr/local/opt/jenv
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
export LINKER_ENV="staging"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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
# <<< conda initialize <<<

