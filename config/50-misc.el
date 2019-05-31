;;; Enable surround mode.
(global-evil-surround-mode)

; ; https://emacsredux.com/blog/2013/06/25/boost-performance-by-leveraging-byte-compilation/
; (defun my-remove-elc-on-save ()
;   "Delete the compiled .elc when saving an .el"
;   (add-hook 'after-save-hook
;             (lambda ()
;               (if (file-exists-p (concat buffer-file-name "c"))
;                   (delete-file (concat buffer-file-name "c"))))
;             nil
;             t))

;; (add-hook 'emacs-lisp-mode-hook 'my-remove-elc-on-save)

(setq haskell-process-path-cabal "/home/config/.local/bin/cabal")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;; Fira ligatures
; Using FiraCode ligatures from https://github.com/tonsky/FiraCode
; This works on macos using Mitsuharu Yamamoto's build of emacs.
; Instructions: https://github.com/tonsky/FiraCode/wiki/Emacs-instructions
; Download link: https://github.com/tonsky/FiraCode/issues/211#issuecomment-239058632
; Emacs build: https://bitbucket.org/mituharu/emacs-mac/overview

(add-hook 'js-mode-hook 'my-js-mode-hook)
(defun my-js-mode-hook ()
  (fira-code-mode 1))

(add-hook 'go-mode-hook 'my-go-mode-hook)
(defun my-go-mode-hook ()
  (fira-code-mode 1))

;;; Cleanup spacing.
; (add-hook 'before-save-hook 'whitespace-cleanup)
; (remove-hook 'before-save-hook 'whitespace-cleanup)

;;; Enable autocompletion.
(global-auto-complete-mode 1)

;;; Enable auto-revert.
(global-auto-revert-mode t)
(setq auto-revert-timer 0.4)
(auto-revert-set-timer)

;;; Underscore is a word character.
(defun my-underscore-syntax ()
  (modify-syntax-entry ?_ "w"))
(add-hook 'change-major-mode-hook 'my-underscore-syntax)

;;; Use diff-mode for git commit.
(add-to-list 'auto-mode-alist '("\\COMMIT_EDITMSG\\'" . diff-mode))

;;; Use scala-mode.
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))

;;; Use jsx-mode.
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(add-to-list 'auto-mode-alist '("\\.flow\\'" . jsx-mode))

;;; Use python mode for pythonrc.
(add-to-list 'auto-mode-alist '("\\.pythonrc\\'" . python-mode))

;;; Use coffee mode for iced coffee script.
(add-to-list 'auto-mode-alist '("\\.iced\\'" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.cson\\'" . coffee-mode))
(add-to-list 'auto-mode-alist '("\\.toffee\\'" . coffee-mode))

;;; Use conf-mode for .gitconfig
(add-to-list 'auto-mode-alist '("\\.gitconfig\\'" . conf-mode))

;;; Use sass mode for sass.
(add-to-list 'auto-mode-alist '("\\.scss\\'" . sass-mode))

;;; Use XML for ROS launch files
(add-to-list 'auto-mode-alist '("\\.launch\\'" . xml-mode))

;;; Use js mode for avdl. Because it's good enough and avdl mode is broken.
(add-to-list 'auto-mode-alist '("\\.avdl\\'" . c-mode))

;;; Use typescript mode for .ts
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

;;; Use Go mode for .go
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))

;;; Use sh mode for zshrc
(add-to-list 'auto-mode-alist '("\\.zshrc.*\\'" . sh-mode))

; (setq browse-url-browser-function 'browse-url-generic
; 	  browse-url-generic-program "google-chrome")
(setq browse-url-browser-function 'browse-url-generic
	  browse-url-generic-program "firefox")

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

;;; Make yes/no prompts briefer.
(defalias 'yes-or-no-p 'y-or-n-p)

;;; Save bookmarks file automatically.
(defadvice bookmark-set (after save-bookmarks-automatically activate)
  (bookmark-save))

;;; Don't truncate lines by default
(set-default 'truncate-lines nil)

;;; Set $GOPATH
(let ((gopath (expand-file-name "~/go")))
  (setenv "GOPATH" gopath)
  (setenv "PATH" (concat (getenv "PATH") ":" (concat gopath "/bin")))
  (setq exec-path (append exec-path (list gopath))))

;;; Load the go oracle
(let ((oracle-el "$GOPATH/src/golang.org/x/tools/cmd/oracle/oracle.el"))
  (when (file-exists-p oracle-el)
                 (load-file oracle-el)))

(winner-mode)

(setq ring-bell-function 'ignore)

;;; Create special buffers as placeholders so they can be session-restored.
(get-buffer-create "*compilation*")
(get-buffer-create "*go-guru-output*")

;;; Show the code for svgs
(setq image-file-name-extensions (remove "svg" image-file-name-extensions))
