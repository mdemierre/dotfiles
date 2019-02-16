set nocompatible              " be iMproved, required

" ==============================================
" Vundle
" ==============================================

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Base16 color schemes
Plugin 'chriskempson/base16-vim'

" Git Gutter
Plugin 'airblade/vim-gitgutter'

" Line numbers
Plugin 'jeffkreeftmeijer/vim-numbertoggle'

" Syntax checker
Plugin 'vim-syntastic/syntastic'

" Rust support
Plugin 'rust-lang/rust.vim'
Plugin 'cespare/vim-toml'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
