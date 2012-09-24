
;;; gtags
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))
(add-hook 'cscope-list-entry-hook 'hl-line-mode)
(add-hook 'gtags-select-mode-hook 'hl-line-mode)
(defun my-update-gtags () 
  (interactive) 
  (when (executable-find "global")
    (call-process "global" nil nil nil "-uv")))
(add-hook
 'c-mode-common-hook
 '(lambda()
    (add-hook 'after-save-hook 'my-update-gtags)))
