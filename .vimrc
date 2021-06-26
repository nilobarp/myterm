" be iMproved
set nocompatible

" map leader ket to \ (usually this the default)
let mapleader = "\\"

""" Plugins using vim-plug {{{
call plug#begin('~/.vim/plugged')

" C# language server
Plug 'OmniSharp/omnisharp-vim'

" Mappings, code-actions available flag and statusline integration
Plug 'nickspoons/vim-sharpenup'

" Linting/error highlighting
Plug 'dense-analysis/ale'

" Vim FZF integration, used as OmniSharp selector
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Autocompletion
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/async.vim'

" Code commenting
Plug 'preservim/nerdcommenter'

" File browsing
Plug 'preservim/nerdtree'

" Colorscheme
Plug 'gruvbox-community/gruvbox'

" Debugger
Plug 'puremourning/vimspector'

" Statusline
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'
Plug 'maximbaz/lightline-ale'

" Code formatting
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-autoformat/vim-autoformat'

" Git integration
Plug 'tpope/vim-fugitive'

call plug#end()
""" }}}

" Settings: {{{
filetype indent plugin on
if !exists('g:syntax_on') | syntax enable | endif
set encoding=utf-8
set guifont=Monospace:h1
scriptencoding utf-8
set guioptions-=T "Remove top bar
set guioptions-=r "Remove right hand scrollbar
set go-=L "Removes left hand scrollbar
set linespace=15
set showmode
set nowrap
set expandtab
set number      "Always show line numbers
set ignorecase  "Ignore case when searching
set noerrorbells        "don't beep
set mouse=a
set backspace=indent,eol,start
" set expandtab
set shiftround
set shiftwidth=2
" set softtabstop=-1
" set tabstop=8
set textwidth=80
set title

set hidden
set nofixendofline
set nostartofline
set splitbelow
set splitright

set hlsearch
set incsearch
set laststatus=2
" set nonumber
set noruler
set noshowmode
set signcolumn=yes

set updatetime=1000
filetype plugin on
""" }}}

" Colors: {{{
augroup ColorschemePreferences
  autocmd!
  " These preferences clear some gruvbox background colours, allowing transparency
  autocmd ColorScheme * highlight Normal     ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight SignColumn ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight Todo       ctermbg=NONE guibg=NONE
  " Link ALE sign highlights to similar equivalents without background colours
  autocmd ColorScheme * highlight link ALEErrorSign   WarningMsg
  autocmd ColorScheme * highlight link ALEWarningSign ModeMsg
  autocmd ColorScheme * highlight link ALEInfoSign    Identifier
augroup END

" Use truecolor in the terminal, when it is supported
if has('termguicolors')
  set termguicolors
endif

set background=dark
colorscheme gruvbox
" }}}

" ALE: {{{
let g:ale_sign_error = '⊙'
let g:ale_sign_warning = '⚠️'
let g:ale_sign_info = 'ℹ︎'
let g:ale_sign_style_error = '❭'
let g:ale_sign_style_warning = '❭'

let g:ale_linters = { 'cs': ['OmniSharp'] }
" }}}

" Asyncomplete: {{{
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
" }}}

" Sharpenup: {{{
let g:sharpenup_map_prefix = ';'
let g:sharpenup_statusline_opts = { 'Text': '%s (%p/%P)' }
let g:sharpenup_statusline_opts.Highlight = 0

augroup OmniSharpIntegrations
  autocmd!
  autocmd User OmniSharpProjectUpdated,OmniSharpReady call lightline#update()
augroup END
" }}}


" Lightline: {{{
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': {
        \ 'n' : 'N',
        \ 'i' : 'I',
        \ 'R' : 'R',
        \ 'v' : 'V',
        \ 'V' : 'VL',
        \ "\<C-v>": 'VB',
        \ 'c' : 'C',
        \ 's' : 'S',
        \ 'S' : 'SL',
        \ "\<C-s>": 'SB',
        \ 't': 'T',
        \ },
      \ 'active': {
        \   'left': [['mode'],['filename']],
        \   'right': [
          \     ['gitbranch'],['lineinfo'], ['percent'],
          \   ]
          \ },
          \ 'inactive': {
            \   'right': [['lineinfo'], ['percent']]
            \ },
            \ 'component': {
              \   'sharpenup': sharpenup#statusline#Build(),
              \ },
              \ 'component_function': {
              \   'gitbranch': 'FugitiveHead',
              \   'filename': 'LightlineFilename'
              \ },
              \ 'component_expand': {
                \   'linter_checking': 'lightline#ale#checking',
                \   'linter_infos': 'lightline#ale#infos',
                \   'linter_warnings': 'lightline#ale#warnings',
                \   'linter_errors': 'lightline#ale#errors',
                \   'linter_ok': 'lightline#ale#ok'
                \  },
                \ 'component_type': {
                  \   'linter_checking': 'right',
                  \   'linter_infos': 'right',
                  \   'linter_warnings': 'warning',
                  \   'linter_errors': 'error',
                  \   'linter_ok': 'right'
                  \  }
                  \}
" Use unicode chars for ale indicators in the statusline
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_infos = "\uf129 "
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c "

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
" }}}


" OmniSharp: {{{
let g:omnicomplete_fetch_full_documentation = 1
let g:OmniSharp_popup_position = 'peek'
if has('nvim')
  let g:OmniSharp_popup_options = {
        \ 'winhl': 'Normal:NormalFloat'
        \}
else
  let g:OmniSharp_popup_options = {
        \ 'highlight': 'Normal',
        \ 'padding': [0, 0, 0, 0],
        \ 'border': [1]
        \}
endif
let g:OmniSharp_popup_mappings = {
      \ 'sigNext': '<C-n>',
      \ 'sigPrev': '<C-p>',
      \ 'pageDown': ['<C-f>', '<PageDown>'],
      \ 'pageUp': ['<C-b>', '<PageUp>']
      \}

if s:using_snippets
  let g:OmniSharp_want_snippet = 1
endif

let g:OmniSharp_highlight_groups = {
      \ 'ExcludedCode': 'NonText'
      \}

set completeopt=menuone,noinsert,noselect,popuphidden
set completepopup=highlight:Pmenu,border:off
set completeopt=menuone,noinsert,noselect,preview
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 0
let g:asyncomplete_force_refresh_on_context_changed = 1

let g:OmniSharp_server_stdio = 1
let g:OmniSharp_highlight_types = 2
" }}}

"NERDCommenter: {{{
" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
" let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
" let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
" let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" }}}

" NERDTree {{{
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" autocmd VimEnter * NERDTree " open NERDTree by default
" autocmd VimEnter * wincmd p " focus editor buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif " if root is a directory start with NERDTree
"}}}

" vimspector {{{
let g:vimspector_enable_mappings = 'HUMAN
" }}}

" Key mappings {{{
" Split navigations
nnoremap <C-J> <C-W><C-J> "go to split above
nnoremap <C-K> <C-W><C-K> "go to split below
nnoremap <C-L> <C-W><C-L> "go to slipt on left
nnoremap <C-H> <C-W><C-H> "go to split on right
nmap <C-v> :vertical resize +5<cr> "increase split size
nmap <C-V> :vertical resize -5<cr> "decrease split size

nmap <C-b> :NERDTreeToggle<cr> "toggle NERD Tree file browser

"Hide search results
command H let @/=""

map <D-p> :CtrlP<cr>
map <C-r> :CtrlPBufTag<cr>

nmap vs :vsplit<cr>
nmap sp :split<cr>

noremap <C-f> :Autoformat<CR>
noremap <leader>f :Files<CR>
noremap <leader>g :GFiles<CR>
noremap <leader>h :History<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>t :OmniSharpRunTest<CR>
noremap <leader>tt :OmniSharpRunTestsInFile<CR>
" }}}

" templates {{{
nnoremap <leader>=legal :-1read $HOME/.vim/templates/copyright_notice<CR>4j
"}}}