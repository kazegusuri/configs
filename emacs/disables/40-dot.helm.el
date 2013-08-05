(eval-when-compile (require 'cl))

(require 'helm-config)
(require 'helm-command)
(require 'helm-descbinds)

(define-key helm-map (kbd "C-z")        'helm-select-action)
(define-key helm-map (kbd "C-i")        'helm-execute-persistent-action)
;; (helm-mode 1)
(setq helm-idle-delay             0.3
      helm-input-idle-delay       0.3
      helm-candidate-number-limit 200)


(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-^")     'helm-c-apropos)
(global-set-key (kbd "C-;")     'helm-resume)
(global-set-key (kbd "M-s")     'helm-occur)
(global-set-key (kbd "M-x")     'helm-M-x)
(global-set-key (kbd "M-y")     'helm-show-kill-ring)
(global-set-key (kbd "M-z")     'helm-do-grep)

;(setq helm-split-window-preferred-function 'helm-split-window-default-fn)
(setq helm-split-window-in-side-p t)
(setq helm-split-window-default-side 'below)

(custom-set-variables 
   '(helm-command-prefix-key "\C-j"))
(define-key my-keyjack-mode-map "\C-j" helm-command-map)
(define-key helm-command-map (kbd "b") 'helm-buffers-list)
(define-key helm-command-map (kbd "t") 'helm-resume)
(define-key helm-map (kbd "C-h") 'backward-delete-char)
(define-key helm-map (kbd "C-w") 'backward-delete-word)

;; ディレクトリの自動補完を切る
(setq helm-ff-auto-update-initial-value nil)
;; スマート補完
(setq helm-ff-smart-completion t)

;; (require 'helm-gtags)
;; (setq helm-gtags-path-style 'root)
;; (setq helm-gtags-ignore-case t)
;; (setq helm-gtags-read-only nil)
;; (add-hook 'gtags-mode-hook
;;           '(lambda ()
;;              (helm-gtags-mode)))
;; (add-hook 'helm-gtags-mode-hook
;;           '(lambda ()
;;              (local-set-key (kbd "M-t") 'helm-gtags-find-tag)
;;              (local-set-key (kbd "M-r") 'helm-gtags-find-rtag)
;;              (local-set-key (kbd "M-s") 'helm-gtags-find-symbol)
;;              (local-set-key (kbd "C-t") 'helm-gtags-pop-stack)
;;              (local-set-key (kbd "C-c C-f") 'helm-gtags-pop-stack)))
