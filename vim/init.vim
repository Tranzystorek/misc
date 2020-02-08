call plug#begin('~/.local/share/nvim/plugged')

Plug 'dikiaap/minimalist'
Plug 'morhetz/gruvbox'
Plug 'srcery-colors/srcery-vim'
Plug 'itchyny/lightline.vim'

Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'

call plug#end()

"true readonly
autocmd BufRead * let &l:modifiable = !&readonly

"lightline config
let g:lightline = {
        \ 'colorscheme': 'srcery_drk',
        \ }

"color schemes
set termguicolors
set background=dark
colorscheme srcery

"tab settings
set expandtab

"sane display
set number
set cursorline

"display whitespace/breaks
set showbreak=↪\ 
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
set list

"default system clipboard
set clipboard+=unnamedplus
