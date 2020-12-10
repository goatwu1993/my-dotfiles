#!/bin/bash

# * Base PATH
# * Change this will cause command not found
export PATH="/bin:/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:$PATH"

#################
#### * PATH  ####
#################
# curl
export PATH="/usr/local/opt/curl/bin:$PATH"
# arping
export PATH="/usr/local/sbin:$PATH"
# nvm script is slow. Move to Alias to speed up terminal initialization
# vscode
export EDITOR='code -w'
export PATH=$PATH:$HOME/bin
# Spark
export SPARK_HOME=/usr/local/Cellar/apache-spark/2.4.5/libexec/
export PATH=/usr/local/Cellar/apache-spark/2.4.5/libexec/sbin/:$PATH
export PYSPARK_DRIVER_PYTHON=/usr/local/Caskroom/miniconda/base/envs/py3.7.0/bin/python
# tmux
export TERM=xterm-256color
# thefuck
eval $(thefuck --alias)
