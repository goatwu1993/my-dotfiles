#!/usr/bin/env zsh

# Get the directory of this script
DOTFILES=${0:A:h}

# Default folders to stow if not set externally
if [[ -z $STOW_FOLDERS ]]; then
   # STOW_FOLDERS="alias,bash,nvim,readline,rg,scripts,slate,tmux,zsh"
   STOW_FOLDERS="zsh"
fi

echo "STOW_FOLDERS: $STOW_FOLDERS"
echo "DOTFILES: $DOTFILES"
pushd "$DOTFILES" > /dev/null

for folder in ${(s:,:)STOW_FOLDERS}; do
    echo "stow $folder"
    stow -D "$folder" --verbose=5
    stow "$folder"
done

popd > /dev/null

