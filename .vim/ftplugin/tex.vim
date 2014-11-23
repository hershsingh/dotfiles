" Author: Hersh Singh [hershdeep at gmail dot com]
" Description: 
"   - The greek letter mappings for latex are derived from a section of the auctex.vim plugin.
" Installation: Copy this to $VIMRUNTIME$/ftplugin/tex.vim

let maplocalleader = "]"
"let s:latexMaps=1
let b:latexau=0

" Custom/Temporary bindings   {{{
nnoremap <buffer> <F6> :tabedit ~/.vim/ftplugin/tex.vim<CR>
inoremap <buffer> <<> \<\><Esc>F\i
inoremap <buffer> {{} \{\}<Esc>F\i
inoremap <buffer> 6e \hat{e}_
inoremap <buffer> $ $$<Esc>i
inoremap <buffer> == &=
inoremap <buffer> '' `'<Esc>i
inoremap <buffer> 4p 4\pi\epsilon_0 r
" Align the = sign in the current line
nnoremap <buffer> =7 :s/=/\&=/g<CR>:noh<CR> 
" }}}

" Autocompile after every write
"nnoremap <buffer> <F4> :let g:LatexBox_latexmk_preview_continuously=1-g:LatexBox_latexmk_preview_continuously<CR>:echo g:LatexBox_latexmk_preview_continuously<CR>

nnoremap <buffer> <F4> :call ToggleLatexAutocommands()<CR>
function! ToggleLatexAutocommands()
    if b:latexau==0
        augroup Latex
            au!
            au BufWritePost <buffer> :Latexmk
        augroup END
        let b:latexau=1
        echo "Autocompile Enabled"
    elseif b:latexau==1
        augroup Latex
            au!
        augroup END
        let b:latexau=0
        echo "Autocompile Disabled"
    endif
endfunction

" SyncTeX with Zathura
" Forward Search mapping
nnoremap <expr><buffer> <LocalLeader>ls ':LatexView  ' . '--synctex-forward ' . line(".") . ":" . col(".") . ":" . expand('%:p') . '<CR>'

" Greek letters, AucTex style bindings   {{{

inoremap <buffer> <LocalLeader><LocalLeader> <LocalLeader>
"inoremap <buffer> <LocalLeader>a <C-g>u'a<Esc>ui<C-g>u\alpha
"inoremap <buffer> <LocalLeader>a 'a<C-g>u<Esc>F'dfaa\alpha
"inoremap <buffer> <LocalLeader>a a<C-g>u<Esc>xa\alpha
inoremap <buffer> <LocalLeader>a \alpha
inoremap <buffer> <LocalLeader>b \beta
inoremap <buffer> <LocalLeader>c \chi
inoremap <buffer> <LocalLeader>d \delta
inoremap <buffer> <LocalLeader>e \epsilon
inoremap <buffer> <LocalLeader>f \phi
inoremap <buffer> <LocalLeader><LocalLeader>f \varphi
inoremap <buffer> <LocalLeader>g \gamma
inoremap <buffer> <LocalLeader>h \eta
"inoremap <buffer> <LocalLeader>i \int_{}^{}<Esc>F}i
inoremap <buffer> <LocalLeader>i \iota
	    " Or \iota or \infty or \in
inoremap <buffer> <LocalLeader>k \kappa
inoremap <buffer> <LocalLeader>l \lambda
inoremap <buffer> <LocalLeader>m \mu
inoremap <buffer> <LocalLeader>n \nu
inoremap <buffer> <LocalLeader>o \omega
inoremap <buffer> <LocalLeader>p \pi
inoremap <buffer> <LocalLeader>q \theta
inoremap <buffer> <LocalLeader><LocalLeader>q \vartheta
inoremap <buffer> <LocalLeader>r \rho
inoremap <buffer> <LocalLeader>s \sigma
inoremap <buffer> <LocalLeader>t \tau
inoremap <buffer> <LocalLeader>u \upsilon
inoremap <buffer> <LocalLeader>v \vee
inoremap <buffer> <LocalLeader>w \wedge
inoremap <buffer> <LocalLeader>x \xi
inoremap <buffer> <LocalLeader>y \psi
inoremap <buffer> <LocalLeader>z \zeta
inoremap <buffer> <LocalLeader>D \Delta
inoremap <buffer> <LocalLeader>I \int_{}^{}<Esc>F}i
inoremap <buffer> <LocalLeader>F \Phi
inoremap <buffer> <LocalLeader>G \Gamma
inoremap <buffer> <LocalLeader>L \Lambda
inoremap <buffer> <LocalLeader>N \nabla
inoremap <buffer> <LocalLeader>O \Omega
inoremap <buffer> <LocalLeader>Q \Theta
inoremap <buffer> <LocalLeader>R \varrho
inoremap <buffer> <LocalLeader>S \sum_{}^{}<Esc>F}i
inoremap <buffer> <LocalLeader>U \Upsilon
inoremap <buffer> <LocalLeader>X \Xi
inoremap <buffer> <LocalLeader>Y \Psi
inoremap <buffer> <LocalLeader>0 \emptyset
inoremap <buffer> <LocalLeader>1 \left
inoremap <buffer> <LocalLeader>2 \right
inoremap <buffer> <LocalLeader>3 \Big
inoremap <buffer> <LocalLeader>6 \partial
inoremap <buffer> <LocalLeader>8 \infty
inoremap <buffer> <LocalLeader>/ \frac{}{}<Esc>F}i
inoremap <buffer> <LocalLeader>% \frac{}{}<Esc>F}i
inoremap <buffer> <LocalLeader>@ \circ
inoremap <buffer> <LocalLeader>\| \Big\|
inoremap <buffer> <LocalLeader>= \equiv
inoremap <buffer> <LocalLeader>\ \setminus
inoremap <buffer> <LocalLeader>. \cdot
inoremap <buffer> <LocalLeader>* \times
inoremap <buffer> <LocalLeader>& \wedge
inoremap <buffer> <LocalLeader>- \bigcap
inoremap <buffer> <LocalLeader>+ \bigcup
inoremap <buffer> <LocalLeader>( \subset
inoremap <buffer> <LocalLeader>) \supset
inoremap <buffer> <LocalLeader>< \leq
inoremap <buffer> <LocalLeader>> \geq
inoremap <buffer> <LocalLeader>, ,\dotsc,
inoremap <buffer> <LocalLeader>: \dots
inoremap <buffer> <LocalLeader>~ \tilde{}<Left>
inoremap <buffer> <LocalLeader>^ \hat{}<Left>
inoremap <buffer> <LocalLeader>; \dot{}<Left>
inoremap <buffer> <LocalLeader>_ \bar{}<Left>
inoremap <buffer> <LocalLeader><M-c> \cos
inoremap <buffer> <LocalLeader><C-E> \exp\left(\right)<Esc>F(a
inoremap <buffer> <LocalLeader><C-I> \in
inoremap <buffer> <LocalLeader><C-J> \downarrow
inoremap <buffer> <LocalLeader><C-L> \log
inoremap <buffer> <LocalLeader><C-P> \uparrow
inoremap <buffer> <LocalLeader><Up> \uparrow
inoremap <buffer> <LocalLeader><C-N> \downarrow
inoremap <buffer> <LocalLeader><Down> \downarrow
inoremap <buffer> <LocalLeader><C-F> \to
inoremap <buffer> <LocalLeader><Right> \lim_{}<Left>
inoremap <buffer> <LocalLeader><C-S> \sin
inoremap <buffer> <LocalLeader><C-T> \tan
inoremap <buffer> <LocalLeader><M-l> \ell
inoremap <buffer> <LocalLeader><CR> \nonumber\\<CR><HOME>&&<Left>

" }}}
