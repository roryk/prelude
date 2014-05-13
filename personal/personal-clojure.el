
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

(setq nrepl-hide-special-buffers t)
(setq cider-stacktrace-default-filters '(java clj))
(setq nrepl-buffer-name-show-port t)
(setq cider-repl-print-length 25)
(setq cider-prompt-save-file-on-load nil)


;; (setq cider-popup-stacktraces nil)
;; (setq cider-repl-popup-stacktraces t)

;; (defun cider-namespace-refresh ()
;;  (interactive)
;;  (cider-interactive-eval
;;   "(require 'clojure.tools.namespace.repl)
;;    (require '[clojure.pprint :refer [pprint]])
;;    (clojure.tools.namespace.repl/refresh)"))

;; (define-key clojure-mode-map (kbd "M-r") 'cider-namespace-refresh)

;; (provide 'personal-clojure)
