(require 'package)

;; package directory
(setq package-user-dir "~/local/common/emacs/package")

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
    ack-and-a-half
    anti-zenburn-theme
    anything
    anything-extension
    anything-git
    anything-git-files
    anything-git-goto
    ascii
    auto-complete
    auto-complete-clang
    auto-install
    color-moccur
    cperl-mode
    descbinds-anything
    diff-hl
    dired+
    dropdown-list
    dsvn
    eldoc-extension
    exec-path-from-shell
    fuzzy
    gccsense
    golden-ratio
    google-c-style
    haml-mode
    init-loader
    ipython
    jaunte
    js2-mode
    mmm-mode
    multi-term
    perl-completion
    php-extras
    php-mode
    popup
    powerline
    pymacs
    pysmell
    python-mode
    quickrun
    recentf-ext
    ruby-mode
    shell-pop
    sudo-ext
    wgrep
    wgrep-ack
    yasnippet
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
