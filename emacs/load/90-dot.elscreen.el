
;; no-windowでelscreenを使うか
(setq enable-elscreen-on-nw t)

(when (or window-system enable-elscreen-on-nw)
  (progn
    ;; Server Mode
    ;;(server-start)

    ;; elscreen起動
    (require 'elscreen)
    (elscreen-start)
    (require 'elscreen-buffer-list)
    ;; (require 'elscreen-gf)
    ;; (require 'elscreen-color-theme)
    (require 'elscreen-server)
    (require 'elscreen-gtags)

    ;; Prefix key
    (setq elscreen-prefix-key "\C-z")
    (define-key elscreen-map "\C-z" 'suspend-emacs)

    ;; フレーム毎にバッファリストをソート
    (setq elscreen-buffer-list-enabled 1)

    ;; display control tab
    (setq elscreen-tab-display-control nil)

    ;; タブの横のXを消す
    (setq elscreen-tab-display-kill-screen nil)

    ;; drag-and-drop
    (setq elscreen-dnd-open-file-new-screen t)

    ;; Don't show tab number in mode-line
    (remove-hook 'elscreen-screen-update-hook 'elscreen-mode-line-update)

    ;; face
    (custom-set-faces
     '(elscreen-tab-other-screen-face ((t (:background "brightblack" :foreground "white" :underline nil)))))

    ;; Commands
    (global-set-key "\M-0" '(lambda () (interactive) (elscreen-goto 9)))
    (global-set-key "\M-1" '(lambda () (interactive) (elscreen-goto 0)))
    (global-set-key "\M-2" '(lambda () (interactive) (elscreen-goto 1)))
    (global-set-key "\M-3" '(lambda () (interactive) (elscreen-goto 2)))
    (global-set-key "\M-4" '(lambda () (interactive) (elscreen-goto 3)))
    (global-set-key "\M-5" '(lambda () (interactive) (elscreen-goto 4)))
    (global-set-key "\M-6" '(lambda () (interactive) (elscreen-goto 5)))
    (global-set-key "\M-7" '(lambda () (interactive) (elscreen-goto 6)))
    (global-set-key "\M-8" '(lambda () (interactive) (elscreen-goto 7)))
    (global-set-key "\M-9" '(lambda () (interactive) (elscreen-goto 8)))

    (global-set-key "\C-x\C-c" 'elscreen-kill-screen-and-buffers)
    (global-set-key "\C-c\C-x" 'save-buffers-kill-emacs)
    ;;(global-set-key "\C-x#" 'kill-emacs)
    (global-set-key "\C-x#" 'save-buffers-kill-emacs)


    ;; タブを消した時タブをつめる
    (defun elscreen-insert-internal (screen)
      (elscreen-clone screen)
      (elscreen-kill-internal screen))

    (defun elscreen-get-gap-next ()
      (let ((screen-list (sort (elscreen-get-screen-list) '<))
            (screen 0))
        (while (eq (nth screen screen-list) screen)
          (setq screen (+ screen 1)))
        (nth screen screen-list)))

    (defun elscreen-get-packed-num ()
      (let ((screen-list (sort (elscreen-get-screen-list) '<))
            (current-screen (elscreen-get-current-screen))
            (screen 0))
        (while (not (eq (nth screen screen-list) current-screen))
          (setq screen (+ screen 1)))
        screen))

    (defun elscreen-pack-list ()
      (interactive)
      (let ((next (elscreen-get-gap-next))
            (pack (elscreen-get-packed-num)))
        (while next
          (elscreen-insert-internal next)
          (setq next (elscreen-get-gap-next)))
        (elscreen-goto pack)
        (elscreen-notify-screen-modification 'force)))

    ;;killしたらpackする
    (add-hook 'elscreen-kill-hook 'elscreen-pack-list)

    ;;swap前後で同じバッファを表示
    (defadvice elscreen-swap
      (after elscreen-swap-jump activate)
      (elscreen-goto (elscreen-get-previous-screen)))


    ;; Default Commands
    ;;(define-key elscreen-map "\C-c" 'elscreen-create)
    ;;(define-key elscreen-map "c"    'elscreen-create)
    ;;(define-key elscreen-map "C"    'elscreen-clone)
    ;;(define-key elscreen-map "\C-k" 'elscreen-kill)
    ;;(define-key elscreen-map "k"    'elscreen-kill)
    ;;(define-key elscreen-map "\M-k" 'elscreen-kill-screen-and-buffers)
    ;;(define-key elscreen-map "K"    'elscreen-kill-others)
    ;;(define-key elscreen-map "\C-p" 'elscreen-previous)
    ;;(define-key elscreen-map "p"    'elscreen-previous)
    ;;(define-key elscreen-map "\C-n" 'elscreen-next)
    ;;(define-key elscreen-map "n"    'elscreen-next)
    ;;(define-key elscreen-map "\C-a" 'elscreen-toggle)
    ;;(define-key elscreen-map "a"    'elscreen-toggle)
    ;;(define-key elscreen-map "'"    'elscreen-goto)
    ;;(define-key elscreen-map "\""   'elscreen-select-and-goto)
    ;;(define-key elscreen-map "0"    'elscreen-jump-0)
    ;;(define-key elscreen-map "1"    'elscreen-jump)
    ;;(define-key elscreen-map "2"    'elscreen-jump)
    ;;(define-key elscreen-map "3"    'elscreen-jump)
    ;;(define-key elscreen-map "4"    'elscreen-jump)
    ;;(define-key elscreen-map "5"    'elscreen-jump)
    ;;(define-key elscreen-map "6"    'elscreen-jump)
    ;;(define-key elscreen-map "7"    'elscreen-jump)
    ;;(define-key elscreen-map "8"    'elscreen-jump)
    ;;(define-key elscreen-map "9"    'elscreen-jump-9)
    ;;(define-key elscreen-map "\C-s" 'elscreen-swap)
    ;;(define-key elscreen-map "\C-w" 'elscreen-display-screen-name-list)
    ;;(define-key elscreen-map "w"    'elscreen-display-screen-name-list)
    ;;(define-key elscreen-map "\C-m" 'elscreen-display-last-message)
    ;;(define-key elscreen-map "m"    'elscreen-display-last-message)
    ;;(define-key elscreen-map "\C-t" 'elscreen-display-time)
    ;;(define-key elscreen-map "t"    'elscreen-display-time)
    ;;(define-key elscreen-map "A"    'elscreen-screen-nickname)
    ;;(define-key elscreen-map "b"    'elscreen-find-and-goto-by-buffer)
    ;;(define-key elscreen-map "\C-f" 'elscreen-find-file)
    ;;(define-key elscreen-map "\C-r" 'elscreen-find-file-read-only)
    ;;(define-key elscreen-map "d"    'elscreen-dired)
    ;;(define-key elscreen-map "\M-x" 'elscreen-execute-extended-command)
    ;;(define-key elscreen-map "i"    'elscreen-toggle-display-screen-number)
    ;;(define-key elscreen-map "T"    'elscreen-toggle-display-tab)
    ;;(define-key elscreen-map "?"    'elscreen-help)
    ;;(define-key elscreen-map "v"    'elscreen-display-version)
    ;;(define-key elscreen-map "j"    'elscreen-link)
    ;;(define-key elscreen-map "s"    'elscreen-split)
    )
  )
