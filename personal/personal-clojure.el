(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers nil)
(setq cider-popup-stacktraces nil)
(setq cider-repl-popup-stacktraces t)
(setq cider-auto-select-error-buffer nil)

;(defun cider-namespace-refresh ()
;  (interactive)
;  (cider-interactive-eval
;   "(require 'clojure.tools.namespace.repl)
;    (require '[clojure.pprint :refer [pprint]])
;    (clojure.tools.namespace.repl/refresh)"))

;(define-key clojure-mode-map (kbd "M-r") 'cider-namespace-refresh)

(provide 'personal-clojure)
