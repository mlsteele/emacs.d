;;; Reload init files
(defun reload-emacs-init ()
    "Reload emacs init file."
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))

;;; Launch a terminal in the current directory.
(defun launch-terminator ()
  "Launch terminator."
  (interactive)
  ;; (let ((dir (expand-file-name (user-login-name) default-directory)))
  (let ((dir (expand-file-name default-directory)))
    (write-region dir nil "~/.cwd-send")
    (cd "/tmp") ; cd to temp so that nohup.out ends up there.
    (start-process "term" nil "term")
    (cd dir)))

;;; Big fonts for presentation.
(defun big-font ()
  "Make all the font big."
  (interactive)
  (set-default-font "Source Code Pro 15"))

;;; Chance indentation.
(defun spaces-2-please ()
  "Use tab=2spaces indentation in all respects."
  (interactive)
  (setq-default indent-tabs-mode nil)
  (setq-default evil-shift-width 2)
  (setq-default c-basic-offset 2)
  (setq-default js-indent-level 2)
  (setq-default jsx-indent-level 2))

(defun spaces-4-please ()
  "Use tab=4spaces tabs in all respects."
  (interactive)
  (setq-default indent-tabs-mode nil)
  (setq-default evil-shift-width 4)
  (setq-default c-basic-offset 4)
  (setq-default js-indent-level 4)
  (setq-default jsx-indent-level 4))

(defun new-scratch (seed)
  "Open a new scratch buffer"
  (interactive "sScratch buffer name: ")
  (let ((name (generate-new-buffer-name (concat seed "-scratch"))))
    (switch-to-buffer (concat "*" name "*"))))

;;; Edit file in sudo with tramp.
(defun sudo-edit (&optional arg)
  "Edit currently visited file as root.

  With a prefix ARG prompt for a file to visit.
  Will also prompt for a file to visit if current
  buffer is not visiting a file."
  (interactive "P")
  (if (or arg (not buffer-file-name))
      (find-file (concat "/sudo:root@localhost:"
                         (ido-read-file-name "Find file(as root): ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

(defun kill-invisible-buffers ()
  "Kill all buffers not currently shown in a window somewhere."
  (interactive)
  (dolist (buf  (buffer-list))
    (unless (get-buffer-window buf 'visible) (kill-buffer buf))))

(defun yank-whole-buffer ()
    "Copy entire buffer to clipboard."
    (interactive)
    (clipboard-kill-ring-save (point-min) (point-max)))

(defun ace-jump-two-chars-mode (query-char query-char-2)
  "AceJump two chars mode"
  (interactive (list (read-char "First Char:")
                     (read-char "Second:")))

  (if (eq (ace-jump-char-category query-char) 'other)
    (error "[AceJump] Non-printable character"))

  ;; others : digit , alpha, punc
  (let ((query-string (cond ((eq query-char-2 ?\r)
                             (format "%c" query-char))
                            (t
                             (format "%c%c" query-char query-char-2)))))
    (setq ace-jump-query-char query-char)
    (setq ace-jump-current-mode 'ace-jump-char-mode)
    (ace-jump-do (regexp-quote query-string))))

(defun insert-with-left-paren ()
  "Insert a left paren and enter insert mode."
  (interactive)
  (paredit-wrap-round)
  ; (insert "(")
  (evil-insert-state))

;; (defun ag-then-focus ()
;;   (interactive)
;;   (call-interactively 'ag))

;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

;;; https://rejeep.github.io/emacs/elisp/2010/03/11/duplicate-current-line-or-region-in-emacs.html
(defun duplicate-current-line-or-region (arg)
  "Duplicates the current line or region ARG times.
If there's no region, the current line will be duplicated. However, if
there's a region, all lines that region covers will be duplicated."
  (interactive "p")
  (let (beg end (origin (point)))
    (if (and mark-active (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if mark-active
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (goto-char (+ origin (* (length region) arg) arg)))))

;;; http://blog.binchen.org/posts/how-to-refactorrename-a-variable-name-in-a-function-efficiently.html
(defun change-symbol-in-defun ()
  "mark the region in defun (definition of function) and use string replacing UI in evil-mode
to replace the symbol under cursor"
  (interactive)
  (let ((old (thing-at-point 'symbol)))
	(mark-defun)
	(unless (evil-visual-state-p)
	  (evil-visual-state))
	(evil-ex (concat "'<,'>s/"
					 (if (= 0 (length old)) "" "\<\(")
					 old
					 (if (= 0 (length old)) "" "\)\>/")))))

;;; http://blog.binchen.org/posts/how-to-refactorrename-a-variable-name-in-a-function-efficiently.html
(defun change-symbol-in-buffer()
  "use string replacing UI in evil-mode to replace the symbol under cursor in the whole buffer"
  (interactive)
  (save-excursion
	(let ((old (thing-at-point 'symbol)))
	  (evil-ex (concat "%s/"
					   (if (= 0 (length old)) "" "\\<\\(")
					   old
					   (if (= 0 (length old)) "" "\\)\\>/"))))))

(defun my-focus-window()
  "make this window the only window and in a nice place down the center third of the frame"
  (interactive)
  (let ((blank "blank"))
	(delete-other-windows)
	(evil-window-vsplit)
	(switch-to-buffer blank)
	(evil-window-right 1)
	(evil-window-vsplit)
	(evil-window-right 1)
	(switch-to-buffer blank)
	(evil-window-left 1)))
