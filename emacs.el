(setq load-path (cons "/usr/share/emacs/site-lisp/emacs-goodies-el" load-path))

;;; color terminal
(add-to-list 'load-path "color-theme.el")
(require 'color-theme)
(eval-after-load "color-theme" '(color-theme-clarity))

;;; viper
(setq viper-mode t)
(require 'viper)

;;; imap jj to ESC
(defun viper-escape-if-next-char (c)
  (self-insert-command 1)
    (let ((next-key (read-event)))
      (if (= c next-key)
        (progn
          (delete-backward-char 1)
            (viper-mode))
            (setq unread-command-events (list next-key)))))
(defun viper-escape-if-next-char-is-j (arg)
  (interactive "p")
    (if (= arg 1)
      (viper-escape-if-next-char ?j)
        (self-insert-command arg)))
(define-key viper-insert-basic-map (kbd "j") 'viper-escape-if-next-char-is-j)

;;; org mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)
(setq org-agenda-files (list "~/org/work.org"
                             "~/org/home.org"))

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
