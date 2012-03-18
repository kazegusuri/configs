;; coloring
(global-font-lock-mode t)

;; default dir?
(setq default-directory "~/")

(setq temporary-file-directory "~/.emacs.d/tmp/")

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
(when (require 'recentf nil t)
  (require 'recentf-ext)
  (custom-set-variables '(recentf-save-file "~/.emacs.d/recenf"))
  (setq recentf-max-saved-items 3000)
  (setq recentf-auto-cleanup 10)
  (setq recent-auto-save-timer
        (run-with-idle-timer 30 t 'recent-save-list))
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
(setq moccur-split-word t)
(load "moccur-edit")
(setq dmoccur-exclusion-mask
      (append '("\\~$" "\\.svn\\/\*" "GTAGS" "GRTAGS" "GSYMS" "GPATH") dmoccur-exclusion-mask))
(setq dmoccur-recursive-search t)

;; tab replatice with spaces
(setq-default tab-width 4 indent-tabs-mode nil)
; default tab width 4
(setq-default tab-width 4)


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
;; (require 'highlight-context-line)
;; (setq highlight-context-line-face 'region)

(menu-bar-mode -1)
(tool-bar-mode 0)
(column-number-mode t)
(which-function-mode 1)

;;Emacsのkill-ringとclipboardの同期
(cond (window-system
       (setq x-select-enable-clipboard t)
      ))

; display scroll-bar on right side
(set-scroll-bar-mode 'right)

; transient mark mode
(setq transient-mark-mode t)

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
(setq interprogram-cut-function nil)

;; avoid msg "symbolic link to SVN-controlled source file"
(setq vc-follow-symlinks t)

(setq eval-expression-print-length nil)
