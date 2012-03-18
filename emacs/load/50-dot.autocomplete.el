
;; auto-complete
;;(auto-install-batch "auto-complete development version")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/local/common/emacs/site-lisp/auto-complete-1.3/dict")
;;(ac-config-default)

(global-auto-complete-mode t)
(ac-set-trigger-key "TAB")

;; 補完が自動開始される長さ
(setq ac-auto-start 3)
;; "Do What I Mean"
(setq ac-dwim nil)
;; 完全推測機能を使用
(setq ac-use-comphist t)
;; 曖昧マッチによる補完を使用しない
(setq ac-use-fuzzy nil)
;; クリックヘルプを使用しない(表示くずれるため)
(setq ac-use-quick-help nil)

(setq ac-quick-help-delay 0.5)
(setq ac-delay 0)
(setq ac-auto-show-menu 0)
(setq popup-use-optimized-column-computation nil)

;; face colors are defined in dot.style.el
(set-face-foreground 'ac-completion-face my-style-ac-completion-face-foreground)
(set-face-background 'ac-candidate-face my-style-ac-candidate-face-background)

;; (define-key ac-complete-mode-map "\C-n" 'ac-next)
;; (define-key ac-complete-mode-map "\C-p" 'ac-previous)
(define-key ac-complete-mode-map "\t" 'ac-expand-common)
;; (define-key ac-complete-mode-map "\t" 'ac-expand-common)

(defun ac-common-setup ()
  ())
;;  (add-to-list 'ac-sources 'ac-source-filename))

(defun ac-emacs-lisp-mode-setup ()
  (setq ac-sources (append '(ac-source-features ac-source-functions ac-source-yasnippet ac-source-variables ac-source-symbols) ac-sources)))

(defun ac-cc-mode-setup ()
  (setq ac-sources (append '(ac-source-semantic ac-source-yasnippet ac-source-gtags) ac-sources)))

(defun ac-ruby-mode-setup ()
  (make-local-variable 'ac-ignores)
  (add-to-list 'ac-ignores "end"))

(defun ac-c++-mode-setup ()
  (setq ac-sources (append '(ac-source-gtags ac-source-semantic) ac-sources)))

(setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))
(add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)
(add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
(add-hook 'c++-mode-hook 'ac-c++-mode-setup)
(add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)
(add-hook 'auto-complete-mode-hook 'ac-common-setup)


;;(install-elisp-from-emacswiki "ac-anything.el")
(require 'ac-anything)
(define-key ac-complete-mode-map (kbd "C-:") 'ac-complete-with-anything)
(define-key ac-complete-mode-map (kbd "C-s") 'ac-complete-with-anything)