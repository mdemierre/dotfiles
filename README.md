# Marc Demierre's dotfiles

My precious dotfiles.

For now this repository contains:

- `git`: git configuration (.gitconfig + global ignore files)
- `vim`: VIM configuration (.vimrc)

Currently I also use zsh with prezto. My personal fork of prezto lives in
another repository:

https://github.com/mdemierre/prezto

## Installation

    git clone git@bitbucket.org:mdemierre/dotfiles.git ~/.dotfiles

### Git

    ln -s ~/.dotfiles/git/.gitconfig ~/.gitconfig

### VIM

    # Setup VIM config
    ln -s ~/.dotfiles/vim/.vimrc ~/.vimrc
    
    # Setup Vundle for VIM plugins
    clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall


## TODO

- Setup script (basically creates the simlinks)
- My prezto as a submodule

