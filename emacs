;;; Emacs Load Path
(setq load-path (cons "~/emacs" load-path))
(setq load-path (cons "~/emacs/color-theme-6.6.0" load-path))
;(setq load-path (cons "/usr/share/emacs/site-lisp/emacs-goodies-el" load-path))
;(progn (cd "~/emacs") (normal-top-level-add-subdirs-to-load-path))

;;; color terminal
(if (= 21 emacs-major-version)
  (load "term/xterm-256color"))
(add-to-list 'load-path "color-theme.el")
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-tango)))

;;; colorful shell mode
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)

;;; cc mode configurations
(require 'cc-mode)
(global-font-lock-mode 1)
(add-hook 'c-mode-common-hook
	  '(lambda ()
	     (require 'xcscope)))
(setq c-default-style '((java-mode . "java")
			(awk-mode . "awk")
			(other . "linux")))
(defun my-make-CR-do-indent ()
  (define-key c-mode-base-map "\C-m" 'c-context-line-break))
(add-hook 'c-initialization-hook 'my-make-CR-do-indent)

;;; etags select
;(require 'etags-select)
(autoload 'etags-select-find-tag-at-point "etags-select"
  "for etags-select")
(global-set-key "\C-]" 'etags-select-find-tag-at-point)
;(add-hook 'etags-select-mode-hook
;  (lambda()
;  (define-key etags-select-mode-map "j" 'etags-select-next-tag)
;  (define-key etags-select-mode-map "k" 'etags-select-previous-tag)
;  (define-key etags-select-mode-map [(return)] 'etags-select-goto-tag)
;  )
;)
(defun jds-find-tags-file ()
  "recursively searches each parent directory for a file named 'TAGS' and returns the
path to that file or nil if a tags file is not found. Returns nil if the buffer is
not visiting a file"
  (progn
      (defun find-tags-file-r (path)
	 "find the tags file from the parent directories"
	 (let* ((parent (file-name-directory path))
		(possible-tags-file (concat parent "TAGS")))
	   (cond
	     ((file-exists-p possible-tags-file) (throw 'found-it possible-tags-file))
	     ((string= "/TAGS" possible-tags-file) (error "no tags file found"))
	     (t (find-tags-file-r (directory-file-name parent))))))

    (if (buffer-file-name)
	(catch 'found-it 
	  (find-tags-file-r (buffer-file-name)))
	(error "buffer is not visiting a file"))))
(defun jds-set-tags-file-path ()
  "calls `jds-find-tags-file' to recursively search up the directory tree to find
a file named 'TAGS'. If found, set 'tags-table-list' with that path as an argument
otherwise raises an error."
  (interactive)
  (setq tags-table-list (list (jds-find-tags-file))))
(add-hook 'emacs-startup-hook 
	  '(lambda () (jds-set-tags-file-path)))

;;; vip mode or vi keys
(setq viper-mode t)                ; enable Viper at load time
(setq viper-ex-style-editing nil)  ; can backspace past start of insert / line
(require 'viper)                   ; load Viper
(setq vimpulse-experimental nil)   ; don't load bleeding edge code (see 6. installation instruction)
(require 'vimpulse)                ; load Vimpulse
(setq woman-use-own-frame nil)     ; don't create new frame for manpages
(setq woman-use-topic-at-point t)  ; don't prompt upon K key (manpage display)

(setq vimpulse-movement-map (make-sparse-keymap))
(vimpulse-set-movement-keys-for-map vimpulse-movement-map)
(viper-modify-major-mode 'dired-mode 'emacs-state vimpulse-movement-map) 
(viper-modify-major-mode 'help-mode 'emacs-state vimpulse-movement-map)
;(viper-modify-major-mode 'etags-select-mode 'emacs-state vimpulse-movement-map)

(define-key viper-vi-global-user-map ",c"  'comment-region)
(define-key viper-vi-global-user-map ",u"  'uncomment-region)

(add-hook 'custom-mode-hook
  (lambda()
  (define-key custom-mode-map "j" 'next-line)
  (define-key custom-mode-map "k" 'previous-line)
  (define-key custom-mode-map "l" 'viper-forward-char)
  (define-key custom-mode-map "h" 'viper-backward-char)
  )
)

;;; outline mode (with date)
(add-hook 'outline-mode-hook
	  '(lambda ()
	     (setq outline-regexp "\\([0-9]+-[0-9]+-[0-9]\\|\\*\\| -\\|  -\\)")
	     (setq outline-level
		   (lambda ()
		     (cond ((looking-at "[0-9]+-[0-9]+-[0-9]") 1)
			   ((looking-at "\\*") 2)
			   ((looking-at " -") 3)
			   ((looking-at "  -") 4)
			   (t 1000))))))
(setq outline-font-lock-keywords
  '(;; Highlight headings according to the level.
    (eval . (list (concat "^" outline-regexp ".+")
                0 '(or (cdr (assq (outline-font-lock-level)
                                  '((1 . font-lock-string-face)
				    (2 . font-lock-function-name-face)
                                    (3 . font-lock-type-face)
                                    (4 . font-lock-variable-name-face)
				    (5 . font-lock-comment-face)
				    (6 . font-lock-comment-face)
				    (7 . font-lock-comment-face)
				    (8 . font-lock-comment-face))))
                       font-lock-warning-face)
                nil t))))

;;; folding
;(add-to-list 'load-path "folding.el")
;(load "folding" 'nomessage 'noerror)
;(folding-mode-add-find-file-hook)
;(folding-add-to-marks-list
;  'c-mode "/* {{{ " "/* }}} */" " */" t)

;(global-set-key (kbd "\C-x\C-b") 'buffer-menu)
;(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-x\C-b" 'bs-show)

(require 'ido)
(ido-mode t)

;;; customizations
(menu-bar-mode -1)
(setq scroll-step 1)
(column-number-mode 1)
(setq make-backup-files nil)

;;; scripts
(autoload 'ascii-table "ascii-table" "Show ASCII table." t)


