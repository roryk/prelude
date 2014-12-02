(prelude-require-packages '(cyberpunk-theme todochiku))

;;(key-chord-mode -1) ; this does not play well with evil-mode

(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq tab-width 2)
(setq whitespace-style (quote (face tabs trailing lines-tail)))
(setq ns-use-srgb-colorspace t)

;; in my world, sentences have one space between them
(setq sentence-end-double-space nil)

(setq user-full-name "Rory Kirchner")
(setq user-mail-address "rory.kirchner@gmail.com")

(global-set-key (kbd "RET") 'newline-and-indent)
(load-theme 'cyberpunk t) ; this is nice and bright

;; (add-to-list 'default-frame-alist '(font . "Source-Code-Pro-12"))

;; any type of bell coupled with evil-mode is obnoxious
(setq ring-bell-function 'ignore)

;; run a local flycheck not remote
(defadvice flycheck-start-checker (around flycheck-fix-start-process activate compile)
  "Make flycheck-start-checker use `start-process' instead of `start-file-process'."
  (let ((orig (symbol-function 'start-file-process)))
    (fset 'start-file-process (symbol-function 'start-process))
    (unwind-protect (progn ad-do-it)
      (fset 'start-file-process orig))))

;; set up some nice ido mode defaults
(setq ido-enable-flex-matching t
     ido-auto-merge-work-directories-length -1
     ido-create-new-buffer 'always
     ido-use-filename-at-point 'guess
     ido-everywhere t
     ido-default-buffer-method 'selected-window)
(ido-mode 1)
(put 'ido-exit-minibuffer 'disabled nil)
(when (require 'ido-ubiquitous nil t)
 (ido-ubiquitous-mode 1))

;; don't spread backup files everywhere
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; prevent dialog boxes from opening up on OSX
(defadvice yes-or-no-p (around prevent-dialog activate)
  "Prevent yes-or-no-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

(defadvice y-or-n-p (around prevent-dialog-yorn activate)
  "Prevent y-or-n-p from activating a dialog"
  (let ((use-dialog-box nil))
    ad-do-it))

(setq todochiku-command "growlnotify")
(require 'todochiku)
(setq org-show-notification-handler
      '(lambda (notification)
         (todochiku-message "org-mode notification" notification
                            (todochiku-icon 'emacs))))
(defun my-org-agenda-to-appt ()
  (interactive)
  (setq appt-time-msg-list nil)
  (org-agenda-to-appt))

(my-org-agenda-to-appt)
(setq appt-message-warning-time 60)
(setq appt-display-interval 5)
(appt-activate t)
(run-at-time "24:01" nil 'my-org-agenda-to-appt)
(add-hook 'org-finalize-agenda-hook 'my-org-agenda-to-appt)

;;; fix some of the encoding in ansi-term
(defadvice ansi-term (after advise-ansi-term-coding-system)
  (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix))
(ad-activate 'ansi-term)

(setq auto-indent-newline-function 'newline-and-indent)


(provide 'personal.el)
