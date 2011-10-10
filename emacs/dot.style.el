;; color theme
(require 'color-theme-autoloads)
(require 'color-theme)
(load "~/local/common/emacs/site-lisp/color-theme-6.6.0/themes/color-theme-library")

(require 'dircolors)

;; use dircolors in dired-mode
(font-lock-add-keywords
 'dired-mode
 (mapcar (lambda (x)
           (list
            (format "\\(%s\\)$"
                    (mapconcat (lambda (ext)
                                 (if (stringp ext)
                                     (format "\\.%s" ext)
                                   (format ".*%s.*" (cadr ext))))
                               (car x)
                               "\\|"))
            `(".+" (dired-move-to-filename) nil (0 ',(cadr x)))))
         dircolors-extension)) 

(defun my-style-set-dircolors-default ()
  (set-face-foreground 'dircolors-face-dir            "mediumblue"     )
  (set-face-foreground 'dircolors-face-text           "purple"         )
  (set-face-foreground 'dircolors-face-doc            "purple"         )
  (set-face-foreground 'dircolors-face-html           "magenta"        )
  (set-face-foreground 'dircolors-face-package        "firebrick"      )
  (set-face-foreground 'dircolors-face-tar            "firebrick"      )
  (set-face-foreground 'dircolors-face-dos            "darkred"        )
  (set-face-foreground 'dircolors-face-sound          "yellow"         )
  (set-face-foreground 'dircolors-face-img            "yellow"         )
  (set-face-foreground 'dircolors-face-ps             "brown"          )
  (set-face-foreground 'dircolors-face-backup         "darkslategrey"  )
  (set-face-foreground 'dircolors-face-make           "seagreen"       )
  (set-face-foreground 'dircolors-face-paddb          "Orange"         )
  (set-face-foreground 'dircolors-face-lang           "cyan"           )
  (set-face-foreground 'dircolors-face-emacs          "steelblue"      )
  (set-face-foreground 'dircolors-face-lang-interface "deepskyblue"    )
  (set-face-foreground 'dircolors-face-yacc           "dodgerblue"     )
  (set-face-foreground 'dircolors-face-objet          "orangered"      )
  (set-face-foreground 'dircolors-face-exec           "red"            )
  (set-face-foreground 'dircolors-face-asm            "Tan"            )
  (set-face-foreground 'dircolors-face-compress       "firebrick"      )
)



(defun my-style-set-dircolors-xemacs ()
  (set-face-foreground 'dircolors-face-dir            "Magenta"        )
  (set-face-foreground 'dircolors-face-doc            "MediumTurquoise")
  (set-face-foreground 'dircolors-face-html           "Plum"           )
  (set-face-foreground 'dircolors-face-package        "IndianRed"      )
  (set-face-foreground 'dircolors-face-tar            "OrangeRed"      )
  (set-face-foreground 'dircolors-face-dos            "LimeGreen"      )
  (set-face-foreground 'dircolors-face-sound          "DodgerBlue1"    )
  (set-face-foreground 'dircolors-face-img            "Salmon"         )
  (set-face-foreground 'dircolors-face-ps             "BlueViolet"     )
  (set-face-foreground 'dircolors-face-backup         "SkyBlue3"       )
  (set-face-foreground 'dircolors-face-make           "Khaki"          )
  (set-face-foreground 'dircolors-face-paddb          "Orange"         )
  (set-face-foreground 'dircolors-face-lang           "darkblue"       )
  (set-face-foreground 'dircolors-face-emacs          "GreenYellow"    )
  (set-face-foreground 'dircolors-face-lang-interface "brown"          )
  (set-face-foreground 'dircolors-face-yacc           "Coral"          )
  (set-face-foreground 'dircolors-face-objet          "DimGray"        )
  (set-face-foreground 'dircolors-face-asm            "Tan3"           )
  (set-face-foreground 'dircolors-face-compress       "Sienna"         )
  (set-face-foreground 'dircolors-face-script         "GreenYellow"    )
)

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
                 '(width . 40) '(height . 40) '(top . 0) '(left . 00))
                initial-frame-alist))

  (if window-system
      (progn

        (color-theme-xemacs)
        (my-style-set-dircolors-xemacs)
        (setq my-style-ac-completion-face-foreground "blue")
        (setq my-style-ac-candidate-face-background "white")
        )
    (progn

      (color-theme-gtk-ide)
      (setq my-style-ac-completion-face-foreground "blue")
      (setq my-style-ac-candidate-face-background "brightwhite")
      )
    )


  ;; (set-default-font "sans-10")
  ;; (set-default-font "Liberation Mono-6")
  ;;(set-default-font "mono-9")
  (set-default-font "Takaoゴシック-9")
  ;; (set-fontset-font (frame-parameter nil 'font)
  ;;                    'japanese-jisx0208
  ;;                    '("M+1MN+IPAG" . "unicode-bmp"))
  ;; (set-fontset-font (frame-parameter nil 'font)
  ;;                    'japanese-jisx0208
  ;;                    '("Takaoゴシック" . "unicode-bmp"))
  
  )


   ;;;;;;;;;;;;;;;;;;;;;;; jade ;;;;;;;;;;;;;;;;;;;;;;; 
 ((string= system-name "jade")
  (setq initial-frame-alist  ;; windows postion and size
        (append (list 
                 '(width . 100) '(height . 70) '(top . 0) '(left . 100))
                initial-frame-alist))

  (if window-system
      (progn

        (color-theme-xemacs)
        (setq my-style-ac-completion-face-foreground "blue")
        (setq my-style-ac-candidate-face-background "white")
        )
    (progn

      (color-theme-gtk-ide)
      (setq my-style-ac-completion-face-foreground "blue")
      (setq my-style-ac-candidate-face-background "brightwhite")
      )
    )

  )

   ;;;;;;;;;;;;;;;;;;;;;;; sapphpire ;;;;;;;;;;;;;;;;;;;;;;; 
 ((string= system-name "sapphire")
  (setq initial-frame-alist  ;; windows postion and size
        (append (list 
                 '(width . 70) '(height . 80) '(top . 0) '(left . 100))
                initial-frame-alist))

  (if window-system
      (progn

        (color-theme-xemacs)
        (my-style-set-dircolors-xemacs)
        (setq my-style-ac-completion-face-foreground "blue")
        (setq my-style-ac-candidate-face-background "white")
        )
    (progn

      (color-theme-gtk-ide)
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

   ;;;;;;;;;;;;;;;;;;;;;;; archlab-vm ;;;;;;;;;;;;;;;;;;;;;;; 
 ((string= system-name "sanom-vm.arch.cs.titech.ac.jp")
  (setq initial-frame-alist  ;; windows postion and size
        (append (list 
                 '(width . 100) '(height . 70) '(top . 0) '(left . 100))
                initial-frame-alist))

  (if window-system
      (progn
        (color-theme-xemacs)
        (my-style-set-dircolors-xemacs)
        (setq my-style-ac-completion-face-foreground "blue")
        (setq my-style-ac-candidate-face-background "white")
        (set-fontset-font (frame-parameter nil 'font)
                    'japanese-jisx0208
                    '("M+1MN+IPAG" . "unicode-bmp"))
        )
    (progn
      (color-theme-gtk-ide)
      (setq my-style-ac-completion-face-foreground "blue")
      (setq my-style-ac-candidate-face-background "brightwhite")
      )
    )


  (set-default-font "Mono-9")
  )

   ;;;;;;;;;;;;;;;;;;;;;;; archlab-vm ;;;;;;;;;;;;;;;;;;;;;;; 
 ((string= system-name "sano-vm")
  (setq initial-frame-alist  ;; windows postion and size
        (append (list 
                 '(width . 100) '(height . 70) '(top . 0) '(left . 100))
                initial-frame-alist))

  (if window-system
      (progn
        (color-theme-xemacs)
        (my-style-set-dircolors-xemacs)
        (setq my-style-ac-completion-face-foreground "blue")
        (setq my-style-ac-candidate-face-background "white")
        )
    (progn
      (color-theme-gtk-ide)
      (setq my-style-ac-completion-face-foreground "blue")
      (setq my-style-ac-candidate-face-background "brightwhite")
      )
    )

  (set-default-font "VL ゴシック-10")
  ;;(set-default-font "Ubuntu-10")
  ;;(set-default-font "Takaoゴシック-11")
  ;;(set-default-font "Mono-9")
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

;; coloring
(global-font-lock-mode t)
