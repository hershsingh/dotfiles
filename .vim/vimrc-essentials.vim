" Author: Hersh Singh [hershdeep@gmail.com]
" Date: November 28, 2013
" vimrc - Vimrc Bare Essentials
"
" Some General Settings"{{{
set nocompatible    " Improved vi!
filetype on
filetype indent on
filetype plugin on
syntax on

" Persistant undo. Saves a lot of pain.
set undofile 

" Make sure you're using UTF-8.. Saves alot of pain later
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1
set fileformat=unix
set fileformats=unix

" Tabstops
set expandtab       " converts tab to spaces
set softtabstop=4   " treats multiple tabs as spaces for Backspace etc.
set shiftwidth=4
set tabstop=4

" Misc
set autoindent		" set auto indent on
set lazyredraw      " dont redraw while executing macros ?
set mouse=a	        " make the mouse work in all modes
set history=100     " Remember more! 

" Buffers
set hidden          " allow a buffer to be hidden without saving changes
"set switchbuf=usetab "now use :sb <buffer_name> to switch to that tab


" No backup files clutter
set nobackup
set noswapfile

" Tab completion in commandline
set wildmenu        " awesome enhanced TAB filename completion
set wildignore=*.o,*~,*.pyc,*.aux,*.dvi,*.fdb_latexmk,*.fls,*.log,*.out,*.pdf,*.synctex.gz,*.toc

" Search options
set magic           " magic for RegEx
set ignorecase 
set incsearch 
set hlsearch

" Visual Indicators
set ruler
set showcmd	        " display incomplete command at bottom-right corner
set showmatch       " type ( and then ) to see what happens 
"set cursorline      " Highlight the current line
set visualbell!	    " disables the annoying beep and beeps visually instead
set nu		        " show line numbers
set cmdheight=1     " height of the command menu
set so=7            " seven lines gap before/after the cursor while scrolling

" Aesthetics
set showbreak=↪     " Prettier line wrappings

" Text Visuals
set wrap            " wordwrap
set linebreak       " break lines only on chars specified by the 'breakat' option

" Movement Options
set backspace=eol,start,indent
"set whichwrap+=<,>,h,l      "wraps h,l keys 
"}}}

" {{{ Leader Key
nnoremap <Space> <nop>
let mapleader=" "
" }}}

" LaTex Settings {{{
let g:tex_flavor = "latex"
" }}}

" Encryption {{{
" Use as $ vim -x newfile.txt or in vim, :X 
" set cryptmethod=blowfish
" }}}

" GUI Settings {{{
set guifont=Inconsolata\ for\ Powerline\ Medium\ 12
set guioptions=aegirL
" }}}

" Return to last edit position when opening files "{{{
augroup RememberLastOpenPosition
    autocmd!
    autocmd BufReadPost *
         \ if line("'\"") > 0 && line("'\"") <= line("$") |
         \   exe "normal! g`\"" |
         \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%
"}}}

" Status line"{{{
" Always show the status line
set laststatus=2
"}}}

" Normal Mode: Movement "{{{
" Useful when working with long lines and wrapping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap gj j
vnoremap gk k
"}}}
" Normal Mode: Switch tabs "{{{
"nnoremap J gt
"nnoremap K gT
" nnoremap J :bn<CR>
" nnoremap K :bp<CR>
"}}}
" Normal Mode: Misc"{{{
" Join Lines
noremap <Leader>j J
" Spell Check Toggle
nnoremap \s :set spell!<CR>
"}}}

" General Mappings: Sane Behavior "{{{
" By default Y behaves like yy, which is stupid.
map Y y$
"vnoremap Y y$
" remap the : key to ;
noremap ; :
"}}}
" General Mappings: Misc"{{{
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
"}}}

" Insert Mode Mappings "{{{
" put the cursor in between ( and ) when you type ()
inoremap <Esc> <Esc>l
inoremap {} {}<Esc>i
inoremap () ()<Esc>i
inoremap [] []<Esc>i
inoremap '' ''<Esc>i
inoremap "" ""<Esc>i
inoremap <> <><Esc>i
"inoremap $$ $$<Esc>i
"}}}
" Insert Mode Autocomplete Mappings"{{{
"inoremap <C-k> <C-x><C-n>
"" Autocomplete box: Use j/k keys 
"inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
"inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
"" Autocomplete box: Use h to close without completion
"inoremap <expr> h ((pumvisible())?("\<C-e>"):("h"))        
"" Autocomplete box: Use l to close with completion
"inoremap <expr> l ((pumvisible())?("\<C-y>"):("l"))
"}}}

" Commandline Mappings "{{{
" Allow saving of files as root if I forget to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %
"}}}
" Commandline Abbreviations"{{{
ca te tabedit
"}}}

" Code folding mappings "{{{
nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf
"}}}

" Clipboard Copy/Paste Mappings"{{{
set clipboard=unnamedplus
"}}}

" Sprunge/ix.io Pastebin " {{{
" http://www.commandlinefu.com/commands/view/5458/quickly-share-code-or-text-from-vim-to-others.
" Uses the ix package from arch repo
command! -range=% Ix :<line1>,<line2>write !ix |xclip -selection c
command! -range=% Sprunge :<line1>,<line2>write !curl -F "sprunge=<-" http://sprunge.us |xclip -selection c
" }}}

highlight MyGroup ctermbg=red ctermfg=black
let m = matchadd("MyGroup", 'TODO')


"  vim: foldmethod=marker foldclose=all
