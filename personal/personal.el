(prelude-require-packages '(cyberpunk-theme yaml-mode ess))

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

(add-to-list 'default-frame-alist '(font . "Source-Code-Pro-12"))

;; any type of bell coupled with evil-mode is obnoxious
(setq ring-bell-function 'ignore)

(require 'ess-site)
;; turn off this ultra annoying replace the underscore mode
(ess-toggle-underscore nil)

;; set up YAML mode
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

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

(provide 'personal.el)

