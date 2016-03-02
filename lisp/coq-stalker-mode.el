;;; coq-stalker-mode.el --- track coq proofs with cursor

(defvar coq-stalker--busy nil
  "Whether coq-stalker is currently invoked. Used to avoid unhappy recursion.")
(setq coq-stalker--busy nil)

(defun coq-stalker-here ()
  "Send up to and including the current command."
  (interactive)
  (save-excursion
    (proof-goto-command-start)
    (ignore-errors (backward-char))
    (if (> (proof-queue-or-locked-end) (point))
      (proof-retract-until-point)
      (proof-assert-until-point))))

(defun coq-stalker--triggered (&rest args)
  "Action to take often in stalker mode."
  ;; (message "stalker")
  (when (and
	 coq-stalker-mode
	 (not coq-stalker--busy)
	 (not proof-shell-busy)
	 (evil-normal-state-p))
    (let ((coq-stalker--busy t))
      (ignore-errors
	(coq-stalker-here)))))

;; (defun coq-stalker--hookin ()
;;   (add-hook 'evil-normal-state-entry-hook 'coq-stalker--triggered t nil)
;;   (advice-add 'evil-goto-first-line :after #'coq-stalker--triggered)
;;   ;; (advice-add 'evil-line-move :after #'coq-stalker--triggered)
;;   (advice-add 'next-line :after #'coq-stalker--triggered)
;;   (advice-add 'previous-line :after #'coq-stalker--triggered)
;;   (advice-add 'goto-char :after #'coq-stalker--triggered))

;; ;;; This is not actually used, because the hooks are global.
;; (defun coq-stalker--unhook ()
;;   (remove-hook 'evil-normal-state-entry-hook 'coq-stalker--triggered nil)
;;   (advice-remove 'evil-goto-first-line #'coq-stalker--triggered)
;;   ;; (advice-remove 'evil-line-move #'coq-stalker--triggered)
;;   (advice-remove 'next-line #'coq-stalker--triggered)
;;   (advice-remove 'previous-line #'coq-stalker--triggered)
;;   (advice-remove 'goto-char #'coq-stalker--triggered))

;;;###autoload
(define-minor-mode coq-stalker-mode
  "The coq point will follow you everywhere."
  :global nil
  :init-value nil
  :lighter nil
  (if coq-stalker-mode
    (progn
      (coq-stalker--triggered)
      (add-hook 'post-command-hook #'coq-stalker--triggered t t))
    (remove-hook 'post-command-hook #'coq-stalker--triggered t)))

;; (define-global-minor-mode global-coq-stalker-mode coq-stalker-mode
;;   coq-stalker-mode)

;; (coq-stalker--hookin)

(provide 'coq-stalker-mode)
