(require 'org)
(setq org-todo-keywords
      '((type "TODO(t)" "WAITING(w)" "APPT(a)" "NEXT(n)" "READ(r)" "BUG(b)"
              "|"
              "DEFERRED(e)" "DONE(d)" "SOMEDAY(s)" "MAYBE(m)" "IDEA(i)" "FIXED(f)")
        (sequence "PROJECT(p)" "|" "COMPLETE(k)" "CANCELLED(c)")))

; stuff for GTD
(setq org-agenda-custom-commands
      '(("W" "Weekly Review"
         ((agenda "" ((org-agenda-ndays 14)))
          (todo "WAITING") ;; projects we are waiting on
          (todo "NEXT")  ;; review what is next
          (tags "INBOX" ((org-agenda-files '("~/Documents/Org/inbox.org"))))
          (tags "PROJECT") ;; review all projects
          (tags "SOMEDAY"))) ;; review someday/maybe items

        ("D" "Daily review"
         ((agenda "" ((org-agenda-ndays 14)))
          (todo "WAITING") ;; projects we are waiting on
          (todo "NEXT")
          (tags "INBOX" ((org-agenda-files '("~/Documents/Org/inbox.org"))))
          (todo "READ")))))

;; pomodoro
(require 'org-pomodoro)
(setq org-pomodoro-play-sounds nil)
(setq org-agenda-files (list "~/Documents/Org/"))
;; Needs terminal-notifier (brew install terminal-notifier)
(defun notify-osx (title message)
  (call-process "terminal-notifier"
                nil 0 nil
                "-group" "Emacs"
                "-title" title
                "-sender" "org.gnu.Emacs"
                "-message" message))

;; org-pomodoro mode hooks
(add-hook 'org-pomodoro-finished-hook
          (lambda ()
            (notify-osx "Pomodoro completed!" "Time for a break.")))

(add-hook 'org-pomodoro-break-finished-hook
          (lambda ()
            (notify-osx "Pomodoro Short Break Finished" "Ready for Another?")))

(add-hook 'org-pomodoro-long-break-finished-hook
          (lambda ()
            (notify-osx "Pomodoro Long Break Finished" "Ready for Another?")))

(add-hook 'org-pomodoro-killed-hook
          (lambda ()
            (notify-osx "Pomodoro Killed" "One does not simply kill a pomodoro!")))

;; use vi j/k to navigate the agenda
(eval-after-load "org-agenda"
  `(progn
     (define-key org-agenda-mode-map "j" 'evil-next-line)
     (define-key org-agenda-mode-map "k" 'evil-previous-line)))

(add-hook 'org-mode-hook
          (lambda ()
            (define-key org-mode-map [(shift right)] 'windmove-right)
            (define-key org-mode-map [(shift left)] 'windmove-left)
            (define-key org-mode-map [(shift up)] 'windmove-up)
            (define-key org-mode-map [(shift down)] 'windmove-down)))

(defun esf/evil-key-bindings-for-org ()
  ;;(message "Defining evil key bindings for org")
  (evil-declare-key 'normal org-mode-map
    "gk" 'outline-up-heading
    "gj" 'outline-next-visible-heading
    "H" 'org-beginning-of-line ; smarter behaviour on headlines etc.
    "L" 'org-end-of-line ; smarter behaviour on headlines etc.
    "t" 'org-todo ; mark a TODO item as DONE
    ",c" 'org-cycle
    (kbd "TAB") 'org-cycle
    ",e" 'org-export-dispatch
    ",n" 'outline-next-visible-heading
    ",p" 'outline-previous-visible-heading
    ",t" 'org-set-tags-command
    ",u" 'outline-up-heading
    "$" 'org-end-of-line ; smarter behaviour on headlines etc.
    "^" 'org-beginning-of-line ; ditto
    "-" 'org-ctrl-c-minus ; change bullet style
    "<" 'org-metaleft ; out-dent
    ">" 'org-metaright ; indent
    ))
(esf/evil-key-bindings-for-org)


;; (set-register ?w '(file . "~/Documents/Org/hsph.org"))
;; (load "~/.emacs.d/elpa/org-caldav/org-caldav.el")
;; (setq org-caldav-url "http://ruelz.synology.me:5005")
;; (setq org-caldav-calendar-id "calendar/rory")
;; (setq org-caldav-inbox "/Users/rory/Documents/Org/inbox.org")
;; (setq org-caldav-files '("/Users/rory/Documents/Org/hsph.org"))
;; (defvar org-caldav-sync-timer nil)
;; (defvar org-caldav-sync-idle-secs (* 60 60 12))
;; (setq org-caldav-show-sync-results nil)
;; (defun org-caldav-sync-enable ()
;;   "enable automatic org-caldav sync with the Synology calendar"
;;   (interactive)
;;   (setq org-caldav-sync-timer
;;         (run-with-idle-timer org-caldav-sync-idle-secs t
;;                              'org-caldav-sync)));
;; (defun org-caldav-sync-disable ()
;;   "disable automatic org-caldav sync"
;;   (interactive)
;;   (cancel-timer org-caldav-sync-timer))
;; (org-caldav-sync-enable)

;; (add-hook 'org-mode-hook
;;           (lambda ()
;;             (add-hook 'after-save-hook 'org-caldav-sync nil 'make-it-local)))

;; windmove conflicts with the org-mode changing timestamps and what not
(add-hook 'org-shiftup-final-hook 'windmove-up)
(add-hook 'org-shiftleft-final-hook 'windmove-left)
(add-hook 'org-shiftdown-final-hook 'windmove-down)
(add-hook 'org-shiftright-final-hook 'windmove-right)

;; we do not need HUGE fonts for the title
(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.0))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.0))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.0))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
 )
(provide 'personal-org)
