;; default dir?
(setq default-directory "~/")

(setq temporary-file-directory "~/.emacs.d/tmp/")

;; yes-noの選択肢をy-nにする
(defalias 'yes-or-no-p 'y-or-n-p)

;; add zsh conf files to sh-mode
(setq auto-mode-alist
      (cons '("\\(zshrc\\|zshlogin\\|zshlogout\\|zshenv\\)" . sh-mode) auto-mode-alist))

;; 対応する括弧を光らせる。
(show-paren-mode t)

;; キーストロークをエコーエリアに早く表示する
(setq echo-keystrokes 0.1)

;; 画面の入れ替え
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))

;; recently used files
(when (require 'recentf nil t)
  (custom-set-variables 
   '(recentf-save-file "~/.emacs.d/recenf")
   '(recentf-max-saved-items 3000)
   '(recentf-auto-cleanup 10)
   )
  (require 'recentf-ext)
  (setq recent-auto-save-timer
        (run-with-idle-timer 30 t 'recentf-save-list))
  (recentf-mode 1))

;; GDB
;;; 画面いっぱい
(setq gdb-many-windows t)
;;; 変数の上にマウスカーソルを置くと値を表示
(add-hook 'gdb-mode-hook '(lambda () (gud-tooltip-mode t)))
;;; I/O バッファを表示
(setq gdb-use-separate-io-buffer t)
;;; t にすると mini buffer に値が表示される
(setq gud-tooltip-echo-area nil)

;; moccur config
(require 'color-moccur)
(require 'moccur-edit)
(setq moccur-split-word t)
(setq dmoccur-exclusion-mask
      (append '("\\~$" "\\.svn\\/\*" "GTAGS" "GRTAGS" "GSYMS" "GPATH") dmoccur-exclusion-mask))
(setq dmoccur-recursive-search t)

;; tab replatice with spaces
(setq-default tab-width 4 indent-tabs-mode nil)
; default tab width 4
(setq-default tab-width 4)

;; yankした文字列をハイライト
(defadvice yank (after ys:highlight-string activate)
  (let ((ol (make-overlay (mark t) (point))))
    (overlay-put ol 'face 'highlight)
    (sit-for 0.2 t)
    (delete-overlay ol)))
(defadvice yank-pop (after ys:highlight-string activate)
  (when (eq last-command 'yank)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 0.1 t)
      (delete-overlay ol))))

;; リージョンをバックスペースで削除
(defadvice backward-delete-char-untabify
  (around ys:backward-delete-region activate)
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end))
    ad-do-it))

;; turn off ksk
(setq mouse-wheel-progressive-speed nil)

;; xterm-mouse-mode which enables scroll on xterm
(unless (fboundp 'track-mouse)
  (defun track-mouse (e)))
(xterm-mouse-mode t)
(require 'mouse)
(require 'mwheel)
(mouse-wheel-mode t)

;; turn off startup message
(setq inhibit-startup-message t)

;; title
(setq frame-title-format (format "%%b - %s:%%f" (system-name)))

; scroll config
(setq scroll-conservatively 1)
(setq scroll-step 1)
(setq next-screen-context-lines 10)

(menu-bar-mode -1)
(tool-bar-mode 0)
(column-number-mode t)
(which-function-mode 1)
(custom-set-faces
 '(which-func ((t (:inherit mode-line)))))

; display scroll-bar on right side
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))

; transient mark mode
(setq transient-mark-mode t)

;; undo
(setq undo-limit 100000)
(setq undo-strong-limit 130000)

(require 'jka-compr)
(require 'tar-mode)
(auto-compression-mode t)

(defun putty-windows-select-text (text &optional push)
  (with-temp-buffer
    (insert text)
    (when (executable-find "winclip")
      (call-process-region (point-min) (point-max) "winclip" nil nil))
    ))
;;(setq interprogram-cut-function 'putty-windows-select-text)
;; (setq interprogram-cut-function nil)

;; for osx
(when darwin-p
  (defun copy-from-osx ()
    (shell-command-to-string "pbpaste"))

  (defun paste-to-osx (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
        (process-send-string proc text)
        (process-send-eof proc))))

  (setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx)
  )

;; line number
(require 'linum)
(setq linum-format "%4d| ")

;; Ascii Table
(require 'ascii-table)

;; mouse behavior on Emacs24
(setq x-select-enable-clipboard nil)
(setq select-active-regions 'only)
(setq mouse-drag-copy-region t)
(setq x-select-enable-primary nil)
(global-set-key [mouse-2] 'mouse-yank-at-click)

;;Emacsのkill-ringとclipboardの同期
(cond ((and linux-p window-system)
       (setq x-select-enable-clipboard t)
       (setq interprogram-cut-function 'x-select-text)
       (setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
       ))

(require 'anything-ack)

;; バッファ自動再読み込み
(global-auto-revert-mode 1)

(require 'jaunte)
(global-set-key (kbd "C-c C-j") 'jaunte)
(setq jaunte-hint-unit 'whitespace)

(require 'sudo-ext)

(global-set-key "\C-x\C-j" 'dired-jump)

(require 'review-mode)

(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)
(require 'dsvn)


(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


;; ack
(require 'ack-and-a-half)
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)
(require 'wgrep)
(require 'wgrep-ack)

(setq wgrep-enable-key "r")


;;; powerline-mode
;;; elscreenがエラーになるので未使用
(require 'powerline)
(powerline-center-theme)

(require 'diminish)
(diminish 'ac-mode)
(diminish 'git-gutter+-mode)
(diminish 'yas-minor-mode)

(column-number-mode t) ;; 列番号の表示
(line-number-mode t) ;; 行番号の表示

;; golden-ratio
(require 'golden-ratio)
;; (golden-ratio-mode 1)

;; auto-highlight-symbol
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(ahs-set-idle-interval 0.3)

;; whitespace
(require 'whitespace)
(setq whitespace-style '(face spaces trailing space-mark tab-mark))
(setq whitespace-display-mappings
      '(
        ;; (space-mark ?\ [?\u00B7] [?.]) ; space - centered dot
        (space-mark ?\xA0 [?\u00A4] [?_]) ; hard space - currency
        (space-mark ?\x8A0 [?\x8A4] [?_]) ; hard space - currency
        (space-mark ?\x920 [?\x924] [?_]) ; hard space - currency
        (space-mark ?\xE20 [?\xE24] [?_]) ; hard space - currency
        (space-mark ?\xF20 [?\xF24] [?_]) ; hard space - currency
        (space-mark ?\u200B [?\u25a1] [?_ ?_]) ; zero-width-space - square
        (space-mark ?\u3000 [?\u25a1] [?_ ?_]) ; full-width-space - square
        ;; (newline-mark ?\n [?$ ?\n]) ; eol - dollar sign
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t]) ; tab - left quote mark
        ))

;; whitespace-spaceの定義を全角スペースにし、色をつけて目立たせる
(setq whitespace-space-regexp "\\(\u3000+\\)")
(set-face-foreground 'whitespace-space "yellow")
(set-face-background 'whitespace-space 'nil)
;; whitespace-trailingを色つきアンダーラインで目立たせる
(set-face-underline 'whitespace-trailing t)
(set-face-foreground 'whitespace-trailing "cyan")
(set-face-background 'whitespace-trailing 'nil)
(global-whitespace-mode 1)

;; git-gutter
(global-git-gutter+-mode)

;; yaml
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(require 'flymake-yaml)
(add-hook 'yaml-mode-hook 'flymake-yaml-load)

;; json
(require 'json-mode)

;; encoding
(when darwin-p
  (require 'ucs-normalize)
  (prefer-coding-system 'utf-8)
  (set-file-name-coding-system 'utf-8-hfs)
  (setq locale-coding-system 'utf-8)
  (set-default-coding-systems 'utf-8)
  (set-buffer-file-coding-system 'utf-8)
  (set-clipboard-coding-system 'utf-8)
  )

;; markdown
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\$" . gfm-mode))
(setq markdown-command "marked")
