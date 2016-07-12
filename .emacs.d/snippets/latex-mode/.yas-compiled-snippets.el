;;; Compiled snippets and support files for `latex-mode'
;;; Snippet definitions:
;;;
(yas-define-snippets 'latex-mode
                     '(("verb" "\\begin{verbatim}\n$0\n\\end{verbatim}\n" "\\begin{verbatim} ... \\end{verbatim}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/verb.yasnippet" nil nil)
                       ("use" "\\usepackage[$2]{$1}$0" "\\usepackage" nil
                        ("misc")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/use.yasnippet" nil nil)
                       ("url" "\\url{${1:$$(yas/choose-value '(\"http\" \"ftp\"))}://${2:address}}$0" "\\url" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/url.yasnippet" nil nil)
                       ("tt" "{\\tt $1}$0" "{\\tt ...}" nil
                        ("font")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/tt.yasnippet" nil nil)
                       ("tikz" "\\begin{figure}\n  \\centering\n  \\begin{tikzpicture}\n    $0\n  \\end{tikzpicture}\n  \\caption{${1:Caption}}\n  \\label{${2:label$$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n\\end{figure}" "TikZ picture in centered figure" nil nil nil "/home/hersh/.emacs.d/snippets/latex-mode/tikz-picture.yasnippet" "direct-keybinding" nil)
                       ("table" "\\begin{table}[htbp]\n  \\centering\n  \\begin{tabular}{${3:format}}\n    $0\n  \\end{tabular}\n  \\caption{${1:caption}}\n  \\label{${2:\"waiting for reftex-label call...\"$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n\\end{table}\n" "\\begin{table} ... \\end{table}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/table.yasnippet" nil nil)
                       ("sum" "\\sum_{$1}^{$2}$0\n" "\\sum_{n}^{}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/sum.yasnippet" nil nil)
                       ("sub*" "\\subsection*{${1:name}}\n$0" "\\subsection*" nil
                        ("sections")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/substar.yasnippet" nil nil)
                       ("subfig" "\\subfigure[${1:caption}]{\n  \\label{${2:\"waiting for reftex-label call...\"$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n  $0\n}\n" "\\subfigure" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/subfig.yasnippet" nil nil)
                       ("sub" "\\subsection{${1:name}}\n\\label{${2:\"waiting for reftex-label call...\"$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n$0" "\\subsection" nil
                        ("sections")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/sub.yasnippet" nil nil)
                       ("ssub*" "\\subsubsection*{${1:name}}\n$0" "\\subsubsection*" nil
                        ("sections")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/ssubstar.yasnippet" nil nil)
                       ("ssub" "\\subsubsection{${1:name}}\n\\label{${2:\"waiting for reftex-label call...\"$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n$0" "\\subsubsection" nil
                        ("sections")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/ssub.yasnippet" nil nil)
                       ("sec*" "\\section*{${1:name}}\n$0" "\\section*" nil
                        ("sections")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/secstar.yasnippet" nil nil)
                       ("sec" "\\section{${1:name}}\n\\label{${2:\"waiting for reftex-label call...\"$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n$0" "\\section" nil
                        ("sections")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/sec.yasnippet" nil nil)
                       ("sc" "{\\scshape $1}$0" "{\\sc ...}" nil
                        ("font")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/sc.yasnippet" nil nil)
                       ("ref" "\\ref{${1:label$(unless yas/modified-p (reftex-reference nil 'dont-insert))}}$0" "\\ref" nil
                        ("references")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/ref.yasnippet" nil nil)
                       ("prod" "\\prod_{$1}^{$2}$0\n" "\\prod_{n}^{}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/prod.yasnippet" nil nil)
                       ("pmat" "\\begin{pmatrix} $0 \\end{pmatrix}\n\n" "\\begin{pmatrix} ... \\end{}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/pmatrix.yasnippet" nil nil)
                       ("par" "\\paragraph{${1:name}}\n\\label{${2:\"waiting for reftex-label call...\"$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n$0" "\\paragraph" nil
                        ("sections")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/par.yasnippet" nil nil)
                       ("minipage" "\\begin{minipage}[${1:htbp}]{${2:1.0}${3:\\linewidth}}\n  $0\n\\end{minipage}" "\\begin{minipage}[position][width] ... \\end{minipage}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/minipage.yasnippet" nil nil)
                       ("matrix" "\\begin{${1:$$(yas/choose-value '(\"pmatrix\" \"bmatrix\" \"Bmatrix\" \"vmatrix\" \"Vmatrix\" \"smallmatrix\"))}}\n\\label{${2:\"waiting for reftex-label call...\"$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n$0\n\\end{$1}\n\n" "\\begin{matrix} ... \\end{}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/matrix.yasnippet" nil nil)
                       ("math" "\\[\n$1\n\\]\n" "displaymath \\[ ... \\]" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/math.yasnippet" nil nil)
                       ("lim" "\\lim_{$1}$0\n" "\\lim_{n}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/lim.yasnippet" nil nil)
                       ("letter" "\\documentclass{letter}\n\\signature{${1:Foo Bar}}\n\\address{${2:Address line 1 \\\\\\\\ \nAddress line 2 \\\\\\\\\nAddress line 3}}\n\\begin{document}\n \n\\begin{letter}\n{${3:Recipient's address}}\n\n\\opening{Dear ${4:Sir}:}\n\n$0\n \n\\closing{Yours Sincerely,}\n \n\\end{letter}\n \n\\end{document}\n\n" "\\documentclass{letter} ..." nil
                        ("skeleton")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/letter.yasnippet" nil nil)
                       ("lab" "\\label{${1:label$(unless yas/modified-p (reftex-label nil 'dont-insert))}}$0\n" "\\label" nil
                        ("references")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/label.yasnippet" nil nil)
                       ("item" "\\begin{itemize}\n\\item $0\n\\end{itemize}\n" "\\begin{itemize} ... \\end{itemize}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/item.yasnippet" nil nil)
                       ("itd" "\\item[${1:label}] $0" "\\item[] (description)" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/itd.yasnippet" nil nil)
                       ("it" "\\item $0" "\\item" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/it.yasnippet" nil nil)
                       ("int" "\\\\int_{$2}^{$3}$0" "\\int_{n}^{}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/int.yasnippet" nil nil)
                       ("href" "\\href{${1:url}}{${2:text}}$0" "\\href{url}{text}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/href.yasnippet" nil nil)
                       ("graphics" "\\includegraphics[width=${1:\\linewidth}]{${2:file}}" "\\includegraphics" nil nil nil "/home/hersh/.emacs.d/snippets/latex-mode/graphics.yasnippet" nil nil)
                       ("newgls" "\\newglossaryentry{$1}{name={$1},\n  description={$2.}}\n" "\\newglossaryentry{...}{...}" nil
                        ("misc")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/gls.yasnippet" nil nil)
                       ("frame" "\\begin{frame}{${1:Frame Title}}\n\n\\end{frame}\n" "\\begin{frame} ... \\end{frame}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/frame.yasnippet" nil nil)
                       ("frac" "\\frac{$1}{$2}$0" "\\frac{numerator}{denominator}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/frac.yasnippet" nil nil)
                       ("f" "\\frac12" "frac (quick)" nil nil nil "/home/hersh/.emacs.d/snippets/latex-mode/frac (quick)" nil nil)
                       ("fig" "\\begin{figure}[htbp]\n  \\centering\n  $0\n  \\caption{${1:caption}}\n  \\label{${2:\"waiting for reftex-label call...\"$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n\\end{figure}\n" "\\begin{figure} ... \\end{figure}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/fig.yasnippet" nil nil)
                       ("eqs" "\\begin{${1:$$(yas/choose-value '(\"align\" \"align*\" \"multline\" \"gather\" \"subequations\"))}}\n\\label{${2:\"waiting for reftex-label call...\"$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n$0\n\\end{$1}\n" "\\begin{align} ... \\end{align}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/eqs.yasnippet" nil nil)
                       ("eq" "\\begin{equation}\n\\label{${1:\"waiting for reftex-label call...\"$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n$0\n\\end{equation}\n" "\\begin{equation} ... \\end{equation}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/eq.yasnippet" nil nil)
                       ("enum" "\\begin{enumerate}\n\\item $0\n\\end{enumerate}\n" "\\begin{enumerate} ... \\end{enumerate}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/enum.yasnippet" nil nil)
                       ("em" "{\\em $1}$0" "{\\em ...}" nil
                        ("font")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/em.yasnippet" nil nil)
                       ("doc" "\\documentclass[$2]{${1:$$(yas/choose-value '(\"article\" \"report\" \"book\" \"letter\"))}}\n\n\\begin{document}\n$0\n\\end{document}\n" "\\documentclass" nil nil nil "/home/hersh/.emacs.d/snippets/latex-mode/doc.yasnippet" nil nil)
                       ("desc" "\\begin{description}\n\\item[${1:label}] $0\n\\end{description}\n" "\\begin{description} ... \\end{description}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/desc.yasnippet" nil nil)
                       ("coprod" "\\coprod_{$1}^{$2}$0\n" "\\coprod_{n}^{}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/coprod.yasnippet" nil nil)
                       ("cite" "\\cite{${1:label$(unless yas/modified-p (car (reftex-citation 't)))}}$0\n" "\\cite" nil
                        ("references")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/cite.yasnippet" nil nil)
                       ("cha*" "\\chapter*{${1:name}}\n$0" "\\chapter*" nil
                        ("sections")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/chastar.yasnippet" nil nil)
                       ("cha" "\\chapter{${1:name}}\n\\label{${2:\"waiting for reftex-label call...\"$(unless yas/modified-p (reftex-label nil 'dont-insert))}}\n$0" "\\chapter" nil
                        ("sections")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/cha.yasnippet" nil nil)
                       ("case" "\\begin{cases}\n$0 \\\\\\\\\n\\end{cases}\n" "\\begin{cases} ... \\end{cases}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/case.yasnippet" nil nil)
                       ("bk" "\\<$1\\>$0" "bra-ket" nil nil nil "/home/hersh/.emacs.d/snippets/latex-mode/bra-ket.yasnippet" nil nil)
                       ("bf" "{\\bf $1}$0" "{\\bf ... }" nil
                        ("font")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/bold.yasnippet" nil nil)
                       ("block" "\\begin{${1:$$(yas/choose-value '(\"block\" \"exampleblock\" \"alertblock\"))}}{${2:Block Title}}\n\n\\end{$1}\n" "\\begin{*block} ... \\end{*block}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/block.yasnippet" nil nil)
                       ("binom" "\\binom{${1:n}}{${2:k}}" "\\binom{n}{k}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/binom.yasnippet" nil nil)
                       ("bigop" "\\\\big${1:$$(yas/choose-value '(\"oplus\" \"otimes\" \"odot\" \"cup\" \"cap\" \"uplus\" \"sqcup\" \"vee\" \"wedge\"))}_{$2}^{$3}$0\n" "\\bigop_{n}^{}" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/bigop.yasnippet" nil nil)
                       ("big" "\\\\${1:$$(yas/choose-value '(\"big\" \"Big\" \"bigg\" \"Bigg\"))}l( $0  \\\\$1r)" "\\bigl( ... \\bigr)" nil
                        ("math")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/big.yasnippet" nil nil)
                       ("bib" "\\bibliographystyle{plain}\n\\bibliography{$1}$0" "\\bibliography" nil
                        ("misc")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/bib.yasnippet" nil nil)
                       ("b" "\\begin{${1:$$(yas/choose-value (mapcar 'car (LaTeX-environment-list)))}}\n$0\n\\end{$1}\n" "\\begin{environment} ... \\end{environment}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/begin.yasnippet" nil nil)
                       ("beamer" "\\documentclass[xcolor=dvipsnames]{beamer}\n\n\\usepackage{graphicx,subfigure,url}\n\n% example themes\n\\usetheme{Frankfurt}\n\\usecolortheme{seahorse}\n\\usecolortheme{rose}\n\n% put page numbers\n% \\setbeamertemplate{footline}[frame number]{}\n% remove navigation symbols\n% \\setbeamertemplate{navigation symbols}{}\n\n\\title{${1:Presentation Title}}\n\\author{${2:Author Name}}\n\n\\begin{document}\n	\n\\frame[plain]{\\titlepage}\n	\n\\begin{frame}[plain]{Outline}\n	\\tableofcontents\n\\end{frame}\n	\n\\section{${3:Example Section}}\n\\begin{frame}{${4:Frame Title}}\n\n\\end{frame}\n\n\\end{document}\n" "\\documentclass{beamer} ..." nil
                        ("skeleton")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/beamer.yasnippet" nil nil)
                       ("article" "\\documentclass[11pt]{article}\n\n\\usepackage{graphicx,amsmath,amssymb,subfigure,url,xspace}\n\\newcommand{\\eg}{e.g.,\\xspace}\n\\newcommand{\\bigeg}{E.g.,\\xspace}\n\\newcommand{\\etal}{\\textit{et~al.\\xspace}}\n\\newcommand{\\etc}{etc.\\@\\xspace}\n\\newcommand{\\ie}{i.e.,\\xspace}\n\\newcommand{\\bigie}{I.e.,\\xspace}\n\n\\title{${1:title}}\n\\author{${2:Author Name}}\n\n\\begin{document}\n\\maketitle\n\n\n\\bibliographystyle{${3:plain}}\n\\bibliography{${4:literature.bib}}\n\n\\end{document}\n" "\\documentclass{article} ..." nil
                        ("skeleton")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/article.yasnippet" nil nil)
                       ("arr" "\\begin{array}{$1}\n  $0\n\\end{array}\n" "\\begin{array} ... \\end{array}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/array.yasnippet" nil nil)
                       ("aln" "\\begin{align*}\n  $0\n\\end{align*}\n" "\\begin{align*} ... \\end{align*}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/alignstart.yansippet" nil nil)
                       ("al" "\\begin{align}\n  $0\n\\end{align}\n" "\\begin{align} ... \\end{align}" nil
                        ("environments")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/align.yasnippet" nil nil)
                       ("abs" "\\begin{abstract}\n$0\n\\end{abstract}" "\\abstract" nil
                        ("sections")
                        nil "/home/hersh/.emacs.d/snippets/latex-mode/abstract.yasnippet" nil nil)))


;;; Do not edit! File generated at Tue Jun 14 16:38:17 2016
