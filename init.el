;;; Add config directory to the load path.
;;; Nah.
;;; (add-to-list 'load-path (expand-file-name "config" user-emacs-directory))

;;; Load files in order from ~/.emacs.d/config
(let* ((dir (expand-file-name "config" user-emacs-directory))
       (files (directory-files dir t "^..-.*\.el$")))
  (dolist (file files)
    (load file)))
