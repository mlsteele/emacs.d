;;; counsel-bbdb-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "counsel-bbdb" "counsel-bbdb.el" (22972 19672
;;;;;;  0 0))
;;; Generated autoloads from counsel-bbdb.el

(autoload 'counsel-bbdb-insert-string "counsel-bbdb" "\
Insert STR into current buffer.

\(fn STR)" nil nil)

(autoload 'counsel-bbdb-reload "counsel-bbdb" "\
Load contacts from `bbdb-file'.

\(fn)" t nil)

(autoload 'counsel-bbdb-complete-mail "counsel-bbdb" "\
In a mail buffer, complete email before point.
Extra argument APPEND-COMMA will append comma after email.

\(fn &optional APPEND-COMMA)" t nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; counsel-bbdb-autoloads.el ends here
