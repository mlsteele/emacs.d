;;; ansible-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "ansible" "ansible.el" (22972 15589 0 0))
;;; Generated autoloads from ansible.el

(defvar ansible::key-map (make-sparse-keymap) "\
Keymap for Ansible.")

(autoload 'ansible "ansible" "\
Ansible minor mode.

\(fn &optional ARG)" t nil)

(autoload 'ansible::snippets-initialize "ansible" "\
Initialize Ansible yasnippets.

\(fn)" nil nil)

(eval-after-load 'yasnippet '(ansible::snippets-initialize))

(autoload 'ansible::dict-initialize "ansible" "\
Initialize Ansible auto-complete.

\(fn)" nil nil)

;;;***

;;;### (autoloads nil nil ("ansible-pkg.el") (22972 15589 379533
;;;;;;  0))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ansible-autoloads.el ends here
