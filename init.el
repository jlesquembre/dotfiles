(require 'package)

;; optional. makes unpure packages archives unavailable
(setq package-archives nil)

(setq package-enable-at-startup nil)
(package-initialize)

; == Theme ==
(load-theme 'zerodark t)

(require 'evil)
(evil-mode 1)


; == Preferences ==
(setq-default indent-tabs-mode nil)     ; Always use spaces for indentation.
(setq-default tab-width 2)              ; https://www.emacswiki.org/emacs/IndentationBasics
(setq-default c-basic-offset 2)
(setq-default require-final-newline t)  ; Always be sure there is a newline at the end of the file.

;(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

; On save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

; https://www.emacswiki.org/emacs/DeletingWhitespace
(defun delete-trailing-blank-lines ()
  "Deletes all blank lines at the end of the file."
  (interactive)
  (save-excursion
    (save-restriction
      (widen)
      (goto-char (point-max))
      (delete-blank-lines))))

(add-hook 'before-save-hook 'delete-trailing-blank-lines)
