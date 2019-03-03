" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Session management {{{
    " Save current session
    "map <F5> :call SaveCurrentSession()<CR>
    " Attempt to load current session
    " autocmd vimenter * if !argc() && v:this_session == "" | exec "source ~/.vimsession" | endif
    map <F9> :source ~/.vimsession<CR>
"}}}

"Vundle - load plugins. Run command "vim +PluginInstall! +qa" {{{
set nocompatible              " be iMproved, required

filetype off                  " required



" set the runtime path to include Vundle and initialize

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" alternatively, pass a path where Vundle should install plugins

"call vundle#begin('~/some/path/here')



" let Vundle manage Vundle, required

Plugin 'VundleVim/Vundle.vim'
" Color schemes {{{
" Attempt at 256 colors
set t_Co=256
" attempt at clearing background for different color backgrounds!
set t_ut=
Plugin 'jnurmine/Zenburn'
Plugin 'tpope/vim-vividchalk'

" Vim5 and later versions support syntax highlighting. Uncommenting the
" following enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

if has('gui_running')
  colorscheme zenburn
else
  set background="light"
  "colorscheme vividchalk
  colorscheme zenburn
endif
"}}}

" Nerdtree {{{
    Plugin 'scrooloose/nerdtree'
    let NERDTreeShowHidden=1 "show hidden files
    autocmd vimenter * if !argc() | NERDTree | endif " Open tree automatically if no files specified, and we haven't loaded from a session
    " f7 to open file explorer for nerdtree
    nmap <F7> :NERDTreeToggle<CR>
    " Ignore git directory, c object files, java class files, and others that we do not want displayed in the tree
    let NERDTreeIgnore=['.git$[[dir]]', '.o$[[file]]', '.class$[[file]]','.swp$[[file]]','.swo$[[file]]']
" }}}

"Tagbar {{{
Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
"}}}

" Syntastic! ...and I suppose eclim can go in here, these are similar{{{
Plugin 'scrooloose/syntastic'
let g:syntastic_java_javac_config_file_enabled=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
" }}}
" Eclim settings, if eclim is installed {{{
let g:EclimQuickfixSignText='✗'
let g:EclimLocListSignText='⚠'
map <F3> :JavaSearchContext<cr>
" }}}

" Let ^A/^X work on date/timestamps
Plugin 'tpope/vim-speeddating'

" Markdown syntax files
Plugin 'tpope/vim-markdown'

" re/un/wrap manipulation
Plugin 'tpope/vim-surround'
map <leader>t ysiw

" Extend bracket mappings, including [b, ]b for previous and next buffers
Plugin 'tpope/vim-unimpaired'
" Extend to include base 64 encoding/decoding
vnoremap [Y c<c-r>=system('base64 ', @")<cr><esc>
vnoremap ]Y c<c-r>=system('base64 --decode', @")<cr><esc>

" Enable repeating various other tpope (surround, speeddating, abolish,
" unimpaired) with .
Plugin 'tpope/vim-repeat'

" Tabular!
Plugin 'godlygeek/tabular'

" Indexed Search!
Plugin 'vim-scripts/IndexedSearch'

" Git commands!
Plugin 'tpope/vim-fugitive'

" MiniBufExplorer and buffer settings{{{
Plugin 'fholgado/minibufexpl.vim'
let g:miniBufExplBuffersNeeded=100 "hide screen until there are 100 buffers. Hoping this never happens. Essencially manual mode
let g:miniBufExplUseSingleClick = 1 "single click to swap
map <F6> :MBEToggleAll<cr>


" Use ctrl-[hjkl] to select the active split!
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

" bclose - keeps windows when closing buffers
Plugin 'bcaccinolo/bclose'
"close buffer 
map <leader>d :Bclose!<cr> 
"map <leader>d :MBEbd!<cr> "MBE close sometimes threw errors and we no likie.

map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>
" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
" }}}

" Visual Star Search
Plugin 'nelstrom/vim-visual-star-search'

" autocomplete! see readme for details for installation. It's pretty awesome.
Plugin 'Valloric/YouCompleteMe'
" if under eclim, lets YouCompleteMe and eclim play nice
let g:EclimCompletionMethod = 'omnifunc'

" Vdebug is a debbuger fo the DGP debugging protocol.
" Using mostly for xdebug and PHP, but works for multiple languages.
Plugin 'joonty/vdebug'

" floobits -- code sharing?
" Plugin 'Floobits/floobits-vim'
" floobits likes YouCompleteMe to reduce updatetime so that code is more in sync
" let g:ycm_allow_changing_updatetime=0

"Folds {{{
set foldmethod=marker
set foldlevel=99 "folds open by default
set foldcolumn=3
" }}}

" Strip trailing whitespace with <leader>$ {{{
nnoremap <leader>$ :call <SID>StripTrailingWhitespaces()<CR>
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }}}

" Paste {{{
set pastetoggle=<F2>
" }}}

" Invisibles {{{
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59
" }}}

" VIM user interface {{{
" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" wildignorecase - :e document to become Document!
set wildignorecase

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l


" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set hlsearch            " Highlight search results
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
set relativenumber
if has("autocmd")
    autocmd FocusLost * :set number
    autocmd InsertEnter * :set number
    autocmd InsertLeave * :set relativenumber
    autocmd CursorMoved * :set relativenumber
endif
set matchpairs+=<:>     " match on HTML/xml pairs

" For regular expressions turn magic on
set magic

" Set to auto read when a file is changed from the outside
set autoread

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" }}}

" Text, tab and indent related {{{
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines
" }}}

" Files, backups {{{
set nobackup
set nowb
set noswapfile
" }}}


" Status line {{{
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%{fugitive#statusline()}%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
"syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" }}}

" Helpers {{{
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

function! SaveCurrentSession()
    " Close nerd tree, it causes buffer issues
    exec "NERDTreeClose"
    " Create a session, if none exists
    if v:this_session == '' | let v:this_session = '~/.vimsession' | endif
    if v:this_session != '' | exec "mks! " . v:this_session | endif
    echo "session saved to " . v:this_session
endfunction
" }}}

"vdbug functions

map <F5> :VdebugCommandRun<CR>
" All of your Plugins must be added before the following line

call vundle#end()            " required

filetype plugin indent on    " required
