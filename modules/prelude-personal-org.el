;;; prelude-personal-org.el --- org-mode configuration.
;;
;; Copyright (c) 2014 Shiquan Wang
;;
;; Author: Shiquan Wang <shiquanwang@gmail.com>
;; URL: https://github.com/shiquanwang/prelude-personal
;; Version: 0.0.1
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Configurations for org-mode.

;;; Code:

(prelude-require-packages '(bbdb org org-plus-contrib smex))

(setq org-plantuml-jar-path
      (expand-file-name "~/.emacs.d/personal/utilities/plantuml.8045.jar"))

(add-hook 'org-babel-after-execute-hook 'bh/display-inline-images 'append)

                                        ; Make babel results blocks lowercase
(setq org-babel-results-keyword "results")

(defun bh/display-inline-images ()
  (condition-case nil
      (org-display-inline-images)
    (error nil)))

(org-babel-do-load-languages
 (quote org-babel-load-languages)
 (quote ((emacs-lisp . t)
         (dot . t)
         (ditaa . t)
         (R . t)
         (python . t)
         (ruby . t)
         (gnuplot . t)
         (clojure . t)
         (sh . t)
         (ledger . t)
         (org . t)
         (plantuml . t)
         (latex . t))))

(add-to-list 'org-src-lang-modes (quote ("plantuml" . fundamental)))

;; Enable abbrev-mode
(add-hook 'org-mode-hook (lambda () (abbrev-mode 1)))

;; Skeletons
;;
;; sblk - Generic block #+begin_FOO .. #+end_FOO
(define-skeleton skel-org-block
  "Insert an org block, querying for type."
  "Type: "
  "#+begin_" str "\n"
  _ - \n
  "#+end_" str "\n")

(define-abbrev org-mode-abbrev-table "sblk" "" 'skel-org-block)

;; splantuml - PlantUML Source block
(define-skeleton skel-org-block-plantuml
  "Insert a org plantuml block, querying for filename."
  "File (no extension): "
  "#+begin_src plantuml :file " str ".png :cache yes\n"
  _ - \n
  "#+end_src\n")

(define-abbrev org-mode-abbrev-table "splantuml" "" 'skel-org-block-plantuml)

(define-skeleton skel-org-block-plantuml-activity
  "Insert a org plantuml block, querying for filename."
  "File (no extension): "
  "#+begin_src plantuml :file " str "-act.png :cache yes :tangle " str "-act.txt\n"
  (bh/plantuml-reset-counters)
  "@startuml\n"
  "skinparam activity {\n"
  "BackgroundColor<<New>> Cyan\n"
  "}\n\n"
  "title " str " - \n"
  "note left: " str "\n"
  "(*) --> \"" str "\"\n"
  "--> (*)\n"
  _ - \n
  "@enduml\n"
  "#+end_src\n")

(defvar bh/plantuml-if-count 0)

(defun bh/plantuml-if ()
  (incf bh/plantuml-if-count)
  (number-to-string bh/plantuml-if-count))

(defvar bh/plantuml-loop-count 0)

(defun bh/plantuml-loop ()
  (incf bh/plantuml-loop-count)
  (number-to-string bh/plantuml-loop-count))

(defun bh/plantuml-reset-counters ()
  (setq bh/plantuml-if-count 0
        bh/plantuml-loop-count 0)
  "")

(define-abbrev org-mode-abbrev-table "sact" "" 'skel-org-block-plantuml-activity)

(define-skeleton skel-org-block-plantuml-activity-if
  "Insert a org plantuml block activity if statement"
  ""
  "if \"\" then\n"
  "  -> [condition] ==IF" (setq ifn (bh/plantuml-if)) "==\n"
  "  --> ==IF" ifn "M1==\n"
  "  -left-> ==IF" ifn "M2==\n"
  "else\n"
  "end if\n"
  "--> ==IF" ifn "M2==")

(define-abbrev org-mode-abbrev-table "sif" "" 'skel-org-block-plantuml-activity-if)

(define-skeleton skel-org-block-plantuml-activity-for
  "Insert a org plantuml block activity for statement"
  "Loop for each: "
  "--> ==LOOP" (setq loopn (bh/plantuml-loop)) "==\n"
  "note left: Loop" loopn ": For each " str "\n"
  "--> ==ENDLOOP" loopn "==\n"
  "note left: Loop" loopn ": End for each " str "\n" )

(define-abbrev org-mode-abbrev-table "sfor" "" 'skel-org-block-plantuml-activity-for)

(define-skeleton skel-org-block-plantuml-sequence
  "Insert a org plantuml activity diagram block, querying for filename."
  "File appends (no extension): "
  "#+begin_src plantuml :file " str "-seq.png :cache yes :tangle " str "-seq.txt\n"
  "@startuml\n"
  "title " str " - \n"
  "actor CSR as \"Customer Service Representative\"\n"
  "participant CSMO as \"CSM Online\"\n"
  "participant CSMU as \"CSM Unix\"\n"
  "participant NRIS\n"
  "actor Customer"
  _ - \n
  "@enduml\n"
  "#+end_src\n")

(define-abbrev org-mode-abbrev-table "sseq" "" 'skel-org-block-plantuml-sequence)

;; sdot - Graphviz DOT block
(define-skeleton skel-org-block-dot
  "Insert a org graphviz dot block, querying for filename."
  "File (no extension): "
  "#+begin_src dot :file " str ".png :cache yes :cmdline -Kdot -Tpng\n"
  "graph G {\n"
  _ - \n
  "}\n"
  "#+end_src\n")

(define-abbrev org-mode-abbrev-table "sdot" "" 'skel-org-block-dot)

;; sditaa - Ditaa source block
(define-skeleton skel-org-block-ditaa
  "Insert a org ditaa block, querying for filename."
  "File (no extension): "
  "#+begin_src ditaa :file " str ".png :cache yes\n"
  _ - \n
  "#+end_src\n")

(define-abbrev org-mode-abbrev-table "sditaa" "" 'skel-org-block-ditaa)

;; selisp - Emacs Lisp source block
(define-skeleton skel-org-block-elisp
  "Insert a org emacs-lisp block"
  ""
  "#+begin_src emacs-lisp\n"
  _ - \n
  "#+end_src\n")

(define-abbrev org-mode-abbrev-table "selisp" "" 'skel-org-block-elisp)


(provide 'prelude-personal-org)
;;; prelude-personal-org.el ends here
