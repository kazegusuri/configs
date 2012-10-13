(require 'package)

(setq package-user-dir my-package-directory)

; Add package-archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defun my-package-install-from-url (url)
  (switch-to-buffer (url-retrieve-synchronously url))
  (package-install-from-buffer  (package-buffer-info) 'single))

;; install melpa automatically
(when (not (package-installed-p 'melpa))
  (my-package-install-from-url "https://raw.github.com/milkypostman/melpa/master/melpa.el"))

; melpa.el
(require 'melpa)

(require 'cl)

(defvar installing-package-list
  '(
    php-mode
    php-extras
    mmm-mode
    dsvn
    color-moccur
    js2-mode
    cperl-mode
    ascii
    google-c-style
    quickrun
    pymacs
    pysmell
    python-mode
    ipython
    gccsense
    multi-term
    wgrep
    dired+
    popup
    fuzzy
    auto-complete

    anything
    anything-obsolete
    anything-match-plugin
    anything-config
    anything-complete
    anything-show-completion
    descbinds-anything
    anything-extension
    anything-git
    anything-git-goto
    ))

(defun install-package-if-not-installed (package-list)
  (let ((not-installed (loop for x in package-list
                             when (not (package-installed-p x))
                             collect x)))
    (when not-installed
      (package-refresh-contents)
      (dolist (pkg not-installed)
        (package-install pkg)))))

(install-package-if-not-installed installing-package-list)
