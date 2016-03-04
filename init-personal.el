;;; init-personal.el --- prelude-personal's configuration entry point.
;;
;; Copyright (c) 2015 Shiquan Wang
;;
;; Author: Shiquan Wang <shiquanwang@gmail.com>
;; URL: https://github.com/shiquanwang/prelude-personal
;; Version: 0.0.1
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; This file simply sets up the default load path and requires
;; the various modules defined within Emacs Prelude Personal.

;;; Code:

(message "Prelude Personal is powering up... Be patient, Master %s!"
         current-user)

;; Define variables for directories and files like Prelude.
;; `prelude-personal-savefile-dir' is not used.
;; `prelude-personal-utilities-dir' is added.
(defvar prelude-personal-home-dir
  (expand-file-name "~")
  "The home directory of current user.")
(defvar prelude-personal-core-dir
  (expand-file-name "core" prelude-personal-dir)
  "The home of prelude-personal's core functionality.")
(defvar prelude-personal-modules-dir
  (expand-file-name "modules" prelude-personal-dir)
  "This directory houses all of the built-in prelude-personal modules.")
(defvar prelude-personal-vendor-dir
  (expand-file-name "vendor" prelude-personal-dir)
  "This directory houses packages that are not yet available in ELPA (or MELPA).")
(defvar prelude-personal-modules-file
  (expand-file-name "prelude-personal-modules.el" prelude-personal-dir)
  "This file contains a list of modules that will be loaded by prelude-personal.")
(defvar prelude-personal-utilities-dir
  (expand-file-name "utilities" prelude-personal-dir)
  "This directory houses all utilities (executables) to help Emacs.")

;; Add prelude-personal's directories to Emacs's `load-path'
(add-to-list 'load-path prelude-personal-core-dir)
(add-to-list 'load-path prelude-personal-modules-dir)
;; (add-to-list 'load-path prelude-personal-vendor-dir)
(add-to-list 'load-path prelude-personal-utilities-dir)
;; (prelude-add-subfolders-to-load-path prelude-personal-vendor-dir)
(prelude-add-subfolders-to-load-path prelude-personal-utilities-dir)

;; start Emacs server if not started
(require 'server)
;(load "server")
(unless (server-running-p) (server-start))

;; the core stuff
(require 'prelude-personal-proxy)
(require 'prelude-personal-packages)
(require 'prelude-personal-ui)
;; (require 'prelude-personal-core)
;; (require 'prelude-personal-mode)
(require 'prelude-personal-editor)
;; (require 'prelude-personal-global-keybindings)

;; windows-nt specific settings
(when (eq system-type 'windows-nt)
  (require 'prelude-personal-windows-nt))

;; the modules
(if (file-exists-p prelude-personal-modules-file)
    (load prelude-personal-modules-file)
  (message "Missing modules file %s" prelude-personal-modules-file)
  (message "You can get started by copying the bundled example file"))

(message "Prelude-Personal is ready to do thy bidding, Master %s!" current-user)

;;; init-personal.el ends here
