(require 'prelude-programming)

(prelude-require-packages '(evil-paredit))

(setq evil-cross-lines t)
(setq evil-move-cursor-back nil)

(define-key evil-normal-state-map ";" 'smex)
(define-key evil-visual-state-map ";" 'smex)

(provide 'personal-evil)
