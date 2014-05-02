
;; WoMan config ( before anything sources )
(setq woman-manpath '("/usr/share/man/ja"
                      "/usr/share/man"))
(setq woman-use-own-frame nil)
(setq woman-imenu-generic-expression
      '((nil "^\\(   \\)?\\([ぁ-んァ-ヴー一-龠ａ-ｚＡ-Ｚ０-９a-zA-Z0-9]+\\)" 2)))

;; anything
(require 'anything)
(require 'anything-startup)
(require 'anything-gtags)
(require 'anything-git-files)
(require 'anything-git-grep)

(setq anything-idle-delay 0.2)          ;; 候補を表示するまでの時間
(setq anything-input-idle-delay 0.2)    ;; 再描写するまでの時間
(setq anything-quick-update t)
(setq anything-enable-shortcuts 'alphabet) ;; 候補選択ショートカット
(setq anything-su-or-sudo "sudo")

;; monkey patch
(defadvice anything-update (before pre-anything-update activate)
  (setq anything-input-idle-delay 0.0)
  )

;; define anything-command-map-prefix-key
(setq anything-command-map-prefix-key "\C-j")
(define-key my-keyjack-mode-map "\C-j" 'anything-command-map)

;; define key-bindings
(define-key anything-map (kbd "M-n") 'anything-next-source)
(define-key anything-map (kbd "M-p") 'anything-previous-source)
(define-key anything-map (kbd "C-i") 'anything-execute-persistent-action)
(define-key anything-map (kbd "C-z") 'anything-select-action)
(define-key anything-map (kbd "C-w") 'backward-delete-word)
(define-key anything-map (kbd "C-w") 'backward-delete-word)

(setq anything-gtags-hijack-gtags-select-mode nil)

;;; anything-c-moccur
;; (auto-install-from-url "http://svn.coderepos.org/share/lang/elisp/anything-c-moccur/trunk/anything-c-moccur.el")
(require 'anything-c-moccur)
(setq moccur-split-word t)
(setq anything-c-moccur-anything-idle-delay 0.1
      anything-c-moccur-higligt-info-line-flag t
      anything-c-moccur-enable-auto-look-flag t
      anything-c-moccur-enable-initial-pattern t)
(global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur)
(define-key isearch-mode-map (kbd "C-o") 'anything-c-moccur-from-isearch)

;; anything-obsolete
(require 'anything-obsolete)
(anything-read-string-mode '(string file buffer variable command))
(setq anything-find-file-additional-sources '(anything-c-source-recentf))

;; anything-migemo
(when (and (executable-find "cmigemo")
           (require 'migemo nil t))
  (setq moccur-use-migemo t))

;;split-window
(defun anything-split-window (buf)
  (split-window)
  (other-window 1)
  (switch-to-buffer buf))
(setq anything-display-function 'anything-split-window)

;; define skip buffers regexp
(setq my-anything-c-boring-buffer-regexp
  (rx (or
       (group bos  " ")
       ;; anything-buffer
       "*anything"
       ;; echo area
       " *Echo Area" " *Minibuf"
       "*")))

;; skip buffer
(defvar my-anything-c-source-buffers+
  '((name . "Buffers")
    (candidates . anything-c-buffer-list)
    (type . buffer)
    (candidate-transformer anything-c-skip-current-buffer
                           anything-c-highlight-buffers
                           (lambda (buffers)
                             (anything-c-skip-entries buffers my-anything-c-boring-buffer-regexp)))
  (persistent-action . anything-c-buffers+-persistent-action)))

;; goto-line source
(setq anything-c-source-goto-line
      '((name . "Goto line")
        (filtered-candidate-transformer . (lambda (candidates source)
                                            (if (string-match "^[0-9]*$" anything-pattern)
                                                (with-current-buffer anything-current-buffer
                                                  (if (>= (max-line) (string-to-number anything-pattern))
                                                      (list (concat "line number: " anything-pattern))
                                                    nil))
                                              nil)
                                            ))
        (persistent-action . (lambda (candidate)
                               (if (string-match "[0-9]*$" candidate)
                                   (progn
                                     (anything-goto-line (string-to-number (match-string 0 candidate)))
                                     (anything-match-line-color-current-line)))))
        (action . (("Goto line" . (lambda (arg)
                                    (if (string-match "[0-9]*$" arg)
                                        (let ((line-number (string-to-number (match-string 0 arg))))
                                          (goto-line line-number)))))))
        ))

(defun tarao/anything-for-files ()
  (interactive)
  (require 'anything-config)
  (require 'anything-git-files)
  (let* ((git-source (and (anything-git-files:git-p)
                          `(anything-git-files:modified-source
                            anything-git-files:untracked-source
                            anything-git-files:all-source
                            ,@(anything-git-files:submodule-sources 'all))))
         (other-source '(anything-c-source-recentf
                         anything-c-source-bookmarks
                         anything-c-source-files-in-current-dir+
                         anything-c-source-locate))
         (sources `(anything-c-source-buffers+
                    anything-c-source-ffap-line
                    anything-c-source-ffap-guesser
                    ,@git-source
                    ,@other-source)))
    (anything-other-buffer sources "*anything for files*")))

(defun anything-my-goto-line ()
  "`anything' for goto line."
  (interactive)
  (anything-other-buffer 'anything-c-source-goto-line "*anything goto line*"))

(defun anything-select-elscreen ()
  "`anything' for elscreen."
  (interactive)
  (anything-other-buffer 'anything-c-source-elscreen "*anything elscreen*"))


;; (define-key anything-command-map (kbd "<SPC>") 'anything-execute-anything-command)
;; (define-key anything-command-map (kbd "e") 'anything-etags-maybe-at-point)
;; (define-key anything-command-map (kbd "l") 'anything-locate)
;; (define-key anything-command-map (kbd "s") 'anything-surfraw)
;; (define-key anything-command-map (kbd "r") 'anything-regexp)
;; (define-key anything-command-map (kbd "w") 'anything-w3m-bookmarks)
;; (define-key anything-command-map (kbd "x") 'anything-firefox-bookmarks)
;; (define-key anything-command-map (kbd "#") 'anything-emms)
;; (define-key anything-command-map (kbd "m") 'anything-man-woman)
;; (define-key anything-command-map (kbd "t") 'anything-top)
;; (define-key anything-command-map (kbd "i") 'anything-imenu)
;; (define-key anything-command-map (kbd "p") 'anything-list-emacs-process)
;; (define-key anything-command-map (kbd "C-x r b") 'anything-c-pp-bookmarks)
;; (define-key anything-command-map (kbd "M-y") 'anything-show-kill-ring)
;; (define-key anything-command-map (kbd "C-c <SPC>") 'anything-all-mark-rings)
;; (define-key anything-command-map (kbd "C-x C-f") 'anything-find-files)
;; (define-key anything-command-map (kbd "f") 'anything-for-files)
;; (define-key anything-command-map (kbd "C-:") 'anything-eval-expression-with-eldoc)
;; (define-key anything-command-map (kbd "C-,") 'anything-calcul-expression)
;; (define-key anything-command-map (kbd "M-x") 'anything-M-x)
;; (define-key anything-command-map (kbd "C-x C-w") 'anything-write-file)
;; (define-key anything-command-map (kbd "C-x i") 'anything-insert-file)
;; (define-key anything-command-map (kbd "M-s o") 'anything-occur)
;; (define-key anything-command-map (kbd "M-g s") 'anything-do-grep)
;; (define-key anything-command-map (kbd "c") 'anything-colors)
;; (define-key anything-command-map (kbd "F") 'anything-select-xfont)
;; (define-key anything-command-map (kbd "C-c f") 'anything-recentf)
;; (define-key anything-command-map (kbd "C-c g") 'anything-google-suggest)
;; (define-key anything-command-map (kbd "h i") 'anything-info-at-point)
;; (define-key anything-command-map (kbd "h r") 'anything-info-emacs)
;; (define-key anything-command-map (kbd "C-x C-b") 'anything-buffers+)
;; (define-key anything-command-map (kbd "C-c C-b") 'anything-browse-code)
;; (define-key anything-command-map (kbd "C-x r i") 'anything-register)
;; (define-key anything-command-map (kbd "C-c C-x") 'anything-c-run-external-command)
(define-key anything-command-map (kbd "b") 'anything-buffers+)
(define-key anything-command-map (kbd "e") 'anything-select-elscreen)
(define-key anything-command-map (kbd "g") 'anything-git-files)
(define-key anything-command-map (kbd "G") 'anything-git-grep)

