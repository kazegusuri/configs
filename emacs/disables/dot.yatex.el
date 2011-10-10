
;; YaTeX
(modify-coding-system-alist 'file "\\.tex$'" 'euc-jp)
(setq auto-mode-alist 
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq yatex-mode-hook
      '(lambda ()
         (local-set-key "\C-cm" 'set-mark-command)
		 (local-set-key "\C-c\C-m" 'set-mark-command)
         ))
; SJIS 1, EUC 3, UTF8 4
(setq YaTeX-kanji-code 3)
(setq tex-command "platex")
(setq dvi2-command "xdvi")
(setq bibtex-command "jbibtex")

(setq fill-column 80)  ;; 80文字で自動改行