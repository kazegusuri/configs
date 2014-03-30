
(eval-after-load 'flycheck
  '(lambda ()
     (custom-set-variables
      '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)
      )
     (add-hook 'flycheck-mode-hook
               'flycheck-color-mode-line-mode
               )
     ))

(setq flycheck-display-errors-delay 0.5)
(setq flycheck-pos-tip-timeout 3)

(defun my-flycheck-display-error-at-point ()
  (interactive)
  (flycheck-display-error-at-point))


(global-set-key "\C-ce" 'my-flycheck-display-error-at-point)
