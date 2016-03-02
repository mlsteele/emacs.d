;;; Enable Helm
(require 'helm)
(require 'helm-config)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;;; Evil-ify helm
(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)
(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)
(define-key helm-map (kbd "C-d") 'helm-next-page)
(define-key helm-map (kbd "C-u") 'helm-previous-page)

;;; C-p to search for files
(global-set-key (kbd "C-p") 'helm-multi-files)
(define-key evil-normal-state-map (kbd "C-p") 'helm-multi-files)

(setq
 ;; open helm buffer inside current window
 helm-split-window-in-side-p t
 ;; Search for library in `require' and `declare-function'
 helm-ff-search-library-in-sexp t
 ;; scroll 8 lines other window using M-<next>/M-<prior>
 helm-scroll-amount 8
 helm-ff-file-name-history-use-recentf t
 )

(helm-mode 1)

;;; Descbinds
(require 'helm-descbinds)
(helm-descbinds-mode 1)

;;; Great Helm tutorial
;;; http://tuhdo.github.io/helm-intro.html#sec-2

;;; CtrlP is helm with projectile
(define-key evil-normal-state-map (kbd "C-p") 'helm-projectile)

;;; Symbol browser
(define-key evil-normal-state-map (kbd "r") 'helm-imenu)

(defun helm-multi-all-custom ()
  "multi-occur in all buffers backed by files."
  (interactive)
  (helm-multi-occur
   (delq nil
	 (mapcar (lambda (b)
		   (when (buffer-file-name b) (buffer-name b)))
		 (buffer-list)))))
