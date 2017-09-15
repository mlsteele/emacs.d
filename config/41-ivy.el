;;; Enable Helm
(require 'ivy)
(ivy-mode 1)
(setq projectile-completion-system 'ivy)
(define-key ivy-minibuffer-map (kbd "C-j") 'ivy-next-line)
(define-key ivy-minibuffer-map (kbd "C-k") 'ivy-previous-line)
