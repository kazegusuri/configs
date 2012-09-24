
;;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/local/common/emacs/elisp/auto-install")
(auto-install-compatibility-setup)
(setq auto-install-save-confirm nil)


;;; llvm
(require 'llvm-mode nil t)
(require 'tablegen-mode nil t)

(setq auto-mode-alist
      (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
