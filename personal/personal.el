(prelude-require-packages '(cyberpunk-theme yaml-mode))

;;(key-chord-mode -1) ; this does not play well with evil-mode

(tool-bar-mode -1)
(set-scroll-bar-mode -1)
(setq tab-width 2)
(setq whitespace-style (quote (face tabs trailing lines-tail)))
(setq ns-use-srgb-colorspace t)
;; one space at the end of sentences please
(setq sentence-end-double-space nil)

(setq user-full-name "Rory Kirchner")
(setq user-mail-address "rory.kirchner@gmail.com")

;; set registers to jump to quickly
(mapcar
 (lambda (r)
   (set-register (car r) (cons 'file (cdr r))))
 '((?o . "~/Documents/Org/hsph.org")))

;; this does the SUPER annoying auto-filling in of the closing paren
;; (smartparens-global-mode -1)

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

; save backup files to not
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(provide 'personal.el)

