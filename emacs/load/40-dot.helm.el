(require 'helm)

(helm-mode 1)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

(setq helm-autoresize-mode nil)

(define-key helm-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-h") 'delete-backward-char)
(define-key helm-map (kbd "C-w") 'backward-delete-word)
(define-key helm-map (kbd "M-n") 'helm-next-source)
(define-key helm-map (kbd "M-p") 'helm-previous-source)

(setq helm-command-prefix-key "\C-j")
(define-key my-keyjack-mode-map "\C-j" 'helm-command-prefix)
(require 'helm-config)

(require 'helm-git-files)
(require 'helm-ls-git)


(defvar my-helm-go-package-source
  (helm-build-sync-source "Go local packages"
    :candidates 'go-packages-go-list
    :persistent-action 'helm-go-package--persistent-action
    :persistent-help  "Show documentation"
    :action 'helm-go-package-actions))

(defun my-helm-go-package ()
  (interactive)
  (helm-other-buffer '(my-helm-go-package-source)
                     "*helm go package*"))


;; (define-key map (kbd "a")         'helm-apropos)
;; (define-key map (kbd "e")         'helm-etags-select)
;; (define-key map (kbd "l")         'helm-locate)
;; (define-key map (kbd "s")         'helm-surfraw)
;; (define-key map (kbd "r")         'helm-regexp)
;; (define-key map (kbd "m")         'helm-man-woman)
;; (define-key map (kbd "t")         'helm-top)
;; (define-key map (kbd "/")         'helm-find)
;; (define-key map (kbd "i")         'helm-semantic-or-imenu)
;; (define-key map (kbd "I")         'helm-imenu-in-all-buffers)
;; (define-key map (kbd "<tab>")     'helm-lisp-completion-at-point)
;; (define-key map (kbd "p")         'helm-list-emacs-process)
;; (define-key map (kbd "C-x r b")   'helm-filtered-bookmarks)
;; (define-key map (kbd "M-y")       'helm-show-kill-ring)
;; (define-key map (kbd "C-c <SPC>") 'helm-all-mark-rings)
;; (define-key map (kbd "C-x C-f")   'helm-find-files)
;; (define-key map (kbd "f")         'helm-multi-files)
;; (define-key map (kbd "C-:")       'helm-eval-expression-with-eldoc)
;; (define-key map (kbd "C-,")       'helm-calcul-expression)
;; (define-key map (kbd "M-x")       'helm-M-x)
;; (define-key map (kbd "M-s o")     'helm-occur)
;; (define-key map (kbd "M-g a")     'helm-do-grep-ag)
;; (define-key map (kbd "c")         'helm-colors)
;; (define-key map (kbd "F")         'helm-select-xfont)
;; (define-key map (kbd "8")         'helm-ucs)
;; (define-key map (kbd "C-c f")     'helm-recentf)
;; (define-key map (kbd "C-c g")     'helm-google-suggest)
;; (define-key map (kbd "h i")       'helm-info-at-point)
;; (define-key map (kbd "h r")       'helm-info-emacs)
;; (define-key map (kbd "h g")       'helm-info-gnus)
;; (define-key map (kbd "h h")       'helm-documentation)
;; (define-key map (kbd "C-x C-b")   'helm-buffers-list)
;; (define-key map (kbd "C-x r i")   'helm-register)
;; (define-key map (kbd "C-c C-x")   'helm-run-external-command)
;; (define-key map (kbd "b")         'helm-resume)
;; (define-key map (kbd "M-g i")     'helm-gid)
;; (define-key map (kbd "@")         'helm-list-elisp-packages)

(define-key helm-command-map (kbd "g") 'helm-browse-project)
(define-key helm-command-map (kbd "G") 'helm-git-grep)
(define-key helm-command-map (kbd "C-f") 'helm-browse-project)
(define-key helm-command-map (kbd "j") 'helm-ghq)
