
;; default dir?
(setq default-directory "~/")

(setq temporary-file-directory "~/.emacs.d/tmp/")

;; original super key map
(setq my-keyjack-mode-map (make-sparse-keymap))
(easy-mmode-define-minor-mode my-keyjack-mode "Grab keys"
                              t " Keyjack" my-keyjack-mode-map)

;; cc-mode
(load "~/local/common/emacs/dot.cc.el");
;; asm-mode
(load "~/local/common/emacs/dot.asm.el");
;; python-mode
(load "~/local/common/emacs/dot.python.el");
;; js-mode
(load "~/local/common/emacs/dot.js.el");
;; php-mode
;;(load "~/local/common/emacs/dot.php.el");
;; css-mode
(load "~/local/common/emacs/dot.css.el");
(setq auto-mode-alist
      (cons '("\\.el$" . emacs-lisp-mode) auto-mode-alist))

;; add zsh conf files to sh-mode
(setq auto-mode-alist
      (cons '("\\(zshrc\\|zshlogin\\|zshlogout\\|zshenv\\)" . sh-mode) auto-mode-alist))


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


;; tramp
(setq tramp-default-method "ssh")


;; recently used files
(require 'recentf)
(setq recentf-save-file "~/.emacs.d/recenf")
(recentf-mode 1)
(setq recentf-max-saved-items 3000)
(require 'recentf-ext)



;; C-w does backward-delete-word in minibuffer
(defun delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-word (- arg)))

(define-key minibuffer-local-map "\C-w" 'backward-delete-word)

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
(setq moccur-split-word t)
(load "moccur-edit")
(setq dmoccur-exclusion-mask
      (append '("\\~$" "\\.svn\\/\*" "GTAGS" "GRTAGS" "GSYMS" "GPATH") dmoccur-exclusion-mask))
(setq dmoccur-recursive-search t)



;; shell pop (ansi-term)
(require 'shell-pop)
;; multi-term に対応
(add-to-list 'shell-pop-internal-mode-list '("multi-term" "*terminal<1>*" '(lambda () (multi-term))))
(shell-pop-set-internal-mode "multi-term")
;;(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell shell-file-name)

(global-set-key [f8] 'shell-pop)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)


;; tab replatice with spaces
(setq-default tab-width 4 indent-tabs-mode nil)
; default tab width 4
(setq-default tab-width 4)


;; =====gtags configuration=====
(autoload 'gtags-mode "gtags" "" t)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))
(add-hook 'cscope-list-entry-hook 'hl-line-mode)
(add-hook 'gtags-select-mode-hook 'hl-line-mode)
(defun my-update-gtags () (interactive) (call-process "global" nil nil nil "-uv"))
(add-hook
 'c-mode-common-hook
 '(lambda()
    (add-hook
     'after-save-hook
     'my-update-gtags
     )
    ))


;; yankした文字列をハイライト
(when (or window-system (eq emacs-major-version '21))
  (defadvice yank (after ys:highlight-string activate)
    (let ((ol (make-overlay (mark t) (point))))
      (overlay-put ol 'face 'highlight)
      (sit-for 2)
      (delete-overlay ol)))
  (defadvice yank-pop (after ys:highlight-string activate)
    (when (eq last-command 'yank)
      (let ((ol (make-overlay (mark t) (point))))
        (overlay-put ol 'face 'highlight)
        (sit-for 2)
        (delete-overlay ol)))))


;; リージョンをバックスペースで削除
(defadvice backward-delete-char-untabify
  (around ys:backward-delete-region activate)
  (if (and transient-mark-mode mark-active)
      (delete-region (region-beginning) (region-end))
    ad-do-it))

;; turn off ksk
(setq mouse-wheel-progressive-speed nil)

;; enable scroll on xterm
(xterm-mouse-mode t)
(mouse-wheel-mode t)

;; turn off startup message
(setq inhibit-startup-message t)

;; title
(setq frame-title-format (format "%%b - %s:%%f" (system-name)))

; scroll config
(setq scroll-conservatively 1)
(setq scroll-step 1)
(setq next-screen-context-lines 10)
(require 'highlight-context-line)
(setq highlight-context-line-face 'region)

(menu-bar-mode -1)
(tool-bar-mode 0)
(column-number-mode t)
(which-function-mode 1)

; manipulate region
(define-key my-keyjack-mode-map "\C-cm" 'set-mark-command)
(define-key my-keyjack-mode-map "\C-c\C-m" 'set-mark-command)
;;(define-key my-keyjack-mode-map "\C-cc" 'kill-ring-save)
;;(define-key my-keyjack-mode-map "\C-c\C-c" 'kill-ring-save)

; goto-line
(define-key global-map "\C-xg" 'goto-line)

; insert無効
(define-key global-map [insert] 'nil)

;; \C-hでBackSpace
(global-set-key "\C-h" 'delete-backward-char)

;;Emacsのkill-ringとclipboardの同期
;(cond (window-system
       (setq x-select-enable-clipboard t)
;       ))


; shift+cursolでウィンドウ移動 (windomove)
;; (windmove-default-keybindings)
(define-key my-keyjack-mode-map "\M-h" 'windmove-left)
(define-key my-keyjack-mode-map "\M-j" 'windmove-down)
(define-key my-keyjack-mode-map "\M-k" 'windmove-up)
(define-key my-keyjack-mode-map "\M-l" 'windmove-right)

; display scroll-bar on right side
(set-scroll-bar-mode 'right)

; transient mark mode
(setq transient-mark-mode t)

;describe hogehoge
(global-set-key "\C-x\C-hk" 'describe-key)
(global-set-key "\C-x\C-hb" 'describe-bindings)
(global-set-key "\C-x\C-hf" 'describe-function)

; buffer menu
(global-set-key "\C-x\C-b" 'buffer-menu)


;;完全一行スクロール設定。「S.Namba」さん作。
(defun sane-next-line (arg)
  "Goto next line by ARG steps with scrolling sanely if needed."
  (interactive "p")
  (let ((newpt (save-excursion (line-move arg) (point))))
    (while (null (pos-visible-in-window-p newpt))
      (if (< arg 0) (scroll-down 1) (scroll-up 1)))
    (goto-char newpt)
    (setq this-command 'next-line)
    ()))
(defun sane-previous-line (arg)
  "Goto previous line by ARG steps with scrolling back sanely if needed."
  (interactive "p")
  (sane-next-line (- arg))
  (setq this-command 'previous-line)
  ())
(defun sane-newline (arg)
  "Put newline\(s\) by ARG with scrolling sanely if needed."
  (interactive "p")
  (let ((newpt (save-excursion (newline arg) (point))))
    (while (null (pos-visible-in-window-p newpt)) (scroll-up 1))
    (goto-char newpt)
    (setq this-command 'newline)
    ()))
(global-set-key [up] 'sane-previous-line)
(global-set-key [down] 'sane-next-line)
(global-set-key "\C-m" 'sane-newline)
(define-key global-map "\C-n" 'sane-next-line)  ;;;絶対1行スクロール(旧next-line)
(define-key global-map "\C-p" 'sane-previous-line);;;絶対1行スクロール(旧previous-line)

;; undo
(setq undo-limit 100000)
(setq undo-strong-limit 130000)

;; svn
(defun starts-with-p (string1 string2)
 (string= (substring string1 0 (min (length string1) (length
string2))) string2))

(defun dont-backup-commit-files-p (filename)
 (let ((filename-part (file-name-nondirectory filename)))
   (if (or (starts-with-p filename-part "svn-commit")
           (starts-with-p filename-part "bzr_log"))
       nil
     (normal-backup-enable-predicate filename))))

(setq backup-enable-predicate 'dont-backup-commit-files-p)
