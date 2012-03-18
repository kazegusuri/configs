

;; Flymake
(require 'flymake)
;; GUIの警告は表示しない
(setq flymake-gui-warnings-enabled nil)

;; 全てのファイルで flymakeを有効化
;;(add-hook 'find-file-hook 'flymake-find-file-hook)

;; M-p/M-n で警告/エラー行の移動
(global-set-key "\M-p" 'flymake-goto-prev-error)
(global-set-key "\M-n" 'flymake-goto-next-error)

;; エラー表示
(global-set-key "\C-ce" 'flymake-my-display-err-popup-for-current-line)

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
    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
    temp-name))


;; 保存先をtemporary-file-directoryに変更したもの
(defun my-flymake-simple-make-init-impl (create-temp-f use-relative-base-dir use-relative-source build-file-name get-cmdline-f)
  "Create syntax check command line for a directly checked source file.
Use CREATE-TEMP-F for creating temp copy."
  (let* ((args nil)
         (source-file-name   buffer-file-name)
         (buildfile-dir      (flymake-init-find-buildfile-dir source-file-name build-file-name)))
    (if buildfile-dir
        (let* ((temp-source-file-name  (flymake-init-create-temp-buffer-copy create-temp-f)))
          (setq args (flymake-get-syntax-check-program-args temp-source-file-name buildfile-dir
                                                            use-relative-base-dir use-relative-source
                                                            get-cmdline-f))))
    args))

(defun my-flymake-simple-make-init ()
  (my-flymake-simple-make-init-impl 'flymake-create-temp-intemp t t "Makefile" 'flymake-get-make-cmdline))


(defun flymake-simple-generic-init (cmd &optional opts)
  (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                      ;;'flymake-create-temp-inplace
                      'flymake-create-temp-intemp))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list cmd (append opts (list local-file)))))


