(prelude-require-packages '(ess polymode))

(require 'ess-site)
;; turn off this ultra annoying replace the underscore mode
(ess-toggle-underscore nil)


;; auto-complete can be ultra slow in R buffers, so disable it
;;(setq ess-use-auto-complete nil)
;; company-mode is also superbadslow

;;add-hook 'ess-mode-hook
  ;;        (lambda ()
   ;;         (company-mode 0)))

;;(setq ess-use-eldoc-nil)

;; (defun rmd-mode ()
;;   "ESS Markdown mode for rmd files"
;;   (interactive)
;;   (setq load-path
;;         (append (list "path/to/polymode/" "path/to/polymode/modes/")
;;                 load-path))
;;   (require 'poly-R)
;;   (require 'poly-markdown)
;;   (poly-markdown+r-mode))

(provide 'personal-ess)
