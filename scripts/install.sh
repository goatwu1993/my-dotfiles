#!/bin/bash
BASEDIR=$(dirname $0)
BASEDIR=${HOME}/PeterWu/my-dotfiles
echo "BASEDIR: $BASEDIR"
cd "${BASEDIR}"
ls -d */ | xargs -I{} stow --dir="${BASEDIR}" {}
