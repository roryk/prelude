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
          (tags "INBOX" ((org-agenda-files '("~/Documents/Org/notes.org"))))
          (tags "PROJECT") ;; review all projects
          (tags "SOMEDAY"))) ;; review someday/maybe items

        ("D" "Daily review"
         ((agenda "" ((org-agenda-ndays 14)))
          (todo "WAITING") ;; projects we are waiting on
          (todo "NEXT")
          (tags "INBOX" ((org-agenda-files '("~/Documents/Org/notes.org"))))
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

(provide 'personal-org)
