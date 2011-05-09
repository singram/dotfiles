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

(require 'autopair)
(autopair-global-mode t)
(setq autopair-autowrap t)

(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

(color-theme-charcoal-black)

(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("org"  (mode . org-mode))
               ("mail" (or (mode . message-mode)
                           (mode . mail-mode)))
               ("toolbox"    (filename . "projects/toolbox/dev/"))
               ("sage2_branches" (filename . "projects/sage2/branches/"))
               ("sage2_trunk"    (filename . "projects/sage2/trunk/"))
               ("sage3_branches" (filename . "projects/sage3/branches/"))
               ("sage3"          (filename . "projects/git/sage3/"))
               ("s4"             (filename . "projects/git/s4/"))
               ("sage_dbserver"  (filename . "projects/git/sage_dbserver/"))
               ("dotfiles"       (filename . "dotfiles/"))
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
