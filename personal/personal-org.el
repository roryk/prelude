(setq org-todo-keywords
      '((type "TODO(t)" "WAITING(w)" "APPT(a)" "NEXT(n)" "READ(r)"
              "|"
              "DEFERRED(e)" "DONE(d)" "SOMEDAY(s)" "MAYBE(m)" "IDEA(i)")
        (sequence "PROJECT(p)" "|" "FINISHED(f)" "CANCELLED(c)")))

; stuff for GTD
(setq org-agenda-custom-commands
      '(("W" "Weekly Review"
         ((agenda "" ((org-agenda-ndays 14)))
          (todo "NEXT")  ;; review what is next
          (tags "INBOX" ((org-agenda-files '("~/Documents/Org/notes.org"))))
          (tags "PROJECT") ;; review all projects
          (tags "SOMEDAY"))) ;; review someday/maybe items

        ("D" "Daily review"
         ((agenda "" ((org-agenda-ndays 14)))
          (todo "NEXT")
          (tags "INBOX" ((org-agenda-files '("~/Documents/Org/notes.org"))))
          (todo "READ"))))
)

(provide 'personal-org)
