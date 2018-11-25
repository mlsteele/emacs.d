;;; Add config directory to the load path.
;;; Nah.
;;; (add-to-list 'load-path (expand-file-name "config" user-emacs-directory))

;;; Load files in order from ~/.emacs.d/config

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(let* ((dir (expand-file-name "config" user-emacs-directory))
       (files (directory-files dir t "^..-.*\.el$")))
  (dolist (file files)
    (load file)))
(put 'narrow-to-region 'disabled nil)
