(require 'org)
(prelude-require-packages '(org-pomodoro))

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
         ((agenda "" ((org-agenda-ndays 15)))
          (todo "DELEGATED") ;; projects we are waiting on
          (todo "NEXT")
          (tags "@errands")))))

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
                      ("@phone" . ?p)
                      ("@reading" . ?r)
                      ("@summary" . ?s)
                      ("@computer" . ?l)
                      ("quantified" . ?q)
                      ("lowenergy" . ?0)
                      ("highenergy" . ?1)))
;; track time
(setq org-clock-idle-time nil)
(setq org-log-done 'time)
(setq org-clock-persist t)
(org-clock-persistence-insinuate)
(setq org-clock-report-include-clocking-task t)
(defadvice org-clock-in (after sacha activate)
  "Mark STARTED when clocked in."
  (save-excursion
    (catch 'exit
      (cond
       ((derived-mode-p 'org-agenda-mode)
        (let* ((marker (or (org-get-at-bol 'org-marker)
                           (org-agenda-error)))
               (hdmarker (or (org-get-at-bol 'org-hd-marker) marker))
               (pos (marker-position marker))
               (col (current-column))
               newhead)
          (org-with-remote-undo (marker-buffer marker)
            (with-current-buffer (marker-buffer marker)
              (widen)
              (goto-char pos)
              (org-back-to-heading t)
              (if (org-get-todo-state)
                  (org-todo "STARTED"))))))
       (t (if (org-get-todo-state)
              (org-todo "STARTED")))))))

(setq org-log-into-drawer "LOGBOOK")
(setq org-clock-into-drawer 1)


(defun rory/org-mode-ask-effort ()
  "Ask for an effort estimate when clocking in."
  (unless (org-entry-get (point) "Effort")
    (let ((effort
           (completing-read
            "Effort: "
            (org-entry-get-multivalued-property (point) "Effort"))))
      (unless (equal effort "")
        (org-set-property "Effort" effort)))))

(add-hook 'org-clock-in-prepare-hook 'rory/org-mode-ask-effort)

(provide 'personal-org)
