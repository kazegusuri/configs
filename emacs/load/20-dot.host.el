(cond
 ;;;;;;;;;;;;;;;;;;;;;;; sabo-win ;;;;;;;;;;;;;;;;;;;;;;; 
 ((string= system-name "SABO-WIN")  
  (setq initial-frame-alist  ;; windows postion and size 
        (append (list 
                 '(width . 100) '(height . 70) '(top . 0) '(left . 100))
                initial-frame-alist))
  (if window-system
      (progn
        (setq my-style-ac-completion-face-foreground "blue")
        (setq my-style-ac-candidate-face-background "white")
        )
    (progn

      (setq my-style-ac-completion-face-foreground "blue")
      (setq my-style-ac-candidate-face-background "brightwhite")
      )
    )
  
  )

   ;;;;;;;;;;;;;;;;;;;;;;; coral ;;;;;;;;;;;;;;;;;;;;;;; 
 ((string= system-name "coral")
  (setq initial-frame-alist  ;; windows postion and size
        (append (list 
                 '(width . 180) '(height . 64) '(top . 0) '(left . 00))
                initial-frame-alist))

  (if window-system
      (progn
        (set-frame-parameter nil 'fullscreen 'maximized)
        (my-style-set-dircolors-xemacs)
        (setq my-style-ac-completion-face-foreground "blue")
        (setq my-style-ac-candidate-face-background "white")
        )
    (progn
      (setq my-style-ac-completion-face-foreground "blue")
      (setq my-style-ac-candidate-face-background "brightwhite")
      )
    )

;  (set-default-font "Takaoゴシック-11")
  )

   ;;;;;;;;;;;;;;;;;;;;;;; jade ;;;;;;;;;;;;;;;;;;;;;;; 
 ((string= system-name "jade")
  (setq initial-frame-alist  ;; windows postion and size
        (append (list 
                 '(width . 100) '(height . 70) '(top . 0) '(left . 100))
                initial-frame-alist))
  (if window-system
      (progn
        ;;(color-theme-xemacs)
        (setq my-style-ac-completion-face-foreground "blue")
        (setq my-style-ac-candidate-face-background "white")
        )
    (progn
      ;;(color-theme-gtk-ide)
      ;; (color-theme-tangotango)
      ;;(color-theme-zenburn)
      (setq my-style-ac-completion-face-foreground "blue")
      (setq my-style-ac-candidate-face-background "brightwhite")
      )
    )
  )

   ;;;;;;;;;;;;;;;;;;;;;;; sapphpire ;;;;;;;;;;;;;;;;;;;;;;; 
 ((string= system-name "sapphire")
  (setq initial-frame-alist  ;; windows postion and size
        (append (list 
                 '(width . 120) '(height . 80) '(top . 0) '(left . -100))
                initial-frame-alist))
  (if window-system
      (progn
        ;;(color-theme-xemacs)
        (my-style-set-dircolors-xemacs)
        (setq my-style-ac-completion-face-foreground "blue")
        (setq my-style-ac-candidate-face-background "white")
        )
    (progn
      ;;(color-theme-tangotango)
      (setq my-style-ac-completion-face-foreground "blue")
      (setq my-style-ac-candidate-face-background "brightwhite")
      )
    )

  ;; (set-default-font "sans-10")
  (set-default-font "Liberation Mono-9")
  ;;(set-default-font "Takaoゴシック-10")
  ;; (set-fontset-font (frame-parameter nil 'font)
  ;;                    'japanese-jisx0208
  ;;                    '("M+1MN+IPAG" . "unicode-bmp"))
  ;; (set-fontset-font (frame-parameter nil 'font)
  ;;                    'japanese-jisx0208
  ;;                    '("Takaoゴシック" . "unicode-bmp"))
  )

  ;;;;;;;;;;;;;;;;;;;;;;; macbook ;;;;;;;;;;;;;;;;;;;;;;; 
 ((string-match "macbook" system-name)
  (setq initial-frame-alist  ;; windows postion and size
        (append (list 
                 '(width . 120) '(height . 80) '(top . 0) '(left . -100))
                initial-frame-alist))
  (if window-system
      (progn
        ;;(color-theme-xemacs)
        (my-style-set-dircolors-xemacs)
        (setq my-style-ac-completion-face-foreground "blue")
        (setq my-style-ac-candidate-face-background "white")
        )
    (progn
      ;;(color-theme-tangotango)
      (setq my-style-ac-completion-face-foreground "blue")
      (setq my-style-ac-candidate-face-background "brightwhite")
      )
    )
  ;;(set-default-font "Liberation Mono-10")
  (set-face-attribute 'default nil :family "Menlo" :height 140)
  (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    (font-spec :family "Hiragino Kaku Gothic ProN"))
  (add-to-list 'face-font-rescale-alist
               '(".*Hiragino Kaku Gothic ProN.*" . 1.2))

  )

  ;;;;;;;;;;;;;;;;;;;;;;; default ;;;;;;;;;;;;;;;;;;;;;;; 
 (t 
  (setq initial-frame-alist  ;; windows postion and size
        (append (list 
                 '(width . 100) '(height . 70) '(top . 0) '(left . 0))
                initial-frame-alist))
  (if window-system
      (progn
        (color-theme-xemacs)
        (my-style-set-dircolors-xemacs)
        (setq my-style-ac-completion-face-foreground "blue")
        (setq my-style-ac-candidate-face-background "white")
        )
    (progn
      ;;(color-theme-gtk-ide)
      (setq my-style-ac-completion-face-foreground "blue")
      (setq my-style-ac-candidate-face-background "brightwhite")
      )
    )
  )
 )
(setq default-frame-alist initial-frame-alist)

