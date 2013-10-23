(key-chord-mode -1)
(setq default-tab-width 2)
(setq whitespace-style (quote (face tabs trailing lines-tail)))

;; this does the SUPER annoying auto-filling in of the closing paren
(smartparens-global-mode -1)

(global-set-key (kbd "RET") 'newline-and-indent)
(load-theme 'cyberpunk t)

;; any type of bell coupled with evil-mode is obnoxious
(setq ring-bell-function 'ignore)

(require 'ess-site)
;; turn off this ultra annoying replace the underscore mode
(ess-toggle-underscore nil)
