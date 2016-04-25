;;; These should move TODO
(require 'ace-jump-mode)
(projectile-global-mode)
;;; Set the mode line statically to avoid a bug where
;;; some ticker updates it all the time based on filesystem
;;; accesses which are slow on remote filesystems.
(setq projectile-mode-line " Projectile")
(require 'cider)

;;; Store customizations with config.
(setq custom-file (expand-file-name "config/90-custom.el" user-emacs-directory))

;;; Write backup files to ~/.emacs.backups
(let ((backup-dir (expand-file-name (concat user-emacs-directory "backups"))))
    (setq backup-directory-alist         `((".*" . ,backup-dir))
	  auto-save-file-name-transforms `((".*" ,backup-dir t))))

;;; Disable pesky lock files (symlinks like ".#argh.py")
(setq create-lockfiles nil)

;; Make backups of files, even when they're in version control.
(setq vc-make-backup-files t)

;;; Make tags file
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command (format "ctags -f %s/tags -e -R %s"
			 (directory-file-name dir-name)
			 (directory-file-name dir-name))))

(add-to-list 'projectile-globally-ignored-directories "node_modules")

(setq inhibit-startup-screen t)

;;; Add Go to path.
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/go/bin"))
(setenv "PATH" (concat (getenv "PATH") (substitute-in-file-name ":$HOME/go/bin")))
