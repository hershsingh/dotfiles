" Author: Hersh Singh [hershdeep@gmail.com]
" Date: November 28, 2013
" vimrc-more: Bundles and Custom Functions
" Notes {{{
" - Always use augroup for autocommands.
"   }}}

" Plugin: LaTeX-Box [before loading the plugin] {{{
" Needs to be called before LaTeX-Box is invoked, so that it does not set up
" the autocommands for matching parenthesis on every CursorMoved event. Speeds
" up stuff.
let g:LatexBox_loaded_matchparen=1
" }}}

" Vundle: Load the plugins! "{{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

" My bundles here:

" UltiSnips
Plugin 'SirVer/ultisnips'
" UltiSnips Snippets 
Plugin 'honza/vim-snippets'

Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
"Plugin 'vim-scripts/YankRing.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'jamessan/vim-gnupg'
Plugin 'w0ng/vim-hybrid'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.
"}}}

" Plugin: LaTeX-Box {{{
" Disable 'matching $' feature - causes high CPU usage with larger files
let g:LatexBox_latexmk_options="--shell-escape --enable-write18"
let g:LatexBox_Folding=0
let g:LatexBox_fold_envs=0

" SyncTeX with Zathura
let g:LatexBox_viewer= '/usr/bin/zathura --fork -s -x "vim --servername " . v:servername . " --remote +\%{line} \%{input}"' 
nnoremap <expr><buffer> <LocalLeader>ls ':LatexView  ' . '--synctex-forward ' . line(".") . ":" . col(".") . ":" . expand('%:p') . '<CR>'
" }}}

" Plugin: Ultisnips" {{{
    let g:UltiSnipsSnippetDirectories=["MyUltiSnips","UltiSnips"]
    let g:UltiSnipsDontReverseSearchPath="1"

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
" }}}

" Plugin: CtrlP.vim"{{{
set runtimepath^=~/.vim/bundle/ctrlp.vim

let g:ctrlp_follow_symlinks = 1
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_clear_cache_on_exit = 0

nnoremap <Tab> :CtrlPBuffer<CR>
nnoremap <Leader>o :CtrlP<CR>
"}}}

" Plugin: NERDTree {{{
nmap <silent> ,n :NERDTreeToggle<CR>
"nmap <silent> ,nc :NERDTreeCWD<CR>
" }}}

" Plugin: YankRing"{{{
nnoremap <Leader>p :YRShow<CR>
let g:yankring_history_dir = '$HOME/.vim/'
"}}}

" Plugin: Syntastic "{{{
nnoremap <F3> :SyntasticToggleMode<CR>
"}}}

" Plugin: GnuPG  {{{
" http://pig-monkey.com/2013/04/4/password-management-vim-gnupg/
" Tell the GnuPG plugin to armor new files.
let g:GPGPreferArmor=1

" Use symmetric cipher for new files
let g:GPGPreferSymmetric=1

"" Tell the GnuPG plugin to sign new files.
"let g:GPGPreferSign=1

augroup GnuPGExtra
" Set extra file options.
    autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
" Automatically close unmodified files after inactivity.
    autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function! SetGPGOptions()
" Set updatetime to 1 minute.
    set updatetime=60000
" Fold at markers.
    set foldmethod=marker
" Automatically close all folds.
    set foldclose=all
" Only open folds with insert commands.
    set foldopen=insert
endfunction
" }}}

" Plugin: Colorscheme Hybrid"{{{
    let g:hybrid_use_Xresources = 1 
    set background=dark 
    colorscheme hybrid
"}}}

" --- Non-Vundle Plugins ---
" Plugin: let-modeline {{{
" Stored in .vim/plugins/let-modeline.vim

" Loads FirstModeLine()
if !exists('*FirstModeLine')
    " :Runtime emules :runtime with VIM 5.x
    runtime plugin/let-modeline.vim
endif
if exists('*FirstModeLine')
    aug ALL
        au!
        " To not interfer with Templates loaders
        au BufNewFile * :let b:this_is_new_buffer=1
        " Modeline interpretation
        au BufEnter * :call FirstModeLine()
    aug END
endif
" }}}

" Disabled "{{{
"" Python Specific
"nnoremap <Leader>pp :w<CR>:!ipython2 %<CR>
"nnoremap <Leader>p3 :w<CR>:!ipython %<CR>
" inoremap \fn <C-R>=expand("%:p")<CR>
"}}}

" Personal
" Custom: Dokuwiki Notes Plugin "{{{
" should make this into a plugin for vim sometime.

augroup dokuwiki
    au!
    "BufRead is triggered before processing the modelines. Thats what I want.
    au BufNewFile,BufRead */data/pages/* :set filetype=dokuwiki
    " Set spell-check for dokuwiki documents
    au BufNewFile,BufRead */data/pages/* :set spell spelllang=en_us
augroup END

function! LuakitRefresher()
    let g:windowstr = input('Enter the window search string: ')
    if empty(g:windowstr)
        augroup LuakitRefresh
            au!
        augroup end
    else
        augroup LuakitRefresh
            au!
            au BufWritePost * execute 'silent !xdotool search ' . g:windowstr . ' key r 2>/dev/null 1>/dev/null'
        augroup end
    endif
endfunction

noremap <Leader>df :call FirefoxRefresher()<CR>
let g:dokufox_plugin=0
let g:dokufox_timeout=2000

function! FirefoxRefresher()
    let g:dokufox_plugin=!g:dokufox_plugin
    echo "FirefoxRefresher" g:dokufox_plugin?"enabled.":"disabled."
    if g:dokufox_plugin==1
        augroup FirefoxRefresh_AU
            au!
            au BufWritePost *doku/data/pages/* :call FirefoxRefresh()
            au BufEnter *doku/data/pages/* :call FirefoxSwitchTab()
            au BufDelete *doku/data/pages/* :call FirefoxDeleteTab()
            "au BufWinLeave *doku/data/pages/* :call FirefoxDeleteTab()
            "au BufHidden *doku/data/pages/* :call FirefoxDeleteTab()
        augroup end
    elseif g:dokufox_plugin==0
        augroup FirefoxRefresh_AU
            au!
        augroup end
    endif
endfunction

" This function switches the Firefox tab to the one corresponding to the
" current buffer. Opens a new tab if there isn't already one.
let g:dokuwikiBaseURL='http://localhost/doku' 
function! FirefoxSwitchTab()
    let url = g:dokuwikiBaseURL . '/' .  (join(split(resolve(expand("%:p:r")),"/")[5:],":"))
    "let url = g:dokuwikiBaseURL . '/doku.php?id=' .  (join(split(resolve(expand("%:p:r")),"/")[5:],":"))
    :execute 'silent !echo  ''switchToTabHavingURI("' . url . '", true);
        \ repl.quit();''  |
        \ nc -w 1 localhost 4242 2>&1 > /dev/null'
    " Awesome-wm shifts the focus to firefox when MozlRepl opens a new tab. I don't want that
    !echo 'awful.client.focus.history.previous()'|awesome-client
    redraw!
endfunction

function! FirefoxDeleteTab()
    let url = g:dokuwikiBaseURL . '/' .  (join(split(resolve(expand("%:p:r")),"/")[5:],":"))
    :execute 'silent !echo  ''switchToTabHavingURI("' . url . '", true);
        \ BrowserCloseTabOrWindow();
        \ repl.quit();''  |
        \ nc -w 1 localhost 4242 2>&1 > /dev/null'
    " Awesome-wm shifts the focus to firefox when MozlRepl opens a new tab. I don't want that
    !echo 'awful.client.focus.history.previous()'|awesome-client
    redraw!
endfunction

function! FirefoxRefresh()
     :execute 'silent !echo  ''vimYo = content.window.pageYOffset;
        \ vimXo = content.window.pageXOffset;
        \ BrowserReload();
        \ myInterval = setTimeout("content.window.scrollTo(vimXo,vimYo)",' . g:dokufox_timeout . ');
        \ repl.quit();''  |
        \ nc -w 1 localhost 4242 2>&1 > /dev/null'
    redraw!
endfunction

"}}}

" Custom Functions
" Function: CheckOpenVimrc"{{{
" Edit .vimrc mapping
nnoremap <F2> :tabedit ~/.vim/<CR>
nnoremap <S-F2> :source %<CR>:wq<CR>

" Open vimrc if not currently open, Save and source it if its open
if !exists("*CheckOpenVimrc")
    function! CheckOpenVimrc()
        if expand('%:p')==$MYVIMRC
            :wq
            :source $MYVIMRC
        else
            :tab drop $MYVIMRC
        endif
    endfunction
endif
"}}}
" Function: BashHistory"{{{
" a very neat function to return typed commands from bash history 
" (from the last 100 commands)
ca bashhist call BashHistory()
function! BashHistory()
    let command_search_string = input("enter the command search string: ")
    "set shortmess=+t
    :execute 'r!echo "history 100" | bash -i | grep -i ' .  command_search_string . ' | cut -d " " -f 5-'
    ":execute 'r!echo "history 100" | bash -i 2>/dev/null  | grep -i ' .  command_search_string . ' | cut -d " " -f 5-'
    "set shortmess-=t
    ":execute 'r!echo "history 100" | bash -i 2>/dev/null  | grep -i ' . command_search_string
    ":execute 'r!echo "history 100" | bash -i 2>/dev/null | sed -e "s/\x1b\[.//g" | grep -i ' . a:command_search_string
endfunction
"}}}
" Function: RangerChooser"{{{
" Use ranger to open file within the Vim session
"from Ranger man page
function! RangerChooser()
  exec "silent !ranger --choosefile=/tmp/chosenfile '" . expand("%:p:h") . "'"
  if filereadable('/tmp/chosenfile')
    "sed is used to make this compatible with filenames with spaces
    "tab drop: makes it a run_or_raise kind of opening.
    exec 'tab drop ' . system('sed ''s/\ /\\ /g'' /tmp/chosenfile') 
    call system('rm /tmp/chosenfile')
  endif
  redraw!
endfunction
map ,r :call RangerChooser()<CR>"}}}
" Function: WordCount {{{
function! WordCount()
    let s:old_status = v:statusmsg
    let position = getpos(".")
    exe ":silent normal g\<C-g>"
    let stat = v:statusmsg
    let s:word_count = 0
    if stat != '--No lines in buffer--'
        let s:word_count = str2nr(split(v:statusmsg)[11])
        let v:statusmsg = s:old_status
    end
    call setpos('.', position)
    return s:word_count 
endfunction

"}}}

" Plugin: vim-airline {{{
set laststatus=2 " Always display the statusline in all windows
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Show WordCount in Airline, needs the WordCount() function defined above
"let g:airline_section_z = '%3p%% %{g:airline_symbols.linenr}%#__accent_bold#%4l%#__restore__#:%3c WC:%{WordCount()}'
"}}}

"  vim: foldmethod=marker foldclose=all
