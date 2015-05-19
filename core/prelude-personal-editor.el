;;; prelude-personal-editor.el --- enhanced personal editing experience.
;;
;; Copyright (c) 2013 Shiquan Wang
;;
;; Author: Shiquan Wang <shiquanwang@gmail.com>
;; URL: https://github.com/shiquanwang/prelude-personal
;; Version: 0.0.1
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Refinements of the core editing experience in Emacs.

;;; Code:

;; edit server for Chrome
(prelude-require-packages `(edit-server))
(require `edit-server)
(edit-server-start)

;; Linux requires ibus input method
;; Not needed when using Sougou Piyin
;; (setq ibus-python-shell-command-name "python2.7")
;; (when (eq system-type `gnu/linux)
;;   (require 'ibus)
;;   (add-hook `after-init-hook `ibus-mode-on))

;; time-stamps
;; when there's "Time-stamp: <>" in the first 10 lines of the file
(require 'time-stamp)
(add-hook `write-file-hooks `time-stamp)

(provide `prelude-personal-editor)
;;; prelude-personal-editor.el ends here
