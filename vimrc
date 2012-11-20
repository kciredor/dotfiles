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
" Git support
Bundle 'tpope/vim-fugitive'
" Status bar pimp
Bundle 'Lokaltog/vim-powerline'
" Tabular aligning
Bundle 'godlygeek/tabular'
" Better yanking
Bundle 'vim-scripts/YankRing.vim'
" Code snippets
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/snipmate-snippets'
Bundle 'garbas/vim-snipmate'
" Code completion
"Bundle 'kana/vim-smartinput'
"Bundle 'Townk/vim-autoclose'
"Bundle 'tpope/vim-surround'
" Less CSS syntax
Bundle 'groenewege/vim-less'
" Twig / Jinja templating syntax
Bundle 'estin/htmljinja'
" Javascript support
Bundle 'pangloss/vim-javascript'
" Scala support
Bundle 'derekwyatt/vim-scala'
" Source listing
Bundle 'majutsushi/tagbar'
" PHP Completion
"Bundle 'EvanDotPro/phpcomplete.vim'
" PHP-Cs-Fixer
Bundle 'stephpy/vim-php-cs-fixer'
" Buffer tab system
Bundle 'vim-scripts/buftabs'
" Close buffer leaving window alone
Bundle 'rbgrouleff/bclose.vim'

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

" Editor
" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" sort css upto }
noremap <silent> <Leader>s :.,/}/sort<CR>:nohl<CR>

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

"" ctrlp
nmap <silent> <Leader>o :CtrlP<CR>
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_working_path_mode = 'rc'
let g:ctrlp_max_height = 15
let g:ctrlp_custom_ignore = {
\ 'dir':  '\v[\/](\.git|\.hg|\.svn|app/cache|vendor)$'
\ }

let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("k")':   ['<c-k>', '<up>', '<tab>'],
  \ }

" snipMate: reload all snippets
"nmap <Leader>r :call ReloadAllSnippets()<CR>

" php-cs-fixer
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()
let g:php_cs_fixer_path = get(g:, 'php_cs_fixer_path', '/usr/local/bin/php-cs-fixer.phar')
let g:php_cs_fixer_enable_default_mapping = 0

" powerline
let g:Powerline_symbols = 'unicode'

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
