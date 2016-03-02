;; (define-key evil-normal-state-map (kbd "R") 'my-cider-eval-paragraph)
(defun my-cider-eval-paragraph ()
  "Eval a paragraph in cider."
  (interactive)
  (save-excursion
    (mark-paragraph)
    (command-execute 'cider-eval-region)))

(defadvice cider-last-sexp (around evil activate)
  "In normal-state or motion-state, last sexp ends at point."
  (if (or (evil-normal-state-p) (evil-motion-state-p))
      (save-excursion
	(unless (or (eobp) (eolp)) (forward-char))
	ad-do-it)
    ad-do-it))
