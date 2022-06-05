" vim-plug: https://github.com/junegunn/vim-plug

" Directory to store plugins
call plug#begin('~/.vim/plugged')

" Base16 color schemes
Plug 'chriskempson/base16-vim'
Plug 'mike-hearn/base16-vim-lightline'

" Git Gutter
Plug 'airblade/vim-gitgutter'

" Line numbers
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Better status line
Plug 'itchyny/lightline.vim'

" Initialize plugin system
call plug#end()
