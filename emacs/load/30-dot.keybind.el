
;; original super key map
(setq my-keyjack-mode-map (make-sparse-keymap))
(easy-mmode-define-minor-mode my-keyjack-mode "Grab keys"
                              t " Keyjack" my-keyjack-mode-map)

; manipulate region
(define-key my-keyjack-mode-map "\C-o" 'set-mark-command)
;;(define-key my-keyjack-mode-map "\C-cm" 'set-mark-command)
;;(define-key my-keyjack-mode-map "\C-c\C-m" 'set-mark-command)
;;(define-key my-keyjack-mode-map "\C-cc" 'kill-ring-save)
;;(define-key my-keyjack-mode-map "\C-c\C-c" 'kill-ring-save)


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

;; \C-hでBackSpace
(global-set-key "\C-h" 'delete-backward-char)
; goto-line
(global-set-key "\C-xg" 'goto-line)
; buffer menu
(global-set-key "\C-x\C-b" 'buffer-menu)
; insert無効
(global-set-key [insert] 'nil)

; shift+cursolでウィンドウ移動 (windomove)
;; (windmove-default-keybindings)
(define-key my-keyjack-mode-map "\M-h" 'windmove-left)
(define-key my-keyjack-mode-map "\M-j" 'windmove-down)
(define-key my-keyjack-mode-map "\M-k" 'windmove-up)
(define-key my-keyjack-mode-map "\M-l" 'windmove-right)


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

;; quickrun
(require 'quickrun)
(define-key my-keyjack-mode-map [f5] 'quickrun)
