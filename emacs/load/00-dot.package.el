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
    ascii
    auto-complete
    auto-complete-clang
    auto-highlight-symbol
    color-moccur
    cperl-mode
    dash
    diff-hl
    dockerfile-mode
    dsvn
    exec-path-from-shell
    flycheck
    flycheck-color-mode-line
    flycheck-pos-tip
    flymake-yaml
    fuzzy
    gccsense
    git-gutter+
    golden-ratio
    google-c-style
    go-mode
    go-guru
    go-eldoc
    go-autocomplete
    haml-mode
    init-loader
    ipython
    jaunte
    js2-mode
    json-mode
    json-reformat
    json-snatcher
    magit
    mmm-mode
    multi-term
;    perl-completion
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
    yaml-mode
    yari
    yasnippet
    yatex
    markdown-mode
    flymake-yaml
    diminish
    helm
    helm-ls-git
    helm-git-grep
    helm-ag
    helm-go-package
    helm-ghq
    protobuf-mode
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
