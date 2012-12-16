;; c-mode, two space 'tab', replace tab with spaces
(add-hook 'c-mode-common-hook
          '(lambda ()
             (require 'google-c-style)
             (google-set-c-style)
             (gtags-mode 1)               ;; auto load gtags-mode
             (flymake-mode t)
             (setq indent-tabs-mode nil)
             (when (and (require 'auto-complete-clang-async nil t)
                        (executable-find "clang-complete"))
               (setq ac-clang-complete-executable "clang-complete")
               (setq ac-sources '(ac-source-clang-async))
               (ac-clang-launch-completion-process)
               (global-auto-complete-mode t)
               (defun ac-cc-mode-setup nil)
               (defun ac-c++-mode-setup nil)
               )
             ))

;; Makefile が無くてもC/C++のチェック
(defun flymake-simple-make-or-generic-init (cmd &optional opts)
  (if (file-exists-p "Makefile")
      (flymake-simple-make-init-intemp)
    (flymake-simple-generic-init cmd opts)))

(defun flymake-c-init ()
  (flymake-simple-make-or-generic-init
   "gcc" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

(defun flymake-cc-init ()
  (flymake-simple-make-or-generic-init
   "g++" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

;; add major-mode to flymake
(push '("c-mode" flymake-c-init) flymake-allowed-major-mode)
(push '("c\\+\\+-mode" flymake-c-init) flymake-allowed-major-mode)
;; old style
;;(push '("\\.[cC]\\'" flymake-c-init) flymake-allowed-file-name-masks)
;;(push '("\\.\\(?:cc\\|cpp\\|CC\\|CPP\\)\\'" flymake-cc-init) flymake-allowed-file-name-masks)
