"vmap <c-b> "zdi**<c-r>z**
"imap <c-b> **  **<esc>2hi
"vmap <c-i> "zdi//<c-r>z//
"imap <c-i> //  //<esc>2hi
"vmap <c-u> "zdi__<c-r>z__
"imap <c-u> __  __<esc>2hi
"vmap <c-t> "zdi''<c-r>z''
"imap <c-t> ''  ''<esc>2hi
"vmap <c-s> "zdi<c-v><del><c-r>z</del>
"imap <c-s> <c-v><del></del><esc>5hi
"vmap <c-l> "zdi[[<c-r>z]]
"imap <c-l> [[]]<esc>2ha
"vmap <a-1> "zdi======= <c-r>z =======
"imap <a-1> =======  =======<esc>7hi
"vmap <a-2> "zdi====== <c-r>z ======
"imap <a-2> ======  ======<esc>6hi
"vmap <a-3> "zdi===== <c-r>z =====
"imap <a-3> =====  =====<esc>5hi
"vmap <a-4> "zdi==== <c-r>z ====
"imap <a-4> ====  ====<esc>4hi
"vmap <a-5> "zdi=== <c-r>z ===
"imap <a-5> ===  ===<esc>3hi
"vmap <a-6> "zdi== <c-r>z ==
"imap <a-6> ==  ==<esc>3hi
"nmap <F2> :s/.*/  * &/
"imap <F2> <space><space>*<space>
"nmap <F3> :s/.*/  - &/
"imap <F3> <space><space>-<space>


"" Increase heading by one level
""imap == <Home>=<End>= <BS>
"nmap == mtI=<Esc>A=<Esc>'t
"" Decrease heading by one level
""imap =- <Home><Del><End><BS>
"nmap =- 0x<Esc>$x
