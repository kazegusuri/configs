(require 'dired-x)

;;; wdired の設定
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
(setq wdired-allow-to-change-permissions t)

(global-set-key "\C-x\C-j" 'dired-jump)

(defun dired-my-append-buffer-name-hint ()
  "Append a auxiliary string to a name of dired buffer."
  (when (eq major-mode 'dired-mode)
    (let* ((dir (expand-file-name list-buffers-directory))
           (drive (if (and (eq 'system-type 'windows-nt) ;; Windows の場合はドライブレターを追加
                           (string-match "^\\([a-zA-Z]:\\)/" dir))
                      (match-string 1 dir) "")))
      (rename-buffer (concat (buffer-name) " [" drive "Dired]") t))))
(add-hook 'dired-mode-hook 'dired-my-append-buffer-name-hint)
