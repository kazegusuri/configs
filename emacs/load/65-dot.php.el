(autoload 'php-mode "php-mode" "php-mode" t)
(add-to-list 'auto-mode-alist '("\\.\\(php\\|inc\\)$" . php-mode))

(defun ywb-php-lineup-arglist-intro (langelem)
  (save-excursion
    (goto-char (cdr langelem))
    (vector (+ (current-column) c-basic-offset))))
(defun ywb-php-lineup-arglist-close (langelem)
  (save-excursion
    (goto-char (cdr langelem))
    (vector (current-column))))

(add-hook 'php-mode-hook
          (lambda ()
            ;; (c-set-style "linux")
            ;; (c-toggle-hungry-state t)
            (setq c-comment-only-line-offset 0) ;; コメント行のインデント
            ;; コメントのスタイル
            (setq comment-start "// "
                  comment-end   ""
                  comment-start-skip "// *")
            (setq tab-width 4)
            (setq c-basic-offset 4)
            (setq c-hanging-comment-ender-p nil)
            (setq indent-tabs-mode nil)

            (when (require 'php-extras nil t)
              (eldoc-mode t))

            (require 'php-completion)
            (php-completion-mode t)
            (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
            (define-key php-mode-map (kbd "C-;") 'phpcmp-complete)
;            (when (require 'auto-complete nil t)
;              (make-variable-buffer-local 'ac-sources)
;              (add-to-list 'ac-sources 'ac-source-php-completion)
;              (auto-complete-mode t))

            (c-set-style "stroustrup")
            (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
            (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)
            (c-set-offset 'arglist-cont-nonempty' 4)
            (c-set-offset 'case-label' 4)
            (make-local-variable 'tab-width)
            (make-local-variable 'indent-tabs-mode)
            (setq tab-width 4)
            (setq indent-tabs-mode nil)

            (setq flycheck-phpcs-standard "PSR2")
            ))

(setq php-mode-force-pear nil)
(add-hook 'php-mode-user-hook
          '(lambda ()
             (setq php-manual-path "~/local/common/emacs/etc/php/html")
             (setq php-search-url "http://www.phppro.jp/")
             (setq php-manual-url "http://www.phppro.jp/phpmanual/")))

(add-hook 'php-mode-hook (lambda ()
    (defun ywb-php-lineup-arglist-intro (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (+ (current-column) c-basic-offset))))
    (defun ywb-php-lineup-arglist-close (langelem)
      (save-excursion
        (goto-char (cdr langelem))
        (vector (current-column))))
    (c-set-offset 'arglist-intro 'ywb-php-lineup-arglist-intro)
    (c-set-offset 'arglist-close 'ywb-php-lineup-arglist-close)))

(add-hook 'php-mode-hook 'flycheck-mode)
