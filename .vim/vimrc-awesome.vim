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
Plugin 'gmarik/Vundle.vim'

" My bundles here:

" Vim-Slime
Plugin 'jpalardy/vim-slime'
" Vim-Slime Config {{{
    let g:slime_python_ipython = 1
    let g:slime_target = "tmux"
" }}}

" Neocomplcache
Plugin 'Shougo/neocomplcache.vim'

" Unite
Plugin 'Shougo/unite.vim'
" Vimproc needs to be compiled manually
Plugin 'Shougo/vimproc.vim' 
" For MRU features with unite.vim
Plugin 'Shougo/neomru.vim' 

" UltiSnips
Plugin 'SirVer/ultisnips'
" UltiSnips Snippets 
Plugin 'honza/vim-snippets'

Plugin 'LaTeX-Box-Team/LaTeX-Box'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'jamessan/vim-gnupg'
Plugin 'w0ng/vim-hybrid'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'

Plugin 'sjl/gundo.vim'

Plugin 'ivanov/vim-ipython'

Plugin 'godlygeek/tabular'

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

" Plugin: Unite {{{

let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <leader>t :<C-u>Unite -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <leader>f :<C-u>Unite -buffer-name=files   -start-insert file<cr>
nnoremap <leader>r :<C-u>Unite -buffer-name=mru     -start-insert file_mru<cr>
nnoremap <leader>o :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<cr>
nnoremap <leader>y :<C-u>Unite -buffer-name=yank    history/yank<cr>
nnoremap <leader>e :<C-u>Unite -buffer-name=buffer  buffer<cr>

" Custom mappings for the unite buffer
autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  " Enable navigation with control-j and control-k in insert mode
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction
"
" }}}

" Plugin: LaTeX-Box {{{
let g:LatexBox_latexmk_options="--shell-escape --enable-write18"
let g:LatexBox_Folding=0
let g:LatexBox_fold_envs=0

" SyncTeX with Zathura
" Enable Forward Search
let g:LatexBox_viewer= '/usr/bin/zathura --fork --synctex-editor-command "vim --servername VIM --remote +\%{line} \%{input}"' 

" Enable Reverse Search
" There's a mapping for forward searching in ~/.vim/ftplugin/tex.vim
" }}}

" Plugin: Ultisnips" {{{
    let g:UltiSnipsSnippetDirectories=["MyUltiSnips","UltiSnips"]
    let g:UltiSnipsDontReverseSearchPath="1"
    let g:UltiSnipsExpandTrigger="<C-L>"
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
" }}}

" Plugin: NERDTree {{{
nmap <silent> ,n :NERDTreeToggle<CR>
"nmap <silent> ,nc :NERDTreeCWD<CR>
" }}}

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

" Plugin: Gundo {{{
nnoremap <Leader>gu :GundoToggle<CR>
" }}}

" Plugin: neocomplcache {{{
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

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


"  vim: foldmethod=marker foldclose=all
