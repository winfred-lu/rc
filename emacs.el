(setq load-path (cons "/usr/share/emacs/site-lisp/emacs-goodies-el" load-path))

;;; color terminal
(add-to-list 'load-path "color-theme.el")
(require 'color-theme)
(eval-after-load "color-theme" '(color-theme-clarity))

;;; viper
(setq viper-mode t)
(require 'viper)

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(column-number-mode t)
 '(menu-bar-mode nil))
(make-directory "~/.emacs.d/autosaves/" t)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
