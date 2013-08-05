(require 'yasnippet)

;; スニペットディレクトリ
(add-to-list 'yas-snippet-dirs "~/local/common/emacs/yasnippets" t)

(yas-global-mode 1)

;; メニューは使わない
(setq yas/use-menu nil)

;; トリガはSPC, 次の候補への移動はTAB
(setq yas/trigger-key (kbd "SPC"))
(setq yas/next-field-key (kbd "TAB"))

(require 'dropdown-list)
(setq yas/text-popup-function
      #'yas/dropdown-list-popup-for-template)

;;; コメント・リテラルの中では展開しない
(setq yas/buffer-local-condition
      '(or (not (or (string= "font-lock-comment-face"
                             (get-char-property (point) 'face))
                    (string= "font-lock-string-face"
                             (get-char-property (point) 'face))))
           '(require-snippet-condition . force-in-comment)))


;;; yasnippet展開中はflymakeを無効にする
(defvar flymake-is-active-flag nil)

(defadvice yas/expand-snippet
  (before inhibit-flymake-syntax-checking-while-expanding-snippet activate)
  (setq flymake-is-active-flag
        (or flymake-is-active-flag
            (assoc-default 'flymake-mode (buffer-local-variables))))
  (when flymake-is-active-flag
    (flymake-mode-off)))

(add-hook 'yas/after-exit-snippet-hook
          '(lambda ()
             (when flymake-is-active-flag
               (flymake-mode-on)
               (setq flymake-is-active-flag nil))))
