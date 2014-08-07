(require 'prelude-programming)

(prelude-require-packages '(evil-paredit))

(define-key evil-normal-state-map ";" 'smex)
(define-key evil-visual-state-map ";" 'smex)

(provide 'personal-evil)
