(prelude-require-packages '(ess))

(require 'ess-site)
;; turn off this ultra annoying replace the underscore mode
(ess-toggle-underscore nil)

;; auto-complete can be ultra slow in R buffers, so disable it
(setq ess-use-auto-complete nil)
;; company-mode is also superbadslow

(add-hook 'ess-mode-hook
          (lambda ()
            (company-mode 0)))

(setq ess-use-eldoc-nill)

(provide 'personal-ess)
