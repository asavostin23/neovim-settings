" CONFIG ---------------------------------------------------------------- {{{

" Colorsheme
colorscheme torte

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on

" Enable plugins and load plugin for the detected file type.
filetype plugin on

" Load an indent file for the detected file type.
filetype indent on

" Enable syntax highlighting
syntax on

" Add numbers to each line on the left-hand side.
set number

" Highlight cursor line underneath the cursor horizontally.
set cursorline

" Don't Highlight cursor line underneath the cursor vertically.
set nocursorcolumn

" Set shift width to 4 spaces.
set shiftwidth=4

" Set tab width to 4 columns.
set tabstop=4

" Use space characters instead of tabs.
set expandtab

" Do not save backup files.
set nobackup

" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10

" Do not wrap lines. Allow long lines to extend as far as the line goes.
set nowrap

" While searching though a file incrementally highlight matching characters as you type.
set incsearch

" Ignore capital letters during search.
set ignorecase

" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase

" Show partial command you type in the last line of the screen.
set showcmd

" Show the mode you are on the last line.
set showmode

" Show matching words during a search.
set showmatch

" Use highlighting when doing a search.
set hlsearch

" Set the commands to save in history default number is 20.
set history=100

" Enable auto completion menu after pressing TAB.
set wildmenu

" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest

" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

" Lazy screen drawing on script processing
set lz

" Encodings and file formats order
set ffs=unix,dos,mac
set fencs=utf-8,cp1251,koi8-r,ucs-2,cp866

" Turn off mouse if not GUI
if !has('gui_running')
    set mouse=
endif

" Vertical split to the right 
set splitright

" Split to the bottom
set splitbelow

" Change working dir automatically
set autochdir

" }}}

" PLUGINS ---------------------------------------------------------------- {{{

" Autoinstall VimPlug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin code goes here.
call plug#begin()

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'OmniSharp/omnisharp-vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'dense-analysis/ale'
Plug 'ap/vim-buftabline'
" Plug 'asavostin23/vim-cyberpunk'
Plug 'dyng/ctrlsf.vim'

Plug 'bluz71/vim-moonfly-colors', { 'as': 'moonfly' }

call plug#end()

colorscheme moonfly
" }}}

" MAPPINGS --------------------------------------------------------------- {{{

" Press the space bar to type the : character in command mode.
nnoremap <space> :

" Pressing the letter o will open a new line below the current one.
" Exit insert mode after creating a new line above or below the current line.
nnoremap o o<esc>
nnoremap O O<esc>

" Center the cursor vertically when moving to the next word during a search.
nnoremap n nzz
nnoremap N Nzz

" Yank from cursor to the end of line.
nnoremap Y y$

" You can split the window in Vim by typing :split or :vsplit.
" Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize split windows using arrow keys by pressing:
" CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
noremap <c-up> <c-w>+
noremap <c-down> <c-w>-
noremap <c-left> <c-w><
noremap <c-right> <c-w>>

" Map the F3 key to toggle NERDTree open and close.
nnoremap <silent> <F3> :NERDTreeToggle<cr>

" Configure Buftabline
" set hidden
" nnoremap <C-N> :bnext<CR>
" nnoremap <C-P> :bprev<CR>

" Exit terminal
tnoremap <Esc> <C-\><C-n>

" Simulate i_CTRL-R in terminal
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" }}}

" VIMSCRIPT -------------------------------------------------------------- {{{

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Maximize window
if has('gui')
    if has('win32')
        au GUIEnter * call libcallnr('maximize', 'Maximize', 1)
    elseif has('gui_gtk2')
        au GUIEnter * :set lines=99999 columns=99999
    endif
endif

" Have nerdtree ignore certain files and directories.
let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
    autocmd!
    autocmd WinLeave * set nocursorline nocursorcolumn
    autocmd WinEnter * set cursorline cursorcolumn
augroup END

" Use cyberpunk theme
" set termguicolors
" colorscheme cyberpunk
" let g:airline_theme='cyberpunk2077'
" call HighlightFor("CursorLineNr",   "#140007", "#FF0055", "NONE")

" Configure OmniSharp
let g:OmniSharp_server_use_mono = 0
let g:OmniSharp_server_use_net6 = 1
let g:OmniSharp_selector_ui = 'fzf'    " Use fzf
let g:OmniSharp_selector_findusages = 'fzf'

" Configure ALE
let g:ale_linters = {
\ 'cs': ['OmniSharp']
\}

" }}}

" STATUS LINE ------------------------------------------------------------ {{{



" }}}
