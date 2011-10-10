;; python
(add-hook 'python-mode-hook
          '(lambda ()
;;             (pysmell-mode 1)
             (setq indent-tabs-mode t)
             (setq indent-level 4)
             (setq python-indent 4)
             (setq tab-width 4)))
;;(autoload 'python-mode "python-mode" "Python Mode." t)
;;(autoload 'py-shell "python-mode" "Python shell" t)
;;(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
;;(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;;(require 'pysmell)
;;(add-hook 'python-mode-hook (lambda () (pysmell-mode 1)))
 
;;(setq ipython-command "/usr/bin/ipython")
;;(require 'ipython)

;; Pymacs
;; (autoload 'pymacs-apply "pymacs")
;; (autoload 'pymacs-call "pymacs")
;; (autoload 'pymacs-eval "pymacs" nil t)
;; (autoload 'pymacs-exec "pymacs" nil t)
;; (autoload 'pymacs-load "pymacs" nil t)
;; (eval-after-load "pymacs"
;;   '(add-to-list 'pymacs-load-path "~/app/emacs/pymacs-elisp"))


;;;;  Flymake
;;(defun flymake-python-init ()
;;  (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                     'flymake-create-temp-inplace))
;;         (local-file (file-relative-name
;;                      temp-file
;;                      (file-name-directory buffer-file-name))))
;;    (list "pyflakes" (list local-file))))

(defconst flymake-allowed-python-file-name-masks '(("\\.py$" flymake-python-init)))
(defvar flymake-python-err-line-patterns '(("\\(.*\\):\\([0-9]+\\):\\(.*\\)" 1 2 nil 3)))

(defun flymake-python-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-python-file-name-masks))
  (setq flymake-err-line-patterns flymake-python-err-line-patterns)
  (unless (eq buffer-file-name nil) (flymake-mode t)))

;;  (flymake-mode t))
(add-hook 'python-mode-hook '(lambda () (flymake-python-load)))


;; (when (load "flymake" t)
;;   (defun flymake-python-init ()
;;     (let* ((temp-file (flymake-init-create-temp-buffer-copy
;;                      'flymake-create-temp-inplace))
;;          (local-file (file-relative-name
;;                       temp-file
;;                       (file-name-directory buffer-file-name))))
;;     (list "pyflymake" (list local-file)))) ; substitute epylint for this
;;   (push '(".+\\.py$" flymake-python-init) flymake-allowed-file-name-masks))

;; (add-hook 'python-mode-hook
;;           (lambda ()
;;             ; Activate flymake unless buffer is a tmp buffer for the interpreter
;;             (unless (eq buffer-file-name nil) (flymake-mode t)))) ; this should fix your problem
