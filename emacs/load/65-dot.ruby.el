(require 'ruby-mode)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Berksfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq ruby-indent-level 2)
             (setq ruby-indent-tabs-mode nil)
             (setq ruby-deep-indent-paren-style nil)
             (modify-syntax-entry ?@ "_" ruby-mode-syntax-table)
             (modify-syntax-entry ?: "_" ruby-mode-syntax-table)
             (modify-syntax-entry ?! "_" ruby-mode-syntax-table)
             (flycheck-mode)
             (gtags-mode 1)
             ;;(robe-mode)
             ;;(inf-ruby-keys)
             ))


;; (require 'rcodetools)
;; (setq rct-find-tag-if-available nil)
;; (defun ruby-mode-hook-rcodetools ()
;;   (define-key ruby-mode-map "\M-\C-i" 'rct-complete-symbol)
;;   (define-key ruby-mode-map "\C-c\C-t" 'ruby-toggle-buffer)
;;   (define-key ruby-mode-map "\C-c\C-f" 'rct-ri))
;; (add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)
;;(require 'ac-robe)
;;(add-hook 'robe-mode-hook 'ac-robe-setup)
;;(add-hook 'ruby-mode-hook 'robe-mode)

(defadvice ruby-indent-line (after unindent-closing-paren activate)
  (let ((column (current-column))
        indent offset)
    (save-excursion
      (back-to-indentation)
      (let ((state (syntax-ppss)))
        (setq offset (- column (current-column)))
        (when (and (eq (char-after) ?\))
                   (not (zerop (car state))))
          (goto-char (cadr state))
          (setq indent (current-indentation)))))
    (when indent
      (indent-line-to indent)
      (when (> offset 0) (forward-char offset)))))

(require 'align)
(add-to-list 'align-rules-list
             '(ruby-comma-delimiter
               (regexp . ",\\(\\s-*\\)[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list
             '(ruby-hash-literal
               (regexp . "\\(\\s-*\\)=>\\s-*[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list
             '(ruby-assignment-literal
               (regexp . "\\(\\s-*\\)=\\s-*[^# \t\n]")
               (repeat . t)
               (modes  . '(ruby-mode))))
(add-to-list 'align-rules-list          ;TODO add to rcodetools.el
             '(ruby-xmpfilter-mark
               (regexp . "\\(\\s-*\\)# => [^#\t\n]")
               (repeat . nil)
               (modes  . '(ruby-mode))))

(require 'rspec-mode)
(custom-set-variables '(rspec-use-rake-flag nil))
(define-key ruby-mode-map (kbd "C-c f") 'rspec-verify)
(define-key ruby-mode-map (kbd "C-c s") 'rspec-verify-single)
(define-key ruby-mode-map (kbd "C-c r") 'rspec-rerun)

;; inf-ruby
(require 'inf-ruby)
;;(autoload 'inf-ruby "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
(add-to-list 'inf-ruby-implementations '("pry" . "pry"))
(setq inf-ruby-default-implementation "pry")
(setq inf-ruby-first-prompt-pattern "^\\[[0-9]+\\] pry\\((.*)\\)> *")
(setq inf-ruby-prompt-pattern "^\\[[0-9]+\\] pry\\((.*)\\)[>*\"'] *")
