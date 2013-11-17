(require 'org)
(setq org-todo-keywords
      '((type "TODO(t)" "WAITING(w)" "APPT(a)" "NEXT(n)" "READ(r)"
              "|"
              "DEFERRED(e)" "DONE(d)" "SOMEDAY(s)" "MAYBE(m)" "IDEA(i)")
        (sequence "PROJECT(p)" "|" "FINISHED(f)" "CANCELLED(c)")))

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

(require 'org-pomodoro)
(setq org-pomodoro-play-sounds nil)
(setq org-agenda-files (list "~/Documents/Org/"))
(eval-after-load "org-agenda"
	`(progn
		(define-key org-agenda-mode-map "j" 'evil-next-line)
		(define-key org-agenda-mode-map "k" 'evil-previous-line)))

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

(setq org-directory "~/Documents/Org")
(setq org-mobile-inbox-for-pull "~/Documents/Org/inbox.org")
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")
(setq org-mobile-files '("~/Documents/Org"))

(set-register ?w '(file . "~/Documents/Org/hsph.org"))
(setq org-caldav-url "http://ruelz.synology.me:5005")
(setq org-caldav-calendar-id "calendar/rory")
(setq org-caldav-inbox "/Users/rory/Documents/Org/inbox.org")
(setq org-caldav-files '("/Users/rory/Documents/Org/hsph.org"))
(defvar org-caldav-sync-timer nil)
(defvar org-caldav-sync-idle-secs (* 60 5))
(defun org-caldav-sync-enable ()
  "enable automatic org-caldav sync with the Synology calendar"
  (interactive)
  (setq org-caldav-sync-timer
        (run-with-idle-timer org-caldav-sync-idle-secs t
                             'org-caldav-sync)));
(defun org-caldav-sync-disable ()
  "disable automatic org-caldav sync"
  (interactive)
  (cancel-timer org-caldav-sync-timer))
(org-caldav-sync-enable)

(provide 'personal-org)
