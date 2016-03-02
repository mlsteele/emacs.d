;;; nim-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (or (file-name-directory #$) (car load-path)))

;;;### (autoloads nil "company-nim" "company-nim.el" (22195 55841
;;;;;;  660870 957000))
;;; Generated autoloads from company-nim.el

(autoload 'company-nim "company-nim" "\
`company-mode` backend for nimsuggest.

\(fn COMMAND &optional ARG &rest IGNORED)" t nil)

;;;***

;;;### (autoloads nil "nim-eldoc" "nim-eldoc.el" (22195 55841 648870
;;;;;;  761000))
;;; Generated autoloads from nim-eldoc.el

(autoload 'nim-eldoc-setup "nim-eldoc" "\
Setup eldoc configuration for nim-mode.

\(fn)" nil nil)

(add-hook 'nim-mode-hook 'nim-eldoc-setup)

;;;***

;;;### (autoloads nil "nim-mode" "nim-mode.el" (22195 55841 668871
;;;;;;  87000))
;;; Generated autoloads from nim-mode.el

(autoload 'nim-mode "nim-mode" "\
A major mode for the Nim programming language.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '("\\.nim\\(ble\\|s\\)?\\'" . nim-mode))

;;;***

;;;### (autoloads nil nil ("nim-compile.el" "nim-fill.el" "nim-helper.el"
;;;;;;  "nim-mode-pkg.el" "nim-rx.el" "nim-smie.el" "nim-suggest.el"
;;;;;;  "nim-syntax.el" "nim-thing-at-point.el" "nim-util.el" "nim-vars.el")
;;;;;;  (22195 55841 677755 786000))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; nim-mode-autoloads.el ends here
