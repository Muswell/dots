" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","


" Use ctrl-[hjkl] to select the active split!
noremap <C-J>     <C-W>j
noremap <C-K>     <C-W>k
noremap <C-H>     <C-W>h
noremap <C-L>     <C-W>l

map <leader><space> :terminal<cr>
tnoremap <Esc> <C-\><C-n>
map <leader>v :vsplit<cr>
map <leader>b :split<cr>
map <leader>tn :tabnew<cr>
map <leader>tc :tabclose<cr>

map <leader>cd :cd %:p:h<cr>:pwd<cr>

if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd!
	autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.config/nvim/plugged')
	Plug 'SirVer/ultisnips' | Plug 'phux/vim-snippets'
	Plug 'ncm2/ncm2'
	Plug 'roxma/nvim-yarp'
	Plug 'roxma/vim-hug-neovim-rpc'
	Plug 'phpactor/phpactor', {'do': ':call phpactor#Update()', 'for': 'php'}
	Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
	Plug 'ncm2/ncm2-ultisnips'
	Plug 'StanAngeloff/php.vim', {'for': 'php'}
	Plug 'w0rp/ale'
	Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
	Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}
	Plug 'alvan/vim-php-manual', {'for': 'php'}
	Plug 'amiorin/vim-project'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
	Plug 'pbogut/fzf-mru.vim'
	" only show MRU files from within your cwd
	let g:fzf_mru_relative = 1
    Plug 'scrooloose/nerdtree'
    Plug 'tpope/vim-unimpaired'
    " Extend to include base 64 encoding/decoding
    vnoremap [Y c<c-r>=system('base64 ', @")<cr><esc>
    vnoremap ]Y c<c-r>=system('base64 --decode', @")<cr><esc>
    Plug 'vim-scripts/IndexedSearch'
    Plug 'fholgado/minibufexpl.vim'
    Plug 'tpope/vim-fugitive'
    "Plug 'vim-vdebug/vdebug'
    Plug 'vim-airline/vim-airline'
    Plug 'fatih/vim-go' " Amazing combination of features.
    Plug 'godoctor/godoctor.vim' " Some refactoring tools
    Plug 'jodosha/vim-godebug' " Debugger integration via delve
call plug#end()

""""""""""""""""""""""""""""""""""""""""""
" UlitSnips
""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" PHP7
let g:ultisnips_php_scalar_types = 1

""""""""""""""""""""""""""""""""""""""""""
" ncm2
""""""""""""""""""""""""""""""""""""""""""
augroup ncm2
	au!
	autocmd BufEnter * call ncm2#enable_for_buffer()
	au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
	au User Ncm2PopupClose set completeopt=menuone
augroup END

" parameter expansion for selected entry via Enter
inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")

" cycle through completion entries with tab/shift+tab
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"

""""""""""""""""""""""""""""""""""""""""""
" CTAGS
""""""""""""""""""""""""""""""""""""""""""
" update tags in background whenever you write a php file
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

""""""""""""""""""""""""""""""""""""""""""
" Ale
""""""""""""""""""""""""""""""""""""""""""
" disable linting while typing
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
  \}
let g:ale_fix_on_save = 1

""""""""""""""""""""""""""""""""""""""""""
" PHP Refactoring
""""""""""""""""""""""""""""""""""""""""""
let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"

let g:vim_php_refactoring_use_default_mapping = 0
nnoremap <leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap <leader>rcv :call PhpRenameClassVariable()<CR>
nnoremap <leader>rrm :call PhpRenameMethod()<CR>
nnoremap <leader>reu :call PhpExtractUse()<CR>
vnoremap <leader>rec :call PhpExtractConst()<CR>
nnoremap <leader>rep :call PhpExtractClassProperty()<CR>
nnoremap <leader>rnp :call PhpCreateProperty()<CR>
nnoremap <leader>rdu :call PhpDetectUnusedUseStatements()<CR>
nnoremap <leader>rsg :call PhpCreateSettersAndGetters()<CR>

""""""""""""""""""""""""""""""""""""""""""
" PHP Mapping
""""""""""""""""""""""""""""""""""""""""""
" context-aware menu with all functions (ALT-m)
nnoremap <m-m> :call phpactor#ContextMenu()<cr>

nnoremap gd :call phpactor#GotoDefinition()<CR>
nnoremap gr :call phpactor#FindReferences()<CR>

" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>
" extract variable
vnoremap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
nnoremap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
" extract interface
nnoremap <silent><Leader>rei :call phpactor#ClassInflect()<CR>
"Path to executable
let g:phpactor_executable = '~/.config/nvim/plugged/phpactor/bin/phpactor'

function! PHPModify(transformer)
    :update
    let l:cmd = "silent !".g:phpactor_executable." class:transform ".expand('%').' --transform='.a:transformer
    execute l:cmd
endfunction

nnoremap <leader>rcc :call PhpConstructorArgumentMagic()<cr>
function! PhpConstructorArgumentMagic()
    " update phpdoc
    if exists("*UpdatePhpDocIfExists")
        normal! gg
        /__construct
        normal! n
        :call UpdatePhpDocIfExists()
        :w
    endif
    :call PHPModify("complete_constructor")
endfunction

"Implement missing functions from Interface/Abstract class
nnoremap <leader>ric :call PHPModify("implement_contracts")<cr>
" Add missing propeties
nnoremap <leader>raa :call PHPModify("add_missing_properties")<cr>

"Moves the current file to a new path, updates references and namepaces. (default: current file)
nnoremap <leader>rmc :call PHPMoveClass()<cr>
function! PHPMoveClass()
    :w
    let l:oldPath = expand('%')
    let l:newPath = input("New path: ", l:oldPath)
    execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
    execute "bd ".l:oldPath
    execute "e ". l:newPath
endfunction

"Moves directory and updates namespaces. (default: current dir)
nnoremap <leader>rmd :call PHPMoveDir()<cr>
function! PHPMoveDir()
    :w
    let l:oldPath = input("old path: ", expand('%:p:h'))
    let l:newPath = input("New path: ", l:oldPath)
    execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
endfunction

"""""""""""""""""""""""""""""""""""""""
" Namespace Handling
"""""""""""""""""""""""""""""""""""""""
nnoremap <Leader>u :PHPImportClass<cr>
nnoremap <Leader>e :PHPExpandFQCNAbsolute<cr>
nnoremap <Leader>E :PHPExpandFQCN<cr>


" View the php manual for word under cursor
let g:php_manual_online_search_shortcut = '<leader>k'

""""""""""""""""""""""""""""""""""""""
" Projects
""""""""""""""""""""""""""""""""""""""
let g:project_use_nerdtree = 1
let g:project_enable_welcome = 1
set rtp+=~/.vim/bundle/vim-project/
call project#rc("~/dev")

Project 'tests/symfony-test', 'symfony-test'
Project 'tests/php-docker', 'php-docker'

" I prefer to have my project's configuration in a separate file
" so ~/.vimprojects
" nmap <leader><F2> :e ~/.vimprojects<cr>

""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""
nnoremap <leader><Enter> :FZFMru<cr>
" to enable found references displayed in fzf
let g:LanguageClient_selectionUI = 'fzf'

nnoremap <leader>s :Rg<space>
" word under cursor
nnoremap <leader>R :exec "Rg ".expand("<cword>")<cr>
" " search for visual selection
vnoremap // "hy:exec "Rg ".escape('<C-R>h', "/\.*$^~[()")<cr>

autocmd! VimEnter * command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --smart-case --line-number --color=always --no-heading --fixed-strings --follow --glob "!.git/*" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

nnoremap <leader>, :Files<cr>
" vertical split
nnoremap <leader>. :call fzf#run({'sink': 'e', 'right': '40%'})<cr>
nnoremap <leader>d :BTags<cr>
" word under cursor
nnoremap <leader>D :BTags <C-R><C-W><cr>
nnoremap <leader>S :Tags<cr>
" hit enter to jump to last buffer
nnoremap <leader><tab> :Buffers<cr>

"""""""""""""""""""""""""""""""""""""
" NerdTree
""""""""""""""""""""""""""""""""""""
"show hidden files
let NERDTreeShowHidden=1

" Open tree automatically if no files specified, and we haven't loaded from a session
autocmd vimenter * if !argc() | NERDTree | endif

" f7 to open file explorer for nerdtree
nmap <F7> :NERDTreeToggle<CR>

" Ignore git directory, c object files, java class files, and others that we do not want displayed in the tree
let NERDTreeIgnore=['.git$[[dir]]', '.o$[[file]]', '.class$[[file]]','.swp$[[file]]','.swo$[[file]]']

"""""""""""""""""""""""""""""""""
" Buffers
""""""""""""""""""""""""""""""""
"hide screen until there are 100 buffers. Hoping this never happens. Essencially manual mode
let g:miniBufExplBuffersNeeded=100
"single click to swap
let g:miniBufExplUseSingleClick = 1
map <F6> :MBEToggleAll<cr>

""""""""""""""""""""""""""""""""
" Invisibles
"""""""""""""""""""""""""""""""
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

"Invisible character colors
highlight NonText guifg=#4a4a59
highlight SpecialKey guifg=#4a4a59

""""""""""""""""""""""""""""""""""""""""""""""""""
" User Interface
""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" wildignorecase - :e document to become Document!
set wildignorecase

"Always show current position
set ruler

" Height of the command bar
set cmdheight=1

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
filetype plugin indent on

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
autocmd FocusLost * :set number
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber
autocmd CursorMoved * :set relativenumber
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

"""""""""""""""""""""""""""""""""""""
" Indentation
""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""
" Files and Backups
""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""
" Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

"""""""""""""""""""""""""""""""""
" Clipboard
""""""""""""""""""""""""""""""""
"set clipboard=unnamedplus

""""""""""""""""""""""""""""""""
" Vdebug
""""""""""""""""""""""""""""""""
"map <F5> :VdebugCommandRun<CR>
"let g:vdebug_options = {
"      \ 'port' : 9090,
"      \ 'server' : '',
"      \ 'path_maps': {
"        \ '/var/www/html/': '/home/sscanlon/dev/rws/aurora/'
"     \ }
"     \}
