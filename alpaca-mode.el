;;; alpaca-mode-el -- Major mode for editing alpaca/mlfe files

;; Author: Tyler Weir <tyler.weir@gmail.com>
;; Created: 20161210
;; Keywords: alpaca mlfe major-mode

;; Copyright (C) 2016 Tyler Weir <tyler.weir@gmail.com>
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place, Suite 330, Boston,
;; MA 02111-1307 USA

;;; Commentary:
;;
;; I used this tutorial
;; http://two-wugs.net/emacs/mode-tutorial.html


;;; Code:
(defvar mlfe-mode-hook nil)
(defvar mlfe-mode-map
  (let ((mlfe-mode-map (make-keymap)))
    (define-key mlfe-mode-map "\C-j" 'newline-and-indent)
    mlfe-mode-map)
  "Keymap for MLFE major mode")

(add-to-list 'auto-mode-alist '("\\.mlfe\\'" . mlfe-mode))

(defconst mlfe-font-lock-keywords-1
  (list
   ; These define the beginning and end of each MLFE entity definition
   ; "PARTICIPANT" "END_PARTICIPANT" "MODEL" "END_MODEL" "WORKFLOW"
   ; "END_WORKFLOW" "ACTIVITY" "END_ACTIVITY" "TRANSITION"
   ; "END_TRANSITION" "APPLICATION" "END_APPLICATION" "DATA" "END_DATA"
   ; "TOOL_LIST" "END_TOOL_LIST"
   '("\\(false\\|int?\\|let\\|true\\|with\\|match\\|module\\)" . font-lock-builtin-face)
   '("\\('\\w*'\\)" . font-lock-variable-name-face))
  "Minimal highlighting expressions for MLFE mode.")

(defvar mlfe-font-lock-keywords mlfe-font-lock-keywords-1
  "Default highlighting expressions for MLFE mode.")

(defvar mlfe-mode-syntax-table
  (let ((mlfe-mode-syntax-table (make-syntax-table)))

    ; This is added so entity names with underscores can be more easily parsed
	(modify-syntax-entry ?_ "w" mlfe-mode-syntax-table)

	; Comment styles are same as C++
	(modify-syntax-entry ?/ ". 124b" mlfe-mode-syntax-table)
	(modify-syntax-entry ?* ". 23" mlfe-mode-syntax-table)
	(modify-syntax-entry ?\n "> b" mlfe-mode-syntax-table)
	mlfe-mode-syntax-table)
  "Syntax table for mlfe-mode")

(defun mlfe-mode ()
  (interactive)
  (kill-all-local-variables)
  (use-local-map mlfe-mode-map)
  (set-syntax-table mlfe-mode-syntax-table)

  ;; Set up font-lock
  (set (make-local-variable 'font-lock-defaults) '(mlfe-font-lock-keywords))

  ;; Register our indentation function
  (setq major-mode 'mlfe-mode)
  (setq mode-name "MLFE")
  (run-hooks 'mlfe-mode-hook))

;;(setq-local comment-start "{-")
;;(setq-local comment-start-skip "#+\\s-*")
;;(setq-local comment-end "-}")

(set (make-local-variable 'comment-start) "-- ")
(set (make-local-variable 'comment-padding) 0)
(set (make-local-variable 'comment-start-skip) "[-{]-[ \t]*")
(set (make-local-variable 'comment-end) "")
(set (make-local-variable 'comment-end-skip) "[ \t]*\\(-}\\|\\s>\\)")
 (setq-local parse-sexp-ignore-comments nil)

(provide 'mlfe-mode)

;;; mlfe-mode.el ends here
