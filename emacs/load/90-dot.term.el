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


;; ansi-term
(defvar ansi-term-after-hook nil)

(defadvice ansi-term (after ansi-term-after-advice (arg))
  "run hook as after advice"
  (run-hooks 'ansi-term-after-hook))
(ad-activate 'ansi-term)

(defadvice anything-c-kill-ring-action (around my-anything-kill-ring-term-advice activate)
  "In term-mode, use `term-send-raw-string' instead of `insert-for-yank'"
  (if (eq major-mode 'term-mode)
      (letf (((symbol-function 'insert-for-yank) (symbol-function 'term-send-raw-string)))
        ad-do-it)
    ad-do-it))

(defun my-term-switch-line-char ()
  "Switch `term-in-line-mode' and `term-in-char-mode' in `ansi-term'"
  (interactive)
  (cond
   ((term-in-line-mode)
    (term-char-mode)
    (hl-line-mode -1))
   ((term-in-char-mode)
    (term-line-mode)
    (hl-line-mode 1))))

(require 'term)
(defun visit-ansi-term ()
  "If the current buffer is:
     1) a running ansi-term named *ansi-term*, rename it.
     2) a stopped ansi-term, kill it and create a new one.
     3) a non ansi-term, go to an already running ansi-term
        or start a new one while killing a defunt one"
  (interactive)
  (let ((is-term (string= "term-mode" major-mode))
        (is-running (term-check-proc (buffer-name)))
        (term-cmd "/bin/zsh")
        (anon-term (get-buffer "*ansi-term*")))
    (if is-term
        (if is-running
            (if (string= "*ansi-term*" (buffer-name))
                (call-interactively 'rename-buffer)
              (if anon-term
                  (switch-to-buffer "*ansi-term*")
                (ansi-term term-cmd)))
          (kill-buffer (buffer-name))
          (ansi-term term-cmd))
      (if anon-term
          (if (term-check-proc "*ansi-term*")
              (switch-to-buffer "*ansi-term*")
            (kill-buffer "*ansi-term*")
            (ansi-term term-cmd))
        (ansi-term term-cmd)))))
(global-set-key (kbd "<f2>") 'visit-ansi-term)

(add-hook 'ansi-term-after-hook
          (lambda ()
            (define-key term-raw-map [f8] 'shell-pop)
            ;; これがないと M-x できなかったり
            (define-key term-raw-map (kbd "M-x") 'nil)
            (define-key term-raw-map (kbd "M-0") 'nil)
            (define-key term-raw-map (kbd "M-1") 'nil)
            (define-key term-raw-map (kbd "M-2") 'nil)
            (define-key term-raw-map (kbd "M-3") 'nil)
            (define-key term-raw-map (kbd "M-4") 'nil)
            (define-key term-raw-map (kbd "M-5") 'nil)
            (define-key term-raw-map (kbd "M-6") 'nil)
            (define-key term-raw-map (kbd "M-7") 'nil)
            (define-key term-raw-map (kbd "M-8") 'nil)
            (define-key term-raw-map (kbd "M-9") 'nil)
            ;; コピー, 貼り付け
            (define-key term-raw-map (kbd "C-k")
              (lambda (&optional arg) (interactive "P") (funcall 'kill-line arg) (term-send-raw)))
            (define-key term-raw-map (kbd "C-y") 'term-paste)
            (define-key term-raw-map (kbd "M-y") 'anything-show-kill-ring)
            ;; C-t で line-mode と char-mode を切り替える
            (define-key term-raw-map  "\C-t" 'my-term-switch-line-char)
            (define-key term-mode-map "\C-t" 'my-term-switch-line-char)
            ))

;; multi-term
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(setq multi-term-program shell-file-name)
(add-hook 'term-mode-hook
          '(lambda ()
            (define-key term-raw-map [f8] 'shell-pop)
            ;; これがないと M-x できなかったり
            (define-key term-raw-map (kbd "M-x") 'nil)
            (define-key term-raw-map (kbd "M-0") 'nil)
            (define-key term-raw-map (kbd "M-1") 'nil)
            (define-key term-raw-map (kbd "M-2") 'nil)
            (define-key term-raw-map (kbd "M-3") 'nil)
            (define-key term-raw-map (kbd "M-4") 'nil)
            (define-key term-raw-map (kbd "M-5") 'nil)
            (define-key term-raw-map (kbd "M-6") 'nil)
            (define-key term-raw-map (kbd "M-7") 'nil)
            (define-key term-raw-map (kbd "M-8") 'nil)
            (define-key term-raw-map (kbd "M-9") 'nil)
            ;; コピー, 貼り付け
;            (define-key term-raw-map (kbd "C-k")
;              (lambda (&optional arg) (interactive "P") (funcall 'kill-line arg) (term-send-raw)))
            (define-key term-raw-map "\C-p" 'term-send-raw)
            (define-key term-raw-map "\C-n" 'term-send-raw)
            (define-key term-raw-map "\C-h" 'term-send-raw)
            (define-key term-raw-map "\C-c" 'term-send-raw)
            (define-key term-raw-map (kbd "C-y") 'term-paste)
            (define-key term-raw-map (kbd "M-y") 'anything-show-kill-ring)
;;            (define-key term-raw-map (kbd "ESC") 'term-send-raw)

            ;; C-t で line-mode と char-mode を切り替える
            (define-key term-raw-map  "\C-t" 'my-term-switch-line-char)
            (define-key term-mode-map "\C-t" 'my-term-switch-line-char)
            ))

(global-set-key (kbd "C-c t") '(lambda ()
                                (interactive)
                                (multi-term)))
(global-set-key (kbd "C-c n") 'multi-term-next)
(global-set-key (kbd "C-c p") 'multi-term-prev)
