

;; Flymake
(require 'flymake)

;; set when debugging
;;(setq flymake-log-level 3)

;; GUIの警告は表示しない
(setq flymake-gui-warnings-enabled nil)

;; 全てのファイルで flymakeを有効化
;;(add-hook 'find-file-hook 'flymake-find-file-hook)

;; M-p/M-n で警告/エラー行の移動
(global-set-key "\M-p" 'flymake-goto-prev-error)
(global-set-key "\M-n" 'flymake-goto-next-error)

;; エラー表示
;; (global-set-key "\C-ce" 'flymake-my-display-err-popup-for-current-line)

;; Minibuf に出力
(defun flymake-my-display-err-minibuf-for-current-line ()
  "Displays the error/warning for the current line in the minibuffer"
  (interactive)
  (let* ((line-no            (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (count              (length line-err-info-list)))
    (while (> count 0)
      (when line-err-info-list
        (let* ((text       (flymake-ler-text (nth (1- count) line-err-info-list)))
               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
          (message "[%s] %s" line text)))
      (setq count (1- count)))))

;; popup.el を使って tip として表示
(defun flymake-my-display-err-popup-for-current-line ()
  "Display a menu with errors/warnings for current line if it has errors and/or warnings."
  (interactive)
  (let* ((line-no            (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (menu-data          (flymake-make-err-menu-data line-no line-err-info-list)))
    (if menu-data
      (popup-tip (mapconcat '(lambda (e) (nth 0 e))
                            (nth 1 menu-data)
                            "\n")))
    ))


;; 保存先をtemporary-file-directoryに変更したもの
(defun flymake-create-temp-intemp (file-name prefix)
  "Return file name in temporary directory for checking FILE-NAME.
This is a replacement for `flymake-create-temp-inplace'. The
difference is that it gives a file name in
`temporary-file-directory' instead of the same directory as
FILE-NAME.

For the use of PREFIX see that function.

Note that not making the temporary file in another directory
\(like here) will not if the file you are checking depends on
relative paths to other files \(for the type of checks flymake
makes)."
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext  (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext))
         )
    temp-name))

;; use Makefile with temporary-file-direcotry
(defun flymake-simple-make-init-intemp ()
  (flymake-simple-make-init-impl 'flymake-create-temp-intemp nil t "Makefile" 'flymake-get-make-cmdline))

(defun flymake-simple-generic-init (cmd &optional opts)
  (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                      'flymake-create-temp-intemp))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list cmd (append opts (list local-file)))))

;; unset file-name-masks because major-mode is used for flymake
(setq flymake-allowed-file-name-masks nil)

;;; flymake related with major-mode
(defvar flymake-allowed-major-mode nil)
(defadvice flymake-get-file-name-mode-and-masks (after after-test activate)
  (unless ad-return-value
    (setq ad-return-value
          (let ((mm flymake-allowed-major-mode)
                (mode-and-masks  nil))
            (while (and (not mode-and-masks) mm)
              (if (string-match (car (car mm)) (symbol-name major-mode))
                  (setq mode-and-masks (cdr (car mm))))
              (setq mm (cdr mm)))
            mode-and-masks))))
;;(flymake-get-file-name-mode-and-masks "")
;;flymake-allowed-file-name-masks

(defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
  (setq flymake-check-was-interrupted t))
(ad-activate 'flymake-post-syntax-check)
