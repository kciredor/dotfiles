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
" Code snippets
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
" Code completion
"Bundle 'kana/vim-smartinput'
"Bundle 'Townk/vim-autoclose'
"Bundle 'tpope/vim-surround'
" Syntax checking
Bundle 'scrooloose/syntastic'
Bundle 'groenewege/vim-less'
" Twig / Jinja templating syntax
Bundle 'estin/htmljinja'
" Javascript support
Bundle 'pangloss/vim-javascript'
" Scala support
Bundle 'derekwyatt/vim-scala'
" Coffeescript support
Bundle 'kchmck/vim-coffee-script'
" Source listing
Bundle 'majutsushi/tagbar'
" PHP Completion
"Bundle 'EvanDotPro/phpcomplete.vim'
" Python support
"Bundle 'klen/python-mode'
" PHP-Cs-Fixer
Bundle 'stephpy/vim-php-cs-fixer'
" Close buffer leaving window alone
Bundle 'rbgrouleff/bclose.vim'
" Google calendar ;)
"Bundle 'itchyny/calendar.vim'

" General config
set encoding=utf-8                                  " 1/2 encoding
scriptencoding utf-8                                " 2/2 encoding
filetype plugin on                                  " filetype specific plugin loading
filetype indent on                                  " filetype specific indent
set autoindent                                      " keeps the indent of a previous line when starting a new one
set sta                                             " enables smarttab: makes autoindent expand tab to shiftwidth nr of spaces
set sw=4 ts=4                                       " shift width, tab stop
set expandtab                                       " makes a tab a series of spaces
syntax on                                           " syntax coloring
set nu                                              " enable linenumbers
set ruler                                           " display the current cursor position in the lower right corner
set history=1000                                    " command history
set wildmenu                                        " command completion menu
set title                                           " set window title
set laststatus=2                                    " always show statusbar
set scrolloff=3                                     " nr of lines on the edge to scroll
set showcmd                                         " show commands during typing
set pastetoggle=<F10>                               " enable paste
set hidden                                          " buffer switching without saving
set vb t_vb=                                        " disable beep / flash

" Editor
" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" sort css upto }
noremap <silent> <Leader>s :.,/}/sort<CR>:nohl<CR>

" Extension based tab stops (home)
" autocmd FileType html :setlocal expandtab!
" autocmd FileType css :setlocal expandtab!
" autocmd FileType sass :setlocal expandtab!
" autocmd FileType less :setlocal expandtab!
" autocmd FileType coffee :setlocal sw=2 ts=2

" Extension based tab stops (office)
autocmd FileType coffee :setlocal sw=2 ts=2
autocmd FileType less :setlocal sw=2 ts=2

" Key mapping
" leader
let mapleader=","
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
" f7 / f8 paste / nopaste
nnoremap <F7> :set paste<CR>
nnoremap <F8> :set nopaste<CR>

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
if $TERM == 'linux'
    colorscheme delek
else
    set t_Co=256                                    " color terminal
    colorscheme molokai
    let g:molokai_original = 1
    set background=dark
endif

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

" snipMate: reload all snippets
"nmap <Leader>r :call ReloadAllSnippets()<CR>

" php-cs-fixer
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()
let g:php_cs_fixer_path = get(g:, 'php_cs_fixer_path', '/usr/local/bin/php-cs-fixer.phar')
let g:php_cs_fixer_enable_default_mapping = 0

" syntastic
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_python_checker_args = '--rcfile=~/.pylintrc'
let g:syntastic_check_on_open=0
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='!'
let g:syntastic_warning_symbol='?'
highlight SyntasticErrorLine guibg=#5c0b09

" airline
let g:airline_theme="luna"
let g:airline_powerline_fonts=0
" airline tabs
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" tagbar
nmap <silent> <leader>t :TagbarOpen fj<CR>
nmap <silent> <leader>T :TagbarClose<CR>

" jinja
if has('autocmd')
  au BufRead,BufNewFile *.twig        setlocal filetype=htmljinja
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

" python-mode
" let g:pymode_folding=0
" let g:pymode_syntax_slow_sync=0
" let g:pymode_rope_guess_project=0
" let g:pymode_paths=['~/src']
" let g:pymode_lint=0
" let g:pymode_lint_config = "$HOME/.pylintrc"

" google calendar
"let g:calendar_google_calendar = 1
"let g:calendar_google_task = 1
