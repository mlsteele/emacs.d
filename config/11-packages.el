;;; Set up the package system.
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
	     '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(defvar config-required-packages nil "Packages that should be installed by the config.")
(setq config-required-packages
  '(
    evil
    evil-escape
    linum-relative
    helm
    helm-descbinds
    helm-projectile
    helm-ag
    powerline
    powerline-evil
    solarized-theme
    ace-jump-mode
    evil-jumper
    ag
    sudo-edit
    projectile
    go-projectile
    evil-surround
    centered-cursor-mode
    auto-complete
    paredit
    evil-paredit
    default-text-scale
    yasnippet
    smart-mode-line
    smart-mode-line-powerline-theme
    cider

    go-mode
    go-autocomplete
    haskell-mode
    markdown-mode
    scala-mode
    jsx-mode
    less-css-mode
    coffee-mode
    elixir-mode
    glsl-mode
    haskell-emacs
    idle-highlight-mode
    lua-mode
    racket-mode
    rust-mode
    vimrc-mode
    yaml-mode
    systemd
    sass-mode
    ))

;;; Refresh the package list if anything is not installed.
(when (member nil (mapcar 'package-installed-p config-required-packages))
  (package-refresh-contents))

;;; Install each package.
(dolist (package-name config-required-packages)
  (package-install package-name))

;; (with-eval-after-load 'go-mode
;;    (require 'go-autocomplete))

;;; Make packages available from the lisp dir.
(require 'coq-stalker-mode)
(add-to-list 'load-path (expand-file-name "lisp/emacs-colorpicker" user-emacs-directory))
(require 'colorpicker)
(add-to-list 'load-path (expand-file-name "lisp/emacs-crystal-mode" user-emacs-directory))
(require 'crystal-mode)
(add-to-list 'load-path (expand-file-name "lisp/urweb" user-emacs-directory))
(require 'urweb-mode)
