
;; lisp load path recursively
(let ((default-directory "~/local/common/emacs/elisp"))
  (setq load-path (cons default-directory load-path))
  (normal-top-level-add-subdirs-to-load-path))

(setq package-user-dir "~/local/common/emacs/package")
(package-initialize)

;; init-loader
;; (auto-install-from-gist "https://gist.github.com/1021706")
(require 'init-loader)
(setq init-loader-show-log-after-init t)
(init-loader-load "~/local/common/emacs/load")
