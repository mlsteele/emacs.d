;;; Enable surround mode.
(global-evil-surround-mode)

(setq haskell-process-path-cabal "/home/config/.local/bin/cabal")
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;;; Cleanup spacing.
(add-hook 'before-save-hook 'whitespace-cleanup)

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
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG" . diff-mode))

;;; Use scala-mode.
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))

;;; Use jsx-mode.
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))

;;; Use python mode for pythonrc.
(add-to-list 'auto-mode-alist '(".pythonrc" . python-mode))

;;; Use conf-mode for .gitconfig
(add-to-list 'auto-mode-alist '(".gitconfig" . conf-mode))

;;; Use sass mode for sass.
(add-to-list 'auto-mode-alist '("\\.scss\\'" . sass-mode))

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

;;; Make yes/no prompts briefer.
(defalias 'yes-or-no-p 'y-or-n-p)

;;; Save bookmarks file automatically.
(defadvice bookmark-set (after save-bookmarks-automatically activate)
  (bookmark-save))
