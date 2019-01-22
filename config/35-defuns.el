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

(defun tabs-please ()
  "Use tab=tab in all respects."
  (interactive)
  (setq-default indent-tabs-mode t)
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

(defun my-doc-at-point ()
  (interactive)
  (cond ((eq major-mode 'go-mode) (dash-at-point))
        ((eq major-mode 'cider-mode) (cider-doc))
        (t (cond
            ((eq system-type 'darwin) (dash-at-point))
            (t (zeal-at-point))))))

(defun my-compile-go ()
  (interactive)
  (gofmt)
  (save-buffer)
  (recompile))

(defun my-compile-rust ()
  (interactive)
  (save-buffer)
  (recompile))

(defun my-compile-default ()
  (interactive)
  (save-buffer)
  (recompile))

(defun my-compile ()
  (interactive)
  (save-buffer)
  (cond ((eq major-mode 'go-mode) (my-compile-go))
		((eq major-mode 'rust-mode) (my-compile-rust))
		(t (my-compile-default))))

(defun my-compilation-finish (buffer string)
  ;; The 'string' arg is a status description, also called a process sentinel.
  ;; The form of 'string' is described here:
  ;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Sentinels.html
  ;; (message "compilation sentinel: '%s'" string)
  (let ((o (selected-window))
		(w (get-buffer-window "*compilation*")))
	(when w
	  (cond ((string= string "finished\n") (identity "noop"))
			(t (first-error)))
	  (select-window w)
	  (select-window o))))

(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
   If no region is selected and current line is not blank and we are not at the end of the line,
   then comment current line.
   Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p))
           (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(defun my-highlight-service-log ()
  "Highlight special words in service logs"
  (interactive)
  (highlight-regexp "RunEngine" 'hi-red-b)
  (highlight-regexp "SharedDHKeyring" 'hi-green-b))

(defun my-swap-window-right ()
  "Swap with the window to the right. Leave the cursor on the left."
  (interactive)
  (buf-move-right)
  (windmove-left))

(defun set-diff (list1 list2 &optional key)
  ;; https://stackoverflow.com/questions/10939855/how-to-calculate-difference-between-two-sets-in-emacs-lisp-the-sets-should-be-li
  "Combine LIST1 and LIST2 using a set-difference operation.
Optional arg KEY is a function used to extract the part of each list
item to compare.

The result list contains all items that appear in LIST1 but not LIST2.
This is non-destructive; it makes a copy of the data if necessary, to
avoid corrupting the original LIST1 and LIST2."
  (if (or (null list1)  (null list2))
      list1
    (let ((keyed-list2  (and key  (mapcar key list2)))
          (result       ()))
      (while list1
        (unless (if key
                    (member (funcall key (car list1)) keyed-list2)
                  (member (car list1) list2))
          (setq result  (cons (car list1) result)))
        (setq list1  (cdr list1)))
      result)))

(defun my-get-go-guru-scope-modules-wide ()
  """ Lots of modules """
  (let* ((client-go-path "github.com/keybase/client/go/")
         (excludes
          '("."
            ".."
            "CHANGELOG.md"
            "Dockerfile"
            "LICENSE"
            "Makefile"
            "README.md"
            "bind"
            "copyright.sh"
            "copyright.txt"
            "doc"
            "notes"
            "vendor"))
         (mods (directory-files (format "%s/src/%s" (getenv "GOPATH") client-go-path)))
         (mods (set-diff mods excludes))
         (mods-paths (mapcar (function (lambda (x) (concat client-go-path x))) mods))
         (extras (list "golang.org/x/net/context")))
    (append mods-paths extras)))
; Example: (my-get-go-guru-scope-modules)

(defun my-get-go-guru-scope-modules-narrow ()
  """ Lots of modules """
  (let* ((client-go-path "github.com/keybase/client/go/")
         (mods
          '(
            "libkb"
            "chat"
            "teams"
            "encrypteddb"
            ))
         (mods-paths (mapcar (function (lambda (x) (concat client-go-path x))) mods))
         (extras (list "golang.org/x/net/context")))
    (append mods-paths extras)))
; Example: (my-get-go-guru-scope-modules-narrow)

(defun my-get-go-guru-scope-arg (mods-paths)
  (mapconcat (function (lambda (x) (format "%s/..." x))) mods-paths ","))
; Example: (my-get-go-guru-scope-arg (my-get-go-guru-scope-modules-narrow))

(defun my-go-set-guru-scope-wide ()
  (interactive)
  "Set a particular golang guru scope"
  (setq go-guru-scope (my-get-go-guru-scope-arg (my-get-go-guru-scope-modules-wide))))

(defun my-go-set-guru-scope-narrow ()
  (interactive)
  "Set a particular golang guru scope"
  (setq go-guru-scope (my-get-go-guru-scope-arg (my-get-go-guru-scope-modules-narrow))))

;;; https://emacs.stackexchange.com/questions/9989/add-window-to-the-right-of-two-horizontally-split-windows
(defun my-split-root-window (size direction)
  (split-window (frame-root-window)
                (and size (prefix-numeric-value size))
                direction))

(defun my-split-root-window-below (&optional size)
  (interactive "P")
  (my-split-root-window size 'below))

(defun my-split-root-window-right (&optional size)
  (interactive "P")
  (my-split-root-window size 'right))

; From https://gist.github.com/sideshowcoder/0d37c53bbf1d62299600bb723cc20af0
(defun my-go-guru-set-current-package-as-main ()
  "GoGuru requires the scope to be set to a go package which
   contains a main, this function will make the current package the
   active go guru scope, assuming it contains a main"
  (interactive)
  (let* ((filename (buffer-file-name))
         (gopath-src-path (concat (file-name-as-directory (go-guess-gopath)) "src"))
         (relative-package-path (directory-file-name (file-name-directory (file-relative-name filename gopath-src-path)))))
    (setq go-guru-scope relative-package-path)))

; https://emacsredux.com/blog/2013/06/25/boost-performance-by-leveraging-byte-compilation/
; (defun my-compile-init-dir ()
;   "Byte-compile dotfiles"
;   (interactive)
;   (byte-recompile-directory user-emacs-directory 0))
