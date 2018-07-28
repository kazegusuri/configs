;; cperl-mode is preferred to perl-mode
(defalias 'perl-mode 'cperl-mode)

(setq cperl-brace-offset -4
      cper-close-paren-offset -4
      ;; cperl-continued-brace-offset 0
      cperl-continued-statement-offset 4
      cperl-indent-level 4
      cperl-indent-parens-as-block t
      cperl-label-offset -4
      cperl-highlight-variables-indiscriminately t
      cperl-indent-region-fix-constructs 1
      cperl-indent-parens-as-block t
      cperl-autoindent-on-semi t
      cperl-fontlock t)

;;; perl-completion
;; (install-elisp "http://www.emacswiki.org/emacs/download/perl-completion.el")
; (require 'perl-completion)
;; (require 'set-perl5lib)
(add-hook 'cperl-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (setq tab-width nil)
             
             ;; perl-completion
             (perl-completion-mode t)
             (require 'auto-complete)
             (auto-complete-mode t)
             (add-to-list 'ac-sources 'ac-source-perl-completion)
             ))

;;; eldoc for perl
(defun my-cperl-eldoc-documentation-function ()
  "Return meaningful doc string for `eldoc-mode'."
  (car
   (let ((cperl-message-on-help-error nil))
     (cperl-get-help))))

(defun my-perl-eletronic-eldoc ()
  (interactive)
  (call-interactively 'self-insert-command)
  (if eldoc-mode
      (message "%s" (funcall eldoc-documentation-function))))

(add-hook 'cperl-mode-hook
          '(lambda ()
             (set (make-local-variable 'eldoc-documentation-function)
                                       'my-cperl-eldoc-documentation-function)
                  (eldoc-mode 1)))


;;; flymake for perl
;; Perl用設定
;; http://unknownplace.org/memo/2007/12/21#e001
(defvar flymake-perl-err-line-patterns
  '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))
;; add major-mode to flymake
(push '("cperl-mode" flymake-perl-init) flymake-allowed-major-mode)

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-intemp))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc" local-file))))

(defun flymake-perl-load ()
  (interactive)
  ;;(set-perl5lib)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (set (make-local-variable 'flymake-err-line-patterns)
       flymake-perl-err-line-patterns)
  (flymake-mode t))

(add-hook 'cperl-mode-hook 'flymake-perl-load)
