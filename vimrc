" Vundle setup
set nocompatible                                    " viMproved
filetype off                                        " required by Vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle bundles: original repos on github
Bundle 'gmarik/vundle'
" Colorscheme
Bundle 'tomasr/molokai'
" File lookup
Bundle 'scrooloose/nerdtree'
Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/mru.vim'
" Git support
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
" Status bar pimp
Bundle 'bling/vim-airline'
" Tabular aligning
Bundle 'godlygeek/tabular'
" Better yanking
Bundle 'vim-scripts/YankRing.vim'
" Syntax checking
Bundle 'scrooloose/syntastic'
Bundle 'groenewege/vim-less'
" Twig / Jinja templating syntax
Bundle 'estin/htmljinja'
" Python support
Bundle 'ervandew/supertab'
Bundle 'davidhalter/jedi-vim'
" Go support.
Bundle 'fatih/vim-go'
" Javascript support
Bundle 'pangloss/vim-javascript'
" Ruby support (MSF)
Bundle 'vim-ruby/vim-ruby'
" Source listing
Bundle 'majutsushi/tagbar'
" Close buffer leaving window alone
Bundle 'rbgrouleff/bclose.vim'
" Todo, fixme listing
Bundle 'vim-scripts/TaskList.vim'

" General config
filetype plugin indent on                           " filetype specific plugin/indent loading
scriptencoding utf-8                                " force utf-8
set encoding=utf-8
set termencoding=utf-8
set autoindent                                      " keeps the indent of a previous line when starting a new one
set sta                                             " enables smarttab: makes autoindent expand tab to shiftwidth nr of spaces
set sw=4 ts=4                                       " shift width, tab stop
set colorcolumn=80                                  " try to stay below 80 chars, regardless of filetype
set expandtab                                       " makes a tab a series of spaces
syntax on                                           " syntax coloring
set nu                                              " enable linenumbers
set ruler                                           " display the current cursor position in the lower right corner
set history=1000                                    " command history
set wildmenu                                        " command completion menu
set wildmode=longest:full,full
set completeopt=longest,menuone,preview             " proper omnicompletion
set title                                           " set window title
set laststatus=2                                    " always show statusbar
set scrolloff=3                                     " nr of lines on the edge to scroll
set showcmd                                         " show commands during typing
set pastetoggle=<F10>                               " enable paste
set hidden                                          " buffer switching without saving
set vb t_vb=                                        " disable beep / flash
set ttyfast                                         " faster refresh etc.
set showmatch                                       " show matching brace
set matchtime=1
set shortmess+=I                                    " disable vim opening screen.
if executable("/usr/bin/zsh")
    set shell=/usr/bin/zsh
endif

" Editor
" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" sort css upto }
noremap <silent> <Leader>s :.,/}/sort<CR>:nohl<CR>

" Extension based tab stops (home)
autocmd BufRead,BufNewFile *.html,*.css,*.less,*.sass,*.jsp setlocal expandtab!
autocmd BufRead,BufNewFile *.coffee *.pp *.yml *.yaml setlocal sw=2 ts=2
autocmd BufRead,BufNewFile *.py let &colorcolumn = "80,".join(range(101,999),",") " try to stay below 80 chars, max 100 (python)

" Key mapping
" leader
let mapleader = ","
" map move keys
nmap <silent> <C-n> :tabprev<CR>
nmap <silent> <C-.> :tabnext<CR>
nmap <silent> <C-h> :bprev<CR>
nmap <silent> <C-l> :bnext<CR>
" make Y effect to end of line instead of whole line
nmap Y y$
" return to visual mode after indenting
xmap < <gv
xmap > >gv
" backspace behavior
set backspace=indent,eol,start
" window mapping
nmap <Left> <C-w>h
nmap <Down> <C-w>j
nmap <Up> <C-w>k
nmap <Right> <C-w>l
" swap ' and `
noremap ' `
noremap ` '
" f3 clears search marking
nnoremap <F3> :set hlsearch!<CR>
" disable ex mode
map Q <nop>
" toggle line numbers.
nmap <F11> :set number!<CR>
" disable help key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Backup dir
set directory=~/.vim/backup//
set backupdir=~/.vim/backup//

" Characters to use in list mode
set listchars=tab:│\ ,trail:·
set list                                            " print all characters

" Search
set incsearch
set ignorecase
set smartcase
set hls                                             " highlight all pattern matches
nmap <silent> <Leader>n :nohl<CR>
set gdefault                                        " global match by default

" Spellcheck
set spelllang=en,nl
nmap :ss :set spell<CR>
nmap :uss :set nospell<CR>

" Color schemes
set t_Co=256                                        " color terminal
colorscheme molokai
let g:molokai_original = 1
set background=dark

" App specific

" NERDTree
nmap <silent> <Leader>h :call TreeOpenFocus()<CR>
nmap <silent> <Leader>H :NERDTreeToggle<CR>
nmap <silent> <Leader>d :Bclose<CR>
nmap <silent> <Leader>D :Bclose!<CR>
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

" ctrlp
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

" mru
nmap <silent> <Leader>r :MRU<CR>
let MRU_Window_Height = 12
let g:pymode_lint_hold = 0

" syntastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '!'
let g:syntastic_warning_symbol = '?'
highlight SyntasticErrorLine guibg = #5c0b09

" airline
let g:airline_theme = "luna"
let g:airline_powerline_fonts = 0
" airline tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" tagbar
nmap <silent> <leader>t :TagbarOpen fj<CR>
nmap <silent> <leader>T :TagbarClose<CR>

" jinja
if has('autocmd')
  au BufRead,BufNewFile *.twig setlocal filetype=htmljinja
endif

" yankring
let g:yankring_history_file = '.yankring_history'
nmap <leader>y :YRShow<cr>

" buftabs
let g:buftabs_only_basename = 1

" tabular
nmap <leader><tab><tab> :Tab /
vmap <leader><tab> :Tab /
nmap <leader><tab>= :Tab /=<cr>
vmap <leader><tab>= :Tab /=<cr>
nmap <leader><tab>: :Tab /:\zs<cr>
vmap <leader><tab>: :Tab /:\zs<cr>
nmap <leader><tab>> :Tab /=><cr>
vmap <leader><tab>> :Tab /=><cr>

" supertab
let g:SuperTabDefaultCompletionType = "context"

" jedi-vim
let g:jedi#goto_assignments_command = "<leader>G"
let g:jedi#goto_definitions_command = "<leader>D"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>N"
let g:jedi#rename_command = "<leader>R"

" tasklist
nmap <leader>T <Plug>TaskList

" vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" virtualenv / django completion
let django_settings_file = system('find . -maxdepth 2 -name settings.py')
if !empty(django_settings_file)
  execute 'python import os, sys'
  execute 'python sys.path.append("v/lib/python2.7/site-packages")'
  let outarray = split(django_settings_file, '[\/]\+')
  let django_module = outarray[-2] . '.' . 'settings'
  execute 'python os.environ.setdefault("DJANGO_SETTINGS_MODULE", "' . django_module . '")'
endif
