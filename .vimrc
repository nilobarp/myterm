"set nocompatible              " be iMproved, required
filetype off                  " required
filetype plugin indent off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'

set runtimepath^=~/.vim/bundle/vim-airline
set runtimepath^=~/.vim/bundle/ctrlp.vim
set runtimepath^=~/.vim/bundle/nerdtree
set runtimepath^=~/.vim/bundle/vim-go
set runtimepath^=~/.vim/bundle/neocomplete.vim

filetype plugin indent on
syntax on

colorscheme xoria256
set t_Co=256
set guifont=Monospace:h14
set guioptions-=T "Remove top bar
set guioptions-=r "Remove right hand scrollbar
set go-=L "Removes left hand scrollbar
set linespace=15
set showmode
set nowrap
set tabstop=4
set shiftwidth=4
set expandtab
"set smarttab
set number	"Always show line numbers
set ignorecase	"Ignore case when searching
"set visualbell	"don't beep
set noerrorbells	"don't beep
set mouse=a

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nmap <C-v> :vertical resize +5<cr>
nmap <C-b> :NERDTreeToggle<cr>
nmap <C-1> :tabn<cr>

"Remove search results
command H let @/=""

map <D-p> :CtrlP<cr>
map <C-r> :CtrlPBuffTag<cr>

nmap vs :vsplit<cr>
nmap sp :split<cr>

"alirline configuration
set laststatus=2
let g:airline_left_sep = '>'
let g:airline_right_sep = '<'
let g:airline_inactive_collapse=1
let g:airline_section_warning=''

"Auto complete
let g:neocomplete#enable_at_startup = 1

"golang
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
