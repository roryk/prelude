(prelude-require-packages '(ess))

(require 'ess-site)
;; turn off this ultra annoying replace the underscore mode
(ess-toggle-underscore nil)

;; auto-complete can be ultra slow in R buffers, so disable it
(setq ess-auto-complete nil)

(provide 'personal-ess)
