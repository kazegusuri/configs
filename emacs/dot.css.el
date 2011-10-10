;; css-mode
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))
(setq cssm-indent-function #'cssm-c-style-indenter)
(add-hook 'css-mode-hook
          '(lambda ()
             (define-key cssm-mode-map (read-kbd-macro "C-o") 'cssm-complete-property)))