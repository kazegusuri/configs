;; (load-library "autostart") 
;; ;;(load "autostart.el") 
;; (custom-set-variables
;;  '(ecb-options-version "2.32")
;;  '(indent-region-mode t)
;;  '(nxhtml-global-minor-mode t)
;;  '(nxhtml-global-validation-header-mode t)
;;  '(nxhtml-skip-welcome t))
;; (custom-set-faces
;;  '(mumamo-background-chunk-major ((((class color) (min-colors 8)) (:background "*"))))
;;  '(mumamo-background-chunk-submode ((((class color) (min-colors 8)) (:background "*")))))
;; (add-hook 'nxml-mode-hook
;;           (lambda ()
;;             (setq auto-fill-mode -1)
;;             (setq nxml-slash-auto-complete-flag t)
;;             (setq nxml-child-indent 2)
;;             (setq indent-tabs-mode t)
;;             (setq tab-width 2)))

(autoload 'php-mode "php-mode" "php-mode" t)
(add-to-list 'auto-mode-alist '("\\.\\(php\\|inc\\)$" . php-mode))

(add-hook 'php-mode-hook
          (lambda ()
            (c-set-style "linux")
            (c-toggle-hungry-state t)
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
            (when (require 'auto-complete nil t)
              (make-variable-buffer-local 'ac-sources)
              (add-to-list 'ac-sources 'ac-source-php-completion)
              (auto-complete-mode t))
            ))

;; (setq auto-mode-alist
;;       (cons '("\\.php$" . php-mode) auto-mode-alist))
(setq php-mode-force-pear t)
(add-hook 'php-mode-user-hook
          '(lambda ()
             (setq php-manual-path "~/local/common/emacs/etc/php/html")
             (setq php-search-url "http://www.phppro.jp/")
             (setq php-manual-url "http://www.phppro.jp/phpmanual/")))



;;; flymake settings
(defun flymake-php-init ()
  "Use php to check the syntax of the current file."
  (let* ((temp (flymake-init-create-temp-buffer-copy 'flymake-create-temp-intemp))
         (local (file-relative-name temp (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local "-l"))))

(add-to-list 'flymake-err-line-patterns
             '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

;; add major-mode to flymake
(push '("php-mode" flymake-php-init) flymake-allowed-major-mode)
(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))

;; mmm-mode
;; (require 'mmm-mode)
;; (setq mmm-global-mode 'maybe)
;; (setq mmm-submode-decoration-level 2)
;; (setq mmm-font-lock-available-p t)
;; (defun save-mmm-c-locals ()
;;   (with-temp-buffer
;;     (php-mode)
;;     (dolist (v (buffer-local-variables))
;;       (when (string-match "\\`c-" (symbol-name (car v)))
;;         (add-to-list 'mmm-save-local-variables `(,(car v) nil, mmm-c-derived-modes))))))
;; (save-mmm-c-locals)
;; (mmm-add-mode-ext-class nil "\\.php?\\'" 'html-php)
;; (mmm-add-classes
;;  '((html-php
;;     :submode php-mode
;;     :front "<\\?\\(php\\)?"
;;     :back "\\?>")))
;; (add-to-list 'auto-mode-alist '("\\.php?\\'" . xml-mode))
