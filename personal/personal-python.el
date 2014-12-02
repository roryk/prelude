(require 'prelude-programming)

;; pip install jedi epc
;;(prelude-require-packages '(epc auto-complete jedi virtualenv))

;; Setup python-mode
;; (autoload 'python-mode "python" "Python Mode." t)
(setq python-shell-interpreter "ipython")

(autoload 'python-mode "python" "Python Mode." t)
(setq
 python-shell-interpreter "ipython"
 python-shell-interpreter-args "--matplotlib=inline"
 python-shell-prompt-regexp "In \\[[0-9]+\\]: "
 python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
 python-shell-completion-setup-code
 "from IPython.core.completerlib import module_completion"
 python-shell-completion-module-string-code
 "';'.join(module_completion('''%s'''))\n"
 python-shell-completion-string-code
 "';'.join(get_ipython().Completer.all_completions('''%s'''))\n")

;; ;; fix for arithmetic error
;; (defun python-indent-guess-indent-offset ()
;;   "Guess and set `python-indent-offset' for the current buffer."
;;   (interactive)
;;   (save-excursion
;;     (save-restriction
;;       (widen)
;;       (goto-char (point-min))
;;       (let ((block-end))
;;         (while (and (not block-end)
;;                     (re-search-forward
;;                      (python-rx line-start block-start) nil t))
;;           (when (and
;;                  (not (python-syntax-context-type))
;;                  (progn
;;                    (goto-char (line-end-position))
;;                    (python-util-forward-comment -1)
;;                    (if (equal (char-before) ?:)
;;                        t
;;                      (forward-line 1)
;;                      (when (python-info-block-continuation-line-p)
;;                        (while (and (python-info-continuation-line-p)
;;                                    (not (eobp)))
;;                          (forward-line 1))
;;                        (python-util-forward-comment -1)
;;                        (when (equal (char-before) ?:)
;;                          t)))))
;;             (setq block-end (point-marker))))
;;         (let ((indentation
;;                (when block-end
;;                  (goto-char block-end)
;;                  (python-util-forward-comment)
;;                  (current-indentation))))
;;           (if (> indentation 0)
;;               (set (make-local-variable 'python-indent-offset) indentation)
;;             (message "Can't guess python-indent-offset, using defaults: %s"
;;                      python-indent-offset)))))))

;; (defun prelude-python-mode-defaults ()
;;   (run-hooks 'prelude-prog-mode-hook) ;; run manually; not derived from prog-mode
;; ;;  (jedi:setup)
;;   (auto-complete-mode +1)
;;   (whitespace-mode +1)
;;   (virtualenv-minor-mode +1)
;;   (electric-indent-mode -1)
;;   (smartparens-mode -1))

;; (setq prelude-python-mode-hook 'prelude-python-mode-defaults)

;; (add-hook 'python-mode-hook (lambda ()
;;                               (run-hooks 'prelude-python-mode-hook)))
(provide 'personal-python)
