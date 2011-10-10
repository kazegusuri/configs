
;; lisp load path recursively
(let ((default-directory "~/local/common/emacs/site-lisp"))
  (setq load-path (cons default-directory load-path))
;;  (setq load-path (cons "~/.emacs.d/site-lisp" load-path))
  (normal-top-level-add-subdirs-to-load-path))

(load "~/local/common/emacs/dot.style.el");
(load "~/local/common/emacs/dot.flymake.el");
(load "~/local/common/emacs/dot.common.el");  // should load after dot.style.el
;;(load "~/local/common/emacs/dot.yatex.el");
(load "~/local/common/emacs/dot.anything.el");
(load "~/local/common/emacs/dot.elscreen.el");
(load "~/local/common/emacs/dot.autocomplete.el");
