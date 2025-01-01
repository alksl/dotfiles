#!/usr/bin/env bash

set -e

ROOT="$(realpath "$(dirname "${BASH_SOURCE[0]}")")"

link-file() {
  local source_file="$ROOT/$1"
  local dest_file="$2"
  local overwite="$3"

  if [[ -e "${dest_file}" ]] && [[ "${overwite}" == "overwrite" ]]; then
    echo "Reinstalling ${dest_file}"
    rm "${dest_file}"
    ln -s "${source_file}" "${dest_file}"
  elif [[ ! -e "${dest_file}" ]]; then
    echo "Installing ${dest_file}"
    ln -s "${source_file}" "${dest_file}"
  else
    echo "${dest_file} is already installed"
  fi
}

link-file "zshrc" "${HOME}/.zshrc" "$1"
link-file "zsh" "${HOME}/.zsh" "$1"
link-file "vimrc" "${HOME}/.vimrc" "$1"
link-file "vim" "${HOME}/.vim" "$1"
link-file "i3/config" "${HOME}/.config/i3/config" "$1"
link-file "kitty/kitty.conf" "${HOME}/.config/kitty/kitty.conf" "$1"
link-file "kitty/theme.conf" "${HOME}/.config/kitty/theme.conf" "$1"
link-file "kitty/kitty-themes" "${HOME}/.config/kitty/kitty-themes" "$1"
link-file "nvim" "${HOME}/.config/nvim"
link-file "ghostty" "${HOME}/.config/ghostty"

mkdir -p  "${HOME}/.fonts"
link-file "fonts/local.conf" "${HOME}/.fonts/local.conf" "$1"

link-file "asdfrc" "${HOME}/.asdfrc" "$1"
