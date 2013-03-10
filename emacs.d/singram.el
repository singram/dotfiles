(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "C-x a") 'mark-whole-buffer)
(global-set-key (kbd "ESC q") 'comment-region)
(global-set-key (kbd "ESC Q") 'uncomment-region)

(custom-set-variables
 '(cua-mode t nil (cua-base))
 '(column-number-mode t))

(setq initial-scratch-message nil)
(setq default-directory "~/projects/")
(fset 'yes-or-no-p 'y-or-n-p)
(put 'overwrite-mode 'disabled t) ;;Disable over-write mode!
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(setq desktop-save 'if-exists)
(desktop-save-mode 1)

;; ELPA package does not seem to load correctly. Using one in
;; subdir ;; (require 'ruby-block) ;; (ruby-block-mode t) ;; (setq
;; ruby-block-highlight-toggle t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(load-theme 'deeper-blue t)

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("org"  (mode . org-mode))
               ("mail" (or (mode . message-mode)
                           (mode . mail-mode)))
               ("toolbox"                (filename . "projects/toolbox/dev/"))
               ("cdris"                  (filename . "projects/cdris_repo/"))
               ("cdris_debug"            (filename . "projects/cdris_debug/"))
               ("cdris_test_ui"          (filename . "projects/cdris_test_ui/"))
               ("cdris_embedded_ui"      (filename . "projects/cdris_embedded_ui/"))
               ("cdris_patient_identity" (filename . "projects/cdris_patient_identity/"))
               ("cdris_mirth"            (filename . "projects/cdris_mirth/"))
               ("sandbox"                (filename . "projects/sandbox/"))
               ("gitolite"               (filename . "projects/gitolite-admin/"))
               ("dotfiles"               (filename . "dotfiles/"))
               ("general_development"
                (or
                 (mode . ruby-mode)
                 (mode . c-mode)
                 (mode . perl-mode)
                 (mode . python-mode)
                 (mode . emacs-lisp-mode)
                 ;; etc
                 ))
               ))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; save a bunch of variables to the desktop file
;; for lists specify the len of the maximal saved data also
(setq desktop-globals-to-save
      (append '((extended-command-history . 30)
                (file-name-history        . 100)
                (grep-history             . 30)
                (compile-history          . 30)
                (minibuffer-history       . 50)
                (query-replace-history    . 60)
                (read-expression-history  . 60)
                (regexp-history           . 60)
                (regexp-search-ring       . 20)
                (search-ring              . 20)
                (shell-command-history    . 50)
                tags-file-name
                register-alist)))

;; UNIX-DOS-UNIX end of line conversions
(defun dos-unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r\n" nil t) (replace-match "\n")))

(defun unix-dos ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\n" nil t) (replace-match "\r\n")))

(defun mac-unix ()
  (interactive)
  (goto-char (point-min))
  (while (search-forward "\r" nil t) (replace-match "\n")))

(defun fullscreen (&optional f)
       (interactive)
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(global-set-key [f11] 'fullscreen)

;;;;In TextMate, pasted lines are automatically indented, which is extremely time-saving. This should be fairly straightforward to implement in Emacs, but how?
;;I've found the following code, which accomplishes this beautifully:
(defadvice yank (after indent-region activate)
  (if (member major-mode
	      '(emacs-lisp-mode scheme-mode lisp-mode ruby-mode
				c-mode c++-mode objc-mode
				latex-mode plain-tex-mode))
      (let ((mark-even-if-inactive t))
	(indent-region (region-beginning) (region-end) nil))))
;;Just put the above in your .emacs file and enjoy automatic indentation of yanked text in the listed programming modes. (To add your own modes, check the value of the major-mode variable (C-h v or M-x describe-variable) and add it to the list.)
;;Note that for consistency, you should define the same advice for the yank-pop command:
(defadvice yank-pop (after indent-region activate)
  (if (member major-mode
	      '(emacs-lisp-mode scheme-mode lisp-mode ruby-mode
				c-mode c++-mode objc-mode
				latex-mode plain-tex-mode))
      (let ((mark-even-if-inactive t))
	(indent-region (region-beginning) (region-end) nil))))

(global-linum-mode 1)

;; Disable some starter-kit defaults
(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)
(setq truncate-lines nil)

;; allow selection deletion
(delete-selection-mode t)
;; make sure delete key is delete key
(global-set-key [delete] 'delete-char)

;; optional configurations
;; default language if .feature doesn't have "# language: fi"
(setq feature-default-language "fi")
;; point to cucumber languages.yml or gherkin i18n.yml to use
;; exactly the same localization your cucumber uses
(setq feature-default-i18n-file "/path/to/gherkin/gem/i18n.yml")
;; and load feature-mode
;(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

(global-set-key (kbd "C-c c") 'mode-compile)
(global-set-key (kbd "C-c k") 'mode-compile-kill)

(add-hook 'ruby-mode-hook       'esk-paredit-nonlisp)
