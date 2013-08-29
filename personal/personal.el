(key-chord-mode -1)
(setq default-tab-width 2)
(setq whitespace-style (quote (face tabs trailing lines-tail)))

;; this does the SUPER annoying auto-filling in of the closing paren
(smartparens-global-mode -1)

(local-set-key (kbd "RET") 'newline-and-indent)
(load-theme 'solarized-dark t)

(setq mac-command-modifier 'super)
(setq mac-option-modifier 'meta)
