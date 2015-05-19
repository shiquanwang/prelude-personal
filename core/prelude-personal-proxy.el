;;; prelude-personal-proxy.el --- Setup proxy and helper functions.
;;
;; Copyright (c) 2015 Shiquan Wang
;;
;; Author: Shiquan Wang <shiquanwang@gmail.com>
;; URL: https://github.com/shiquanwang/prelude-personal
;; Version: 0.0.1
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Setup proxy and define helper functions.

;;; Code:

;; TODO:
;; []automatically setup proxy from IE
;; []automatically setup proxy according to IP

;; variables for CNTLM based proxy
(defvar prelude-personal-proxy-cntlm-port 3188
  "The port of CNTLM proxy.")
(defvar prelude-personal-proxy-cntlm-url
  (concat "localhost:"
          (number-to-string prelude-personal-proxy-cntlm-port))
  "URL of CNTLM proxy.")

;; setup proxy from CNTLM
(defun prelude-personal-proxy-cntlm ()
  "Set up proxy from CNTLM."
  (interactive)
  (setq url-proxy-services
        `(("http" . ,prelude-personal-proxy-cntlm-url)
          ("ftp"  . ,prelude-personal-proxy-cntlm-url)
          )))

;; remove proxy settings
(defun prelude-personal-proxy-nil ()
  "Remove proxy settings."
  (interactive)
  (setq url-proxy-services nil))

(provide 'prelude-personal-proxy)
;;; prelude-personal-proxy.el ends here
