;;; Enable evil-mode
(require 'evil)
(evil-mode 1)
(evil-escape-mode 1)
(setq-default evil-escape-key-sequence "fd")
(setq-default evil-escaped-delay 0.1)

;;; Use C-c as general purpose escape key sequence.
;;; From: http://www.emacswiki.org/emacs/Evil#toc15
(defun my-esc (prompt)
  "Functionality for escaping generally. Includes exiting Evil insert state and C-g binding. "
  (cond
   ;; If we're in one of the Evil states that defines [escape] key, return [escape] so as
   ;; Key Lookup will use it.
   ((or (evil-insert-state-p)
	(evil-normal-state-p)
	(evil-replace-state-p)
	(evil-visual-state-p))
    [escape])
   ;; This is the best way I could infer for now to have C-c work during evil-read-key.
   ;; Note: As long as I return [escape] in normal-state, I don't need this.
   ;;((eq overriding-terminal-local-map evil-read-key-map) (keyboard-quit) (kbd ""))
   (t (kbd "C-g"))))

(define-key key-translation-map (kbd "C-c") 'my-esc)
;;; Works around the fact that Evil uses read-event directly when in operator state, which
;;; doesn't use the key-translation-map.
(define-key evil-operator-state-map (kbd "C-c") 'keyboard-quit)
;;; Not sure what behavior this changes, but might as well set it, seeing the Elisp manual's
;;; documentation of it.
(when (display-graphic-p)
  (set-quit-char "C-c"))

;;; Use ; as :
(define-key evil-normal-state-map (kbd ";") 'evil-ex)

;;; Use space as save
(define-key evil-normal-state-map (kbd "SPC") 'save-buffer)

;;; Fix scroll up
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)

;;; Shortcut for query replace.
(define-key evil-normal-state-map (kbd "M-q") 'query-replace)

(defun move-line-up ()
  "Move a line up one, removing the line before it."
  (interactive)
  (previous-line)
  (kill-whole-line))

;;; Move line up.
(define-key evil-normal-state-map (kbd "C-k") 'move-line-up)

;;; Adjust scroll center to scroll top-ish.
(evil-define-command evil-scroll-line-to-top-ish (count)
  "Scrolls the current line to the top-ish to line COUNT."
  :repeat nil
  :keep-visual t
  (interactive "P")
  (evil-save-column
    (let ((vis-line (or count 10)))
      (recenter vis-line))))

(global-evil-jumper-mode t)
