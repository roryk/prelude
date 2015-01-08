(require 'org)
(prelude-require-packages '(org-caldav))

(setq org-modules '(org-habit))
(org-load-modules-maybe t)

(setq org-deadline-warning-days 14)
(global-set-key (kbd "C-c c") 'org-capture)
(setq org-directory "~/Documents/Org")
(setq org-default-notes-file "~/Documents/Org/hsph.org")

(setq org-todo-keywords
      '((sequence
         "TODO(t)"
         "WAITING(w)"
         "SOMEDAY(.)"
         "|" "DONE(x!)" "CANCELLED(c@)")
        (sequence "MEET(m)" "|" "COMPLETE(x)")
        (sequence "TODELEGATE(-)" "DELEGATED(d)" "COMPLETE(x)")))

                                        ; stuff for GTD
(setq org-agenda-custom-commands
      '(("W" "Weekly Review"
         ((agenda "" ((org-agenda-span 7)
                      (org-agenda-start-day "-7d")
                      (org-agenda-entry-types '(:timestamp))
                      (org-agenda-show-log t)))
          (todo "WAITING") ;; projects we are waiting on
          (todo "TODO")  ;; review what is next
          (tags "INBOX" ((org-agenda-files '("~/Documents/Org/inbox.org"))))
          (tags "PROJECT") ;; review all projects
          (tags "SOMEDAY"))) ;; review someday/maybe items

        ("D" "Daily review"
         ((agenda "" ((org-agenda-ndays 7)))
          (todo "DELEGATED") ;; projects we are waiting on
          (todo "NEXT")
          (tags "@errands")))))

(setq org-agenda-files '("~/Documents/Org/hsph.org" "~/Documents/Org/habits.org"))
(setq org-icalendar-combined-agenda-file "~/Dropbox/Public/hsph.ics")
(setq org-icalendar-alarm-time 60)

;; Needs terminal-notifier (brew install terminal-notifier)
(defun notify-osx (title message)
  (call-process "terminal-notifier"
                nil 0 nil
                "-group" "Emacs"
                "-title" title
                "-sender" "org.gnu.Emacs"
                "-message" message))

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
 '(org-level-5 ((t (:inherit outline-5 :height 1.0)))))

;; org-capture
(setq org-reverse-note-order t)
(setq org-refile-use-outline-path nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)
(setq org-refile-use-cache nil)
(setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))
(setq org-blank-before-new-entry nil)

(setq org-tag-alist '(("@work" . ?b)
                      ("@home" . ?h)
                      ("@writing" . ?w)
                      ("@errands" . ?e)
                      ("@coding" . ?c)
                      ("@reading" . ?r)
                      ("@summary" . ?s)
                      ("@computer" . ?l)
                      ("@project" . ?p)))

;;; try org-projectile
(require 'org-projectile)
(setq org-projectile:projects-file
      "~/Documents/Org/hsph.org")
(add-to-list 'org-capture-templates (org-projectile:project-todo-entry))
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c n p") 'org-projectile:project-todo-completing-read)

;; updating the calendar on saving is annoying because it adds lag every time we
;; save an org-mode buffer. this waits until we have been idle for 20 minutes and
;; does it.
(defvar roryk-org-sync-timer nil)

(defvar roryk-org-sync-secs (* 60 20))

(defun roryk-org-sync ()
  (org-icalendar-combine-agenda-files)
  (notify-osx "Emacs (org-mode)" "iCal sync completed."))

(defun roryk-org-sync-start ()
  "Start automated org-mode syncing"
  (interactive)
  (setq roryk-org-sync-timer
        (run-with-idle-timer roryk-org-sync-secs t
                             'roryk-org-sync)))

(defun roryk-org-sync-stop ()
  "Stop automated org-mode syncing"
  (interactive)
  (cancel-timer roryk-org-sync-timer))

(roryk-org-sync-start)

;; enable ditaa mode in org-mode
(setq org-ditaa-jar-path "/usr/local/Cellar/ditaa/0.9/libexec/ditaa0_9.jar")
(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t)
   (dot . t)
   (latex . t)))

(provide 'personal-org)
