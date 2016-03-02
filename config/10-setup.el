;;; Core setup stuff.

;;; Use some CommonLisp things.
(require 'cl)

;;; Add ~/.emacs.d/lisp directory to the load path.
;;; This is where manually downloaded and written packages go.
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;; Start the emacs server.
(server-start)
