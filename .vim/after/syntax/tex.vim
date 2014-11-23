
" LuaTeX Syntax Highlighting {{{
if exists("b:current_syntax")
    unlet b:current_syntax
endif

syn include @LUA syntax/lua.vim

syn region LuaTeXSnippet matchgroup=LuaTeXIdentifier
    \ start='\\begin{\z(luacode\|luacode*\)}'
    \ end='\\end{\z1}'
    \ contains=@LUA

syn region LuaTeXSnippet matchgroup=LuaTeXIdentifier
    \ start='\\\(directlua\|luadirect\){'
    \ end='}'
    \ contains=@LUA

highlight link LuaTeXSnippet SpecialComment
" }}}
