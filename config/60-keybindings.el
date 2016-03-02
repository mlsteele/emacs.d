;;; Help commands.
(define-key evil-normal-state-map (kbd ",hk") 'describe-key)
(define-key evil-normal-state-map (kbd ",hv") 'describe-variable)
(define-key evil-normal-state-map (kbd ",hf") 'describe-function)
(define-key evil-normal-state-map (kbd ",hm") 'describe-mode)

;;;; Evil.
(define-key evil-insert-state-map (kbd "C-k") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-d") 'evil-normal-state)
(define-key evil-insert-state-map (kbd "C-p") (lambda () (interactive)
  (call-interactively 'evil-paste-after) (evil-normal-state)))
(define-key evil-normal-state-map (kbd "zx") 'evil-jump-item)

;;; Buffer navigation.
(define-key evil-normal-state-map (kbd ",f") 'find-file)
;; (define-key evil-normal-state-map (kbd ",f") 'helm-find-files)
(define-key evil-normal-state-map (kbd ",l") 'helm-buffers-list)
(define-key evil-normal-state-map (kbd ",b") 'helm-bookmarks)
(define-key evil-normal-state-map (kbd ",p") 'helm-projectile)
(define-key evil-normal-state-map (kbd ",k") 'kill-this-buffer)
(define-key evil-normal-state-map (kbd ",a") 'helm-do-ag-project-root)
(define-key evil-normal-state-map (kbd ",t") 'launch-terminator)

;;; Window.
(define-key evil-normal-state-map (kbd ",ws") 'evil-window-split)
(define-key evil-normal-state-map (kbd ",wv") (lambda () (interactive) (evil-window-vsplit) (evil-window-right 1)))
(define-key evil-normal-state-map (kbd ",wc") 'evil-window-delete)
(define-key evil-normal-state-map (kbd ",wh") 'evil-window-left)
(define-key evil-normal-state-map (kbd ",wl") 'evil-window-right)
(define-key evil-normal-state-map (kbd ",wj") 'evil-window-down)
(define-key evil-normal-state-map (kbd ",wk") 'evil-window-up)
(define-key evil-normal-state-map (kbd ",w1") 'delete-other-windows)

;;; Scroll control.
(define-key evil-normal-state-map (kbd "z.") 'evil-scroll-line-to-top-ish)
(define-key evil-visual-state-map (kbd "z.") 'evil-scroll-line-to-top-ish)

;;; Cursor movement.
(define-key evil-normal-state-map (kbd ",s") 'find-tag)
(define-key evil-normal-state-map (kbd "s") 'ace-jump-two-chars-mode)
(define-key evil-normal-state-map (kbd "(") 'insert-with-left-paren)

;;; Server edit mode.
(define-key evil-normal-state-map (kbd ",q")
  (lambda () (interactive)
    (if server-buffer-clients
	(progn (save-buffer) (server-done))
	(quit-window))))
(define-key evil-insert-state-map (kbd "C-q")
  (lambda () (interactive)
    (when server-buffer-clients
	(progn (save-buffer) (server-done)))))

;;; Evil undefine patches.
(defun evil-undefine ()
  (interactive)
  (let (evil-mode-map-alist)
    (call-interactively (key-binding (this-command-keys)))))

(define-key evil-normal-state-map (kbd ",,s") 'evil-undefine)

;;; Python mode.
;; (define-key evil-normal-state-map (kbd ",r") 'python-shell-send-buffer)

;;; Haskell mode.
(define-key evil-normal-state-map (kbd ",r") 'haskell-process-load-file)
;; (define-key evil-normal-state-map (kbd ",d") 'haskell-doc-show-type)

;;; Cider mode.
;; (define-key evil-normal-state-map (kbd ",e") 'cider-eval-last-sexp)
(define-key evil-normal-state-map (kbd ",d") 'cider-doc)

;;; Coq proof mode
(defun my-proof-general-mode-hook ()
  (interactive)
  (define-key proof-mode-map (kbd "<M-down>") 'proof-assert-next-command-interactive)
  (define-key proof-mode-map (kbd "<M-up>") 'proof-undo-last-successful-command)
  (define-key proof-mode-map (kbd "<M-right>") 'proof-goto-point))
  ;; (define-key proof-mode-map (kbd ",,s") 'coq-stalker-mode)) ; this causes problems in insert mode.
  ;; (evil-declare-key 'normal proof-mode-map (kbd ",,s") 'coq-stalker-mode))
  ;; (define-key evil-normal-state-map (kbd ",,s") 'coq-stalker-mode))
  ;; (define-key proof-mode-map (kbd ",e") 'proof-goto-point))
;; (define-key evil-normal-state-map (kbd "SPC") (lambda () (interactive) (save-buffer) (proof-goto-point)))

(define-key evil-normal-state-map (kbd ",e") 'proof-goto-point)
;; (define-evil-key 'normal evil-normal-state-map (kbd ",e") 'proof-goto-point)
(eval-after-load 'proof-script '(my-proof-general-mode-hook))

;;; Lua mode.
(define-key evil-normal-state-map (kbd "R") 'lua-send-buffer)

;;; eshell mode.
(defun my-eshell-mode-setup-keys ()
  (interactive)
  (define-key eshell-mode-map (kbd "C-p") 'eshell-previous-input))
(add-hook 'eshell-mode-hook 'my-eshell-mode-setup-keys)
