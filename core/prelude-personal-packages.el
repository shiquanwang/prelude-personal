;;; prelude-personal-packages.el --- personal package selection.
;;
;; Copyright (c) 2013 Shiquan Wang
;;
;; Author: Shiquan Wang <shiquanwang@gmail.com>
;; URL: https://github.com/shiquanwang/prelude-personal
;; Version: 0.0.1
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Takes care of the automatic installation of all the packages required by
;; Emacs Prelude Personal.

;;; Code:

(require 'cl)
(require 'package)

(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/") t)

(package-initialize)

(defvar prelude-personal-packages
  '(
    )
  "A list of packages to ensure are installed at launch.")

(defun prelude-personal-packages-installed-p ()
  "Check if all packages in `prelude-personal-packages' are installed."
  (every #'package-installed-p prelude-personal-packages))

(defun prelude-personal-install-packages ()
  "Install all packages listed in `prelude-personal-packages'."
  (unless (prelude-personal-packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs Prelude Personal is now refreshing its package database...")
    (package-refresh-contents)
    (message "%s" " done.")
    ;; install the missing packages
    (prelude-require-packages prelude-personal-packages)))

(prelude-personal-install-packages)

(defvar prelude-personal-auto-install-alist
  '(("\\.cu\\'" cuda-mode cuda-mode)
    ))

;; build auto-install mappings
(mapc
 (lambda (entry)
   (let ((extension (car entry))
         (package (cadr entry))
         (mode (cadr (cdr entry))))
     (unless (package-installed-p package)
       (prelude-auto-install extension package mode))))
 prelude-personal-auto-install-alist)

(provide 'prelude-personal-packages)
;; Local Variables:
;; byte-compile-warnings: (not cl-functions)
;; End:

;;; prelude-personal-packages.el ends here
