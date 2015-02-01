(require 'go-mode)

(add-hook 'go-mode-hook
          '(lambda ()
             ;; Need gocode
             ;; $ go get -u github.com/nsf/gocode
             (require 'go-autocomplete)

             (local-set-key (kbd "\C-c d") 'godoc)
             (local-set-key (kbd "\C-c i") 'go-goto-imports)
             (local-set-key (kbd "\C-c a") 'go-import-add)
             (local-set-key (kbd "\C-c r") 'go-remove-unused-imports)
             ;; Need godef
             ;; $ go get -u code.google.com/p/rog-go/exp/cmd/godef
             (local-set-key (kbd "M-.") 'godef-jump)

             ;; run gofmt before save
             (add-hook 'before-save-hook 'gofmt-before-save)

             (gtags-mode 1)
             ))

(defadvice godef--find-file-line-column (before hogehoge activate)
  "push context before find-file-line-column"
  (gtags-push-context)
  )

(require 'flycheck)
(add-hook 'go-mode-hook 'flycheck-mode)
