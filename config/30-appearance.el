;;; Hide gui elements.
(when (fboundp 'menu-bar-mode)   (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)   (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;;; Show line numbers on left.
(global-linum-mode t)

;;; Font size
(set-face-attribute 'default nil :height 110)

;;; Load color theme.
; (require 'moe-theme)
; (load-theme 'moe-light t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
; (load-theme 'badwolf t)
; (load-theme 'solarized-light t)
;;; Loading both color schemes in necessary because atom-one-dark doesn't get the linum colors
; (load-theme 'solarized-dark t)
(load-theme 'atom-one-dark t)

;;; Relative line numbers
(require 'linum-relative)
(linum-relative-mode t)

;;; Powerline status line
(require 'powerline)
(require 'powerline-evil)
(powerline-default-theme)

;;; Set the window title to the file path.
(setq frame-title-format
    '("%S" (buffer-file-name "%f"
		(dired-directory dired-directory "%b"))))

;;; These are desirable but the face is not bound this early when loading.
;;;(set-face-attribute 'go-guru-hl-identifier-face nil :background "#782c34")
;;;(set-face-attribute 'go-guru-hl-identifier-face nil :foreground "#bf76cd")
