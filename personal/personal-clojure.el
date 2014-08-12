(prelude-require-packages '[slamhound clj-refactor])

(cljr-add-keybindings-with-prefix "C-c ;")

(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(add-hook 'cider-repl-mode-hook 'smartparens-strict-mode)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)

(setq nrepl-hide-special-buffers t)
(setq cider-stacktrace-default-filters '(java clj))
(setq nrepl-buffer-name-show-port t)
(setq cider-repl-print-length 25)
(setq cider-prompt-save-file-on-load nil)
(setq cider-show-error-buffer nil)


(provide 'personal-clojure)
