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

(require 'cl)

(defvar installing-package-list
  '(
    ack-and-a-half
    ag
    anti-zenburn-theme
    anything
    anything-git-files
    anything-git-grep
    ascii
    auto-complete
    auto-complete-clang
    auto-highlight-symbol
    auto-install
    color-moccur
    cperl-mode
    dash
    descbinds-anything
    diff-hl
    dired+
    dropdown-list
    dsvn
    eldoc-extension
    exec-path-from-shell
    flycheck
    flycheck-color-mode-line
    flycheck-pos-tip
    fuzzy
    gccsense
    git-gutter+
    golden-ratio
    google-c-style
    go-mode
    go-autocomplete
    haml-mode
    init-loader
    ipython
    jaunte
    js2-mode
    magit
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
    robe
    rspec-mode
    ruby-mode
    shell-pop
    sudo-ext
    wgrep
    wgrep-ack
    wgrep-ag
    yari
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
