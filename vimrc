" Expanding on neovim's sane defaults.
set guioptions=M           " disables gui (speed).
set shortmess+=I           " disable opening screen.
set number                 " show line numbers.
set hidden                 " switch buffers without saving.
set scrolloff=3            " edge scroll.
set ignorecase             " search without case.
set smartcase              " even smarter search.
set sw=4 ts=4              " shift width, tab stop.
set expandtab              " tabs are spaces..
set list listchars=tab:>-  " ..unless they are not.


" Keys.
let mapleader = ","

nmap <leader>d :bd<cr>

nmap <Left>  <C-w>h
nmap <Down>  <C-w>j
nmap <Up>    <C-w>k
nmap <Right> <C-w>l

nnoremap <F3>  :set hlsearch!<CR>
nnoremap <F10> :set paste!<CR>

cmap w!! w !sudo tee % > /dev/null


" File specifics.
autocmd Filetype python      let &colorcolumn = "80,".join(range(101,999),",")
autocmd Filetype yaml        setlocal sw=2 ts=2
autocmd Filetype html        setlocal expandtab!
autocmd Filetype css         setlocal sw=2 ts=2
autocmd Filetype javascript  setlocal sw=2 ts=2


" Plugin manager.
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Interface plugins.
Plug 'romainl/Apprentice'
syntax enable

Plug 'itchyny/lightline.vim'
set laststatus=2
set noshowmode
Plug 'mgee/lightline-bufferline'
let g:lightline                  = {}
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}
set showtabline=2
nmap <silent> <C-h> :bprev<CR>
nmap <silent> <C-l> :bnext<CR>

" File management plugins.
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
let g:NERDTreeWinPos = "right"
nmap <silent> <Leader>h :NERDTreeToggle<CR>

Plug 'junegunn/fzf', { 'on': 'FZF' }
if executable("rg")
    let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!{.git,node_modules,*.pyc}"'
endif
nmap <leader>o :FZF<cr>

" Buffer management plugins.
Plug 'vim-scripts/YankRing.vim', { 'on':  'YRShow' }
let g:yankring_history_dir = '~/.vim'
nmap <leader>y :YRShow<cr>

" Completion plugins.
if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    let g:deoplete#enable_at_startup = 1
    Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go' }
    Plug 'zchee/deoplete-jedi', { 'for': 'python' }
    Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern', 'for': 'javascript' }
endif

" Coding plugins.
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'for': 'go' }
let g:go_fmt_command = "goimports"
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
" TODO: Plug 'neomake/neomake' - replaces Syntastic. Golang inline error checking, Python flake8.

call plug#end()


" Themes (apply after plug).
color apprentice
