;; c-mode, two space 'tab', replace tab with spaces
(add-hook 'c-mode-common-hook
          '(lambda ()
             (gtags-mode 1)               ;; auto load gtags-mode
             (flymake-mode t)
             (setq indent-tabs-mode nil)
             (c-set-style "linux")
             (c-toggle-hungry-state 1)
             (setq c-basic-offset 4)))

;; Makefile が無くてもC/C++のチェック
(defun flymake-simple-make-or-generic-init (cmd &optional opts)
  (if (file-exists-p "Makefile")
      (my-flymake-simple-make-init)
    (flymake-simple-generic-init cmd opts)))

(defun flymake-c-init ()
  (flymake-simple-make-or-generic-init
   "gcc" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

(defun flymake-cc-init ()
  (flymake-simple-make-or-generic-init
   "g++" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

(push '("\\.[cC]\\'" flymake-c-init) flymake-allowed-file-name-masks)
(push '("\\.\\(?:cc\|cpp\|CC\|CPP\\)\\'" flymake-cc-init) flymake-allowed-file-name-masks)
