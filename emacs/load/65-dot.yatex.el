(require 'yatex)
(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)

(modify-coding-system-alist 'file "\\.tex$'" 'utf-8)

; SJIS 1, EUC 3, UTF8 4
(setq YaTeX-kanji-code 4)
(setq tex-commmand "platex")
(setq dvi2-command "xdvi-ja")
(setq bibtex-command "pbibtex")

(setq YaTeX-fill-column 100)
