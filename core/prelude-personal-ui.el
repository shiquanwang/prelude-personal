;;; prelude-personal-ui.el --- Personal UI optimizations and tweaks.
;;
;; Copyright (c) 2013 Shiquan Wang
;;
;; Author: Shiquan Wang <shiquanwang@gmail.com>
;; URL: https://github.com/shiquanwang/prelude-personal
;; Version: 0.0.1
;; Keywords: convenience

;; This file is not part of GNU Emacs.

;;; Commentary:

;; Scroll bar is disabled to work better under zenburn-theme.  Fonts
;; are set smartly for both Chinese and English.

;;; Code:

;; Disable the scroll bar. It looks weird in zenburn-theme.
;; TODO: remove the white straight line when you scroll windows X as X|Y
(scroll-bar-mode -1)

;; enlarge fringe
(if (boundp `fringe-mode)
    (fringe-mode `(8 . 0)))

;; setup font
;; from http://emacser.com/torture-emacs.html
;; check the existance of the font
(defun prelude-personal-font-exists-p (font)
  (if (null (x-list-fonts font))
      nil
    t))
;; generate font-string
(defun prelude-personal-make-font-string (font-name font-size)
  (if (and (stringp font-size)
           (equal ":" (string (elt font-size 0))))
      (format "%s%s" font-name font-size)
    (format "%s %s" font-name font-size)))
;; set fonts
(defun prelude-personal-set-font (english-fonts
                                  english-font-size
                                  chinese-fonts
                                  &optional chinese-font-size)
  "english-font-size could be set to \":pixelsize=18\" or an integer.
If set/leave chinese-font-size to nil, it will follow english-font-size"
  (require 'cl)                         ; for find if
  (let ((en-font (prelude-personal-make-font-string
                  (find-if #'prelude-personal-font-exists-p english-fonts)
                  english-font-size))
        (zh-font (font-spec
                  :family
                  (find-if #'prelude-personal-font-exists-p chinese-fonts)
                  :size
                  chinese-font-size)))
    ;; set the default English font
    ;;
    ;; the following 2 method cannot make the font settig work in new frames.
    ;; (set-default-font "Consolas:pixelsize=18")
    ;; (add-to-list 'default-frame-alist '(font . "Consolas:pixelsize=18"))
    ;; we have to use set-face-attribute
    (message "Set English Font to %s" en-font)
    (set-face-attribute
     'default nil :font en-font)
    ;; set Chinese font
    ;; do not use 'unicode charset, it will cause the english font
    ;; setting invalid
    (message "Set Chinese Font to %s" zh-font)
    (dolist (charset '(kana han symbol cjk-misc bopomofo))
      (set-fontset-font (frame-parameter nil 'font)
                        charset
                        zh-font))))
;; font size with equal width
(setq face-font-rescale-alist '(("Microsoft YaHei" . 1.1) ("WenQuanYi Micro Hei Mono" . 1.1)))
;; font setting for English and Chinese
(let ((frame (selected-frame)))
  (when (memq (framep frame) '(x w32))
    (prelude-personal-set-font
     '("Consolas" "Inconsolata" "Monaco" "DejaVu Sans Mono" "Monospace"
       "Courier New") ":pixelsize=17"
     '("Microsoft Yahei" "文泉驿等宽微米黑" "黑体" "新宋体" "宋体"))))

(provide `prelude-personal-ui)
;;; prelude-personal-ui.el ends here
