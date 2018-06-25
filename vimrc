" Vundle setup.
set nocompatible                                    " viMproved.
filetype off                                        " Required by Vundle.

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle bundles: original repos on github.
Bundle 'gmarik/vundle'
" Colorscheme.
Bundle 'philpl/vim-adventurous'
" Status bar.
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
" File lookup.
Bundle 'scrooloose/nerdtree'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'vim-scripts/mru.vim'
" Improved yanking.
Bundle 'vim-scripts/YankRing.vim'
" Improves buffer closure.
Bundle 'rbgrouleff/bclose.vim'
" Tabular alignment.
Bundle 'godlygeek/tabular'
" Git support.
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
" Generic code support.
Bundle 'scrooloose/syntastic'
Bundle 'ervandew/supertab'
Bundle 'majutsushi/tagbar'
Bundle 'vim-scripts/TaskList.vim'
" Specific code support.
Bundle 'fatih/vim-go'
Plugin 'chr4/sslsecure.vim'
Bundle 'davidhalter/jedi-vim'
Bundle 'fisadev/vim-isort'
Bundle 'estin/htmljinja'
Bundle 'pangloss/vim-javascript'
Bundle 'groenewege/vim-less'
Bundle 'vim-ruby/vim-ruby'

" General config.
filetype plugin indent on                           " Filetype specific plugin/indent loading.
scriptencoding utf-8                                " Force utf-8.
set encoding=utf-8
set termencoding=utf-8
set autoindent                                      " Keeps the indent of a previous line when starting a new one.
set sta                                             " Enables smarttab: makes autoindent expand tab to shiftwidth nr of spaces.
set sw=4 ts=4                                       " Shift width, tab stop.
set colorcolumn=80                                  " Try to stay below 80 chars, regardless of filetype.
set expandtab                                       " Makes a tab a series of spaces.
syntax on                                           " Syntax coloring.
set nu                                              " Enable linenumbers.
set ruler                                           " Display the current cursor position in the lower right corner.
set history=1000                                    " Command history.
set wildmenu                                        " Command completion menu.
set wildmode=longest:full,full
set completeopt=longest,menuone,preview             " Proper omnicompletion.
set title                                           " Set window title.
set laststatus=2                                    " Always show statusbar.
set scrolloff=3                                     " Nr of lines on the edge to scroll.
set showcmd                                         " Show commands during typing.
set pastetoggle=<F10>                               " Enable paste.
set hidden                                          " Buffer switching without saving.
set vb t_vb=                                        " Disable beep / flash.
set ttyfast                                         " Faster refresh etc.
set showmatch                                       " Show matching brace.
set matchtime=1
set shortmess+=I                                    " Disable vim opening screen.
if executable("zsh")
    set shell=zsh
endif

" Editor.
" - Strip trailing whitespace.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" - Sort css upto }.
noremap <silent> <Leader>s :.,/}/sort<CR>:nohl<CR>

" Extension based tab stops (home).
autocmd BufRead,BufNewFile *.html,*.css,*.less,*.sass,*.jsp setlocal expandtab!
autocmd BufRead,BufNewFile *.coffee *.pp *.yml *.yaml setlocal sw=2 ts=2
autocmd BufRead,BufNewFile *.py let &colorcolumn = "80,".join(range(101,999),",") " try to stay below 80 chars, max 100 (python)

" Key mapping
" - Leader.
let mapleader = ","
" - Map move keys.
nmap <silent> <C-n> :tabprev<CR>
nmap <silent> <C-.> :tabnext<CR>
nmap <silent> <C-h> :bprev<CR>
nmap <silent> <C-l> :bnext<CR>
" - Make Y effect to end of line instead of whole line.
nmap Y y$
" - Return to visual mode after indenting.
xmap < <gv
xmap > >gv
" - Backspace behavior.
set backspace=indent,eol,start
" - Window mapping.
nmap <Left> <C-w>h
nmap <Down> <C-w>j
nmap <Up> <C-w>k
nmap <Right> <C-w>l
" - Swap ' and `.
noremap ' `
noremap ` '
" - F3 clears search marking.
nnoremap <F3> :set hlsearch!<CR>
" - Disable ex mode.
map Q <nop>
" - Toggle line numbers.
nmap <F11> :set number!<CR>
" - Disable help key.
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Backup dir.
set directory=~/.vim/backup//
set backupdir=~/.vim/backup//

" Characters to use in list mode.
set listchars=tab:│\ ,trail:·
set list                                            " Print all characters.

" Search.
set incsearch
set ignorecase
set smartcase
set hls                                             " Highlight all pattern matches.
nmap <silent> <Leader>n :nohl<CR>
set gdefault                                        " Global match by default.

" Spellcheck.
set spelllang=en,nl
nmap :ss :set spell<CR>
nmap :uss :set nospell<CR>

" Color scheme.
set t_Co=256                                        " Color terminal.
colorscheme adventurous

" sudo write file.
cmap w!! w !sudo tee % > /dev/null

" Plugin: airline.
let g:airline_theme = "lucius"
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" Plugin: NERDTree.
nmap <silent> <Leader>h :call TreeOpenFocus()<CR>
nmap <silent> <Leader>H :NERDTreeToggle<CR>
function! TreeOpenFocus()
    let currentwin = winnr()
    let wnr = bufwinnr("NERD_tree_1")
        if wnr == -1
            :NERDTreeToggle
        else
            if wnr == currentwin
                exec "wincmd w"
            else
                exec wnr."wincmd w"
            endif
        endif
endfunction
let g:NERDTreeWinPos = "right"

" Plugin: ctrlp.
nmap <silent> <Leader>o :CtrlP<CR>
nmap <silent> <Leader>s :CtrlPBuffer<CR>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_max_height = 15
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/](\.git|\.hg|\.svn|app/cache|vendor)$',
\ 'file': '.pyc',
\ }
let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("k")':   ['<c-k>', '<up>', '<tab>'],
  \ }

" Plugin: MRU.
nmap <silent> <Leader>r :MRU<CR>
let MRU_Window_Height = 12
let g:pymode_lint_hold = 0

" Plugin: Yankring.
let g:yankring_history_file = '.yankring_history'
nmap <leader>y :YRShow<cr>

" Plugin: BClose.
nmap <silent> <Leader>d :Bclose<CR>
nmap <silent> <Leader>D :Bclose!<CR>

" Plugin: Tabular.
nmap <leader><tab><tab> :Tab /
vmap <leader><tab> :Tab /
nmap <leader><tab>= :Tab /=<cr>
vmap <leader><tab>= :Tab /=<cr>
nmap <leader><tab>: :Tab /:\zs<cr>
vmap <leader><tab>: :Tab /:\zs<cr>
nmap <leader><tab>> :Tab /=><cr>
vmap <leader><tab>> :Tab /=><cr>

" Plugin: Syntastic.
let g:syntastic_go_checkers = ['golint', 'govet', 'gometalinter', 'gofmt']
let g:syntastic_go_gometalinter_args = ['--disable-all', '--enable=errcheck']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '!'
let g:syntastic_warning_symbol = '?'
highlight SyntasticErrorLine guibg = #5c0b09

" Plugin: Supertab.
let g:SuperTabDefaultCompletionType = "context"

" Plugin: Tagbar.
nmap <silent> <leader>t :TagbarOpen fj<CR>
nmap <silent> <leader>T :TagbarClose<CR>

" Plugin: TaskList.
nmap <leader>T <Plug>TaskList

" Plugin: vim-go.
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" Plugin: jedi-vim.
let g:jedi#goto_assignments_command = "<leader>G"
let g:jedi#goto_definitions_command = "<leader>E"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>N"
let g:jedi#rename_command = "<leader>R"

" Plugin: htmljinja.
if has('autocmd')
  au BufRead,BufNewFile *.twig setlocal filetype=htmljinja
endif
