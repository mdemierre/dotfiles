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


" ================================================
" Editor features
" ================================================

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Lines
set number         " Line numbers
set colorcolumn=80 " Column at 80 chars
set cursorline     " Highlight current line


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Spelling language
set spelllang=en_us


" ================================================
" Colors and fonts
" ================================================

" Font
set gfn=Source\ Code\ Pro:h16,Menlo:h16

" Color scheme
syntax on
set background=dark
set t_Co=256
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-onedark

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4


" ================================================
" Commands
" ================================================

" :W sudo saves the file 
" " (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null


" ================================================
" Syntax checking (Syntastic)
" ================================================

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


" ================================================
" Git
" ================================================

" Git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72 colorcolumn=72


" ================================================
" Rust
" ================================================

" Syntax checker
let g:syntastic_rust_checkers = ['rustc']

