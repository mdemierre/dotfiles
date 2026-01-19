#!/usr/bin/env zsh

#
# setup.sh - Sets up symlinks for the dotfiles
#

set -o errexit
set -o nounset
set -o pipefail

# debugging
set -o xtrace

readonly SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

readonly REPOS_DIR="$HOME/dev/personal"
readonly DOTFILES_REPO_DIR="$REPOS_DIR/dotfiles" 

readonly DOTFILES_LINK_DIR="$HOME/.dotfiles"

# -- Homebrew installs
brew bundle install --file "$DOTFILES_REPO_DIR/Brewfile"

# -- Cloning config repos

# Prezto
if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    git clone --branch mdemierre-customizations --recursive git@github.com:mdemierre/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
fi

# -- Symlinks
cd "$HOME"

# Symlink to ~/.dotfiles for ease of use
if [ ! -d ".dotfiles" ]; then
    ln -s "$DOTFILES_REPO_DIR" .dotfiles 
fi

# Python
mkdir -p './Library/Application Support/pypoetry'
ln -si "$DOTFILES_LINK_DIR/python/poetry/config.toml" './Library/Application Support/pypoetry/config.toml'

# VIM
ln -si "$DOTFILES_LINK_DIR/vim/vimrc" .vimrc
[ ! -d '.vim/spell' ] && mkdir -p '.vim/spell'
ln -si "$DOTFILES_LINK_DIR/vim/en.utf-8.add" .vim/spell/en.utf-8.add

# ZSH
ln -si "$DOTFILES_LINK_DIR/zsh" .zsh
ln -si "$DOTFILES_LINK_DIR/starship.toml" ~/.config/starship.toml

# VSCode
ln -si "$DOTFILES_LINK_DIR/vscode/settings.json" './Library/Application Support/Code/User/settings.json'

# Git
ln -si "$DOTFILES_LINK_DIR/git/gitconfig" .gitconfig

# mise (mise en place)
ln -si "$DOTFILES_LINK_DIR/mise" ~/.config/mise

# -- Prezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
unsetopt EXTENDED_GLOB
