
;;; gtags
(autoload 'gtags-mode "gtags" "" t)
(add-hook 'gtags-mode-hook
      '(lambda ()
         (setenv "GTAGSLABEL" "pygments")
         (local-set-key "\M-t" 'gtags-find-tag)
         (local-set-key "\M-r" 'gtags-find-rtag)
         (local-set-key "\M-s" 'gtags-find-symbol)
         (local-set-key "\C-t" 'gtags-pop-stack)
         ))
(add-hook 'cscope-list-entry-hook 'hl-line-mode)
(add-hook 'gtags-select-mode-hook 'hl-line-mode)

(defun my-gtags-root-dir ()
  "Returns GTAGS root directory or nil if doesn't exist."
  (with-temp-buffer
    (if (zerop (call-process "global" nil t nil "-pr"))
        (buffer-substring (point-min) (1- (point-max)))
      nil)))

(defun my-gtags-update ()
  "Make GTAGS incremental update"
  (interactive)
  ;; (when (executable-find "global")
  ;;   (call-process "global" nil nil nil "-u")))
  (when (executable-find "global-update-async")
    (call-process "global-update-async" nil nil nil "-u")))


(defun my-gtags-update-hook ()
  (when (my-gtags-root-dir)
    (my-gtags-update)))

(add-hook 'after-save-hook #'my-gtags-update-hook)

(setq anything-gtags-hijack-gtags-select-mode nil)
