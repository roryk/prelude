(require 'prelude-programming)

(prelude-require-packages '(evil-paredit))

;; prevent esc-key from translating to meta-key in terminal mode
(setq evil-esc-delay 0)

(define-key evil-normal-state-map ";" 'smex)
(define-key evil-visual-state-map ";" 'smex)

(provide 'personal-evil)
