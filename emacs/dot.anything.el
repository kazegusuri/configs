
;; WoMan config ( before anything sources )
(setq woman-manpath '("/usr/share/man/ja"
                      "/usr/share/man"))
(setq woman-use-own-frame nil)
(setq woman-imenu-generic-expression
      '((nil "^\\(   \\)?\\([ぁ-んァ-ヴー一-龠ａ-ｚＡ-Ｚ０-９a-zA-Z0-9]+\\)" 2)))

(require 'anything-startup)
;;(require 'anything-config)
(require 'anything-gtags)
;; (require 'anything-include)
(require 'anything-match-plugin) ;; スペースでand検索(重い)
;; (setq anything-mp-match-source-name nil)
(setq anything-gtags-hijack-gtags-select-mode nil)
(setq recentf-max-saved-items 500)
(recentf-mode 1)

;;(setq anything-c-filelist-file-name "~/.emacs.d/all.filelist")
;;(setq anything-grep-candidates-fast-directory-regexp "^~/tmp/.emacs.d")



;; anything-moccur
;;(require 'anything-c-moccur)
(setq moccur-split-word t)
(when (require 'migemo nil t)
  (setq moccur-use-migemo t))
;;(setq anything-c-moccur-anything-idle-delay 0.2 
;;      anything-c-moccur-higligt-info-line-flag t
;;      anything-c-moccur-enable-auto-look-flag t
;;      anything-c-moccur-enable-initial-pattern t)
;;(define-key isearch-mode-map (kbd "C-o") 'anything-c-moccur-from-isearch)



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

;; anything-goto-line
(defun anything-my-goto-line ()
  "`anything' for goto line."
  (interactive)
  (anything-other-buffer 'anything-c-source-goto-line "*anything goto line*"))

;; anything-my-manpages
(defun my-anything-man ()
  "Preconfigured `anything' for `manpages'."
  (interactive)
  (anything (list anything-c-source-man-pages
                  anything-c-source-info-pages)
            nil nil nil nil "*anything man*"))

(defun my-anything-others ()
  (interactive)
  (anything (list anything-c-source-man-pages
                  anything-c-source-info-pages
                  anything-c-source-emacs-commands)
            nil nil nil nil "*anything others*"))

;; elscreen
(defun anything-select-elscreen ()
  "`anything' for elscreen."
  (interactive)
  (anything-other-buffer 'anything-c-source-elscreen "*anything elscreen*"))


;; define command map for anything
(setq anything-command-map-prefix-key "\C-j")
(define-key my-keyjack-mode-map "\C-j" 'anything-command-map)

(define-key anything-map (kbd "M-n") 'anything-next-source)
(define-key anything-map (kbd "M-p") 'anything-previous-source)
(define-key anything-map (kbd "C-i") 'anything-execute-persistent-action)
(define-key anything-map (kbd "C-z") 'anything-select-action)

;; default commands
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
(define-key anything-command-map (kbd "g") 'anything-my-goto-line)
