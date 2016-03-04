(prelude-require-packages '(flycheck-google-cpplint google-c-style))

(eval-after-load 'flycheck
  '(progn
     (require 'flycheck-google-cpplint)
     ;; Add Google C++ Style checker.
     ;; In default, syntax checked by Clang and Cppcheck.
     (flycheck-add-next-checker 'c/c++-gcc
                                'c/c++-googlelint 'append)))

(custom-set-variables
 '(flycheck-c/c++-googlelint-executable
   (expand-file-name "cpplint.py" prelude-personal-utilities-dir)))

(custom-set-variables
 '(flycheck-googlelint-verbose "3")
 '(flycheck-googlelint-filter "-whitespace,+whitespace/braces")
 '(flycheck-googlelint-root "project/src")
 '(flycheck-googlelint-linelength "120"))


(provide 'prelude-personal-cpp)
