
(eval-after-load 'flycheck
  '(lambda ()
     (custom-set-variables
      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)
      '(flycheck-highlighting-mode 'lines)

      )
     (add-hook 'flycheck-mode-hook
               'flycheck-color-mode-line-mode
               )
     ))

(setq flycheck-display-errors-delay 0.5)
(setq flycheck-pos-tip-timeout 3)

(global-set-key "\M-p" 'flycheck-previous-error)
(global-set-key "\M-n" 'flycheck-next-error)

(defun my-flycheck-display-error-at-point ()
  (interactive)
  (flycheck-display-error-at-point))


(global-set-key "\C-ce" 'my-flycheck-display-error-at-point)
