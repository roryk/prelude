(key-chord-mode -1) ; this does not play well with evil-mode


(setq tab-width 2)
(setq whitespace-style (quote (face tabs trailing lines-tail)))

;; this does the SUPER annoying auto-filling in of the closing paren
;; (smartparens-global-mode -1)

(global-set-key (kbd "RET") 'newline-and-indent)
(load-theme 'cyberpunk t) ; this is nice and bright

;; load it like this so it is respected in new frames
(setq default-frame-alist '((font . "Source-Code-Pro-14")))

;; any type of bell coupled with evil-mode is obnoxious
(setq ring-bell-function 'ignore)

(require 'ess-site)
;; turn off this ultra annoying replace the underscore mode
(ess-toggle-underscore nil)

(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
