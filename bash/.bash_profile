echo "bash profile"
PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin" # Make sure to use double quotes not single quotes And on a new line 
export PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/wuzhaoyang/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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

. "$HOME/.cargo/env"
