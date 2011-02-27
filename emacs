(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "Grey15" :foreground "Grey" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 99 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(display-time-mode t)
 '(fringe-mode (quote (nil . 0)) nil (fringe))
 '(rails-ws:default-server-type "thin")
 '(safe-local-variable-values (quote ((Coding . iso-2022-7bit))))
 '(save-place t nil (saveplace))
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify)))

; Should use system clipboard for copy and paste... I think
;;(setq x-select-enable-clipboard t)
;; (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour
(setq x-select-enable-clipboard t) ; as above
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)

;; Title bar shows name of current buffer.
(setq frame-title-format '("emacs: %*%+ %b"))
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)
(setq initial-scratch-message nil)
(setq default-directory "~/projects/")
(fset 'yes-or-no-p 'y-or-n-p)
(put 'overwrite-mode 'disabled t) ;;Disable over-write mode!
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

(global-set-key "\M-g" 'goto-line)
(global-set-key (kbd "C-x a") 'mark-whole-buffer)
(global-set-key (kbd "ESC q") 'comment-region)
(global-set-key (kbd "ESC Q") 'uncomment-region)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun set-newline-and-indent ()
  (local-set-key (kbd "RET") 'newline-and-indent))

(add-to-list 'load-path "~/.emacs.d")

(require 'find-recursive)
(require 'snippet)

;; css
(add-hook 'css-mode-hook
	  (lambda()
	    (local-set-key (kbd "<return>") 'newline-and-indent)
	    ))

;; Ruby mode specific config
(add-hook 'ruby-mode-hook 'set-newline-and-indent) ;; Auto indent as you type

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))

(require 'autopair)
(autopair-global-mode t)
(setq autopair-autowrap t)

(require 'rvm)
(rvm-use-default) ;; use rvm’s default ruby for the current Emacs session

(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;; Rails
;(setq load-path (cons "~/.emacs.d/emacs-rails" load-path))
;(require 'rails)
(require 'mode-compile)
(require 'rspec-mode)

(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)


(add-to-list 'load-path "~/.emacs.d/mmm-mode-0.4.8")
(require 'mmm-mode)
(require 'mmm-auto)
(setq mmm-global-mode 'maybe)
(setq mmm-submode-decoration-level 2)
(set-face-background 'mmm-output-submode-face "#00688b")
(set-face-background 'mmm-code-submode-face "#104e8b")
(set-face-background 'mmm-comment-submode-face "DarkOliveGreen")
(mmm-add-classes
 '((erb-code
    :submode ruby-mode
    :match-face (("<%#" . mmm-comment-submode-face)
                 ("<%=" . mmm-output-submode-face)
                 ("<%" . mmm-code-submode-face))
    :front ""
    :insert ((?% erb-code nil @ "" @)
             (?# erb-comment nil @ "" @)

             (?= erb-expression nil @ "" @)))))
(add-hook 'html-mode-hook
          (lambda ()
            (local-set-key [f8] 'mmm-parse-buffer)
            (setq mmm-classes '(erb-code))
            (mmm-mode)))

;; Yaml Mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("org"  (mode . org-mode))
               ("mail" (or (mode . message-mode)
                           (mode . mail-mode)
                 ))
               ("toolbox    "    (filename . "projects/toolbox/dev/"))
               ("trunk_sage2"    (filename . "projects/sage2/trunk/"))
               ("trunk_dbserver" (filename . "projects/sage_dbserver/trunk/"))
               ("trunk_sage3"    (filename . "projects/sage3/trunk/"))
               ("trunk_s4"       (filename . "projects/s4/trunk/"))
               ("2_16_0_sage3"   (filename . "projects/sage3/branches/Release_2.16.0/"))
               ("2_16_0_s4"      (filename . "projects/s4/branches/Release_2.16.0/"))
               ("general_development" ;; prog stuff not already in MyProjectX
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


(defun fullscreen (&optional f)
       (interactive)
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
       (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
	    		 '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(global-set-key [f11] 'fullscreen)

(require 'color-theme)
(color-theme-charcoal-black)

;; save a list of open files in ~/.emacs.desktop
;; save the desktop file automatically if it already exists
(setq desktop-save 'if-exists)
(desktop-save-mode 1)

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
;; Use M-x desktop-save once to save the desktop.
;; When it exists, Emacs updates it on every exit.

;; Centering code stolen from somewhere and restolen from
;; http://www.chrislott.org/geek/emacs/dotemacs.html
;; centers the screen around a line...
(global-set-key [(control l)] 'centerer)
(defun centerer ()
  "Repositions current line: once middle, twice top, thrice bottom"
  (interactive)
  (cond ((eq last-command 'centerer2) ; 3 times pressed = bottom
	 (recenter -1))
	((eq last-command 'centerer1) ; 2 times pressed = top
	 (recenter 0)
	 (setq this-command 'centerer2))
	(t ; 1 time pressed = middle
	 (recenter)
	 (setq this-command 'centerer1))))

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

