#!/bin/bash
BASEDIR=$(dirname $0)
cd "${BASEDIR}"
ls -d */ | xargs -I{} stow -D --dir="${BASEDIR}" {}
