" Custom imaps for vimtex
"call vimtex#imaps#add_map({
    "\ 'lhs_rhs' : ['--',    '^\{${1}\}${0}'], 
    "\ 'leader' : '',   
    "\ 'wrapper' : 's:wrap_math_snippet' })
"call vimtex#imaps#add_map(
        "\ { 'lhs_rhs' : ['S', '\sum'], 'wrapper' : 's:wrap_math'})
"call vimtex#imaps#add_map(
        "\ { 'lhs_rhs' : ['((', '\br\{${1}\}${0}'], 
        "\ 'leader':'', 
        "\ 'wrapper' : 's:wrap_math_snippet'})

inoremap <buffer> <<> \<\><Esc>F\i

inoremap <buffer> $ $$<Esc>i
inoremap <buffer> == &=
inoremap <buffer> '' `'<Esc>i

" Align the = sign in the current line
nnoremap <buffer> =7 :s/=/\&=<CR>:noh<CR> 
