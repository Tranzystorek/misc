call plug#begin('~/.local/share/nvim/plugged')

Plug 'dikiaap/minimalist'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'

call plug#end()

"true readonly
autocmd BufRead * let &l:modifiable = !&readonly

"color schemes
set termguicolors
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark="hard"

let g:airline_powerline_fonts = 1

"sane display
set number
set cursorline

"default system clipboard
set clipboard+=unnamedplus
