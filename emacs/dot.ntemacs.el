
;; lisp load path recursively
(let ((default-directory "~/local/common/emacs/site-lisp"))
  (setq load-path (cons default-directory load-path))
  (setq load-path (cons "~/.emacs.d/site-lisp" load-path))
  (normal-top-level-add-subdirs-to-load-path))

;;(setq semantic-load-turn-everything-on t)
;;(require 'semantic-load)

(load "~/local/common/emacs/dot.common.el");
(load "~/local/common/emacs/dot.style.el");
;;(load "~/local/common/emacs/dot.yatex.el");
;;(load "~/local/common/emacs/dot.anthy.el");
(load "~/local/common/emacs/dot.anything.el");
(load "~/local/common/emacs/dot.elscreen.el");
(load "~/local/common/emacs/dot.autocomplete.el");
;;(load "~/local/common/emacs/dot.windows.el");

