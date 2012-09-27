(setenv "PATH"
	(concat "/opt/local/bin:/opt/local/sbin:" (getenv "PATH")))

(add-to-list 'load-path "~/.emacs.d")
(load "requirable-submodules.el")


;; (tool-bar-mode nil)
(scroll-bar-mode nil)
;;(set-default-font "-apple-inconsolata-medium-r-normal--17-130-72-72-m-130-iso10646-1")
(set-default-font "-apple-envy code r-medium-r-normal--18-130-72-72-m-130-iso10646-1")

(setq mac-allow-anti-aliasing t)

(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'control)

(setq-default save-interprogram-paste-before-kill nil)
(setq-default kill-do-not-save-duplicates t)
(setq-default word-wrap t)

(setq-default cursor-type 'hollow)
(setq-default cursor-in-non-selected-windows 'hbar)
(blink-cursor-mode t)
(setq-default blink-matching-paren t)
;; (setq-default show-trailing-whitespace nil)

;; (setq-default make-backup-files nil) 
;; (setq-default auto-save-visited-file-name t)
;; (setq-default auto-save-timeout 1)

(setq-default make-backup-files nil) 
(setq-default auto-save-visited-file-name nil)
(setq-default auto-save-timeout 1)

(setq redisplay-dont-pause t)

(require 'zoom-frm)
(global-set-key (kbd "C-+") 'zoom-in)
(global-set-key (kbd "C--") 'zoom-out)

(global-set-key (kbd "C-c C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "C-%") 'query-replace)

(load "mode-compile-ext.el")

;; Uniquify
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

(setq-default indent-tabs-mode nil)

;; Color themes
(require 'color-theme)
(color-theme-initialize)
(color-theme-high-contrast) 

(require 'magit)


(require 'ido)
(ido-mode t)
(setq ido-enable-flex-matching t)

(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

(require 'scala-mode-auto)

(add-to-list 'load-path "~/.emacs.d/Enhanced-Ruby-Mode") ; must be added after any path containing old ruby-mode
(setq enh-ruby-program "/Users/pezra/.rvm/rubies/ruby-1.9.2-p290/bin/ruby") ; so that still works if ruby points to ruby1.8
(require 'ruby-mode)

(require 'rvm)
(require 'rspec-mode)

;(require 'shoulda-mode)
;(setq-default shoulda-command "ruby %o '%f'") 
;(setq-default shoulda-command "bash -lic \"cd `dirname %f`; rvm debug; echo -------; env; echo PATH: $PATH; ruby %o '%f'\"") 

(require 'coffee-mode)
(add-hook 'coffee-mode-hook 'whitespace-mode)
(setq-default coffee-tab-width 2)

(require 'eproject)
(require 'eproject-extras)

(require 'flyspell)
(add-hook 'ruby-mode-hook 'flyspell-prog-mode)
(add-hook 'css-mode-hook 'flyspell-prog-mode)

;; Cucumber support
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\\.feature$" . feature-mode))
(add-hook 'feature-mode-hook 'flyspell-mode)

;; Markdown support
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.txt$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-hook 'markdown-mode-hook 'flyspell-mode)

;; HTML mode
(add-to-list 'auto-mode-alist '("\\.dryml$" . html-mode))

;; Ruby mode
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rxml$" . ruby-mode))

(define-project-type ruby (generic)
  (look-for "Rakefile"))

(add-hook 'ruby-mode-hook 
          (lambda ()
            (make-local-variable 'paragraph-start)
            (setq paragraph-start (concat "@[[:alpha:]]+\\|" paragraph-start))
            (make-local-variable 'paragraph-separate)
            (setq paragraph-separate (concat "[ \t]*# +---+[ \t]*\\|[ \t]*# @[[:alpha:]]+[ \t]*\\|" paragraph-separate))))

(add-hook 'ruby-mode-hook (lambda () (show-paren-mode t)))
(add-hook 'ruby-mode-hook (lambda () (visual-line-mode t)))
(add-hook 'ruby-mode-hook (lambda () (subword-mode t)))

;; RNC mode
(require 'rnc-mode)
(add-to-list 'auto-mode-alist '("\\.rnc$" . rnc-mode))

;; nXML mode
(require 'nxml-mode)
(add-to-list 'auto-mode-alist '("\\.xml$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xsl$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.rng$" . nxml-mode))

;; gist
(require 'gist)

;; N3
(autoload 'n3-mode "n3-mode" "Major mode for OWL or N3 files" t)
(add-to-list 'auto-mode-alist '("\\.ttl$" . n3-mode))
(add-to-list 'auto-mode-alist '("\\.n3$" . n3-mode))
(add-to-list 'auto-mode-alist '("\\.owl$" . n3-mode))

;; Turn on font lock when in n3 mode
(add-hook 'n3-mode-hook
          'turn-on-font-lock)

;; emacs client
(server-start)
(add-hook 'server-switch-hook 
	  (lambda nil
	    (let ((server-buf (current-buffer))) 
	      (bury-buffer)
	      (switch-to-buffer-other-frame server-buf))))

(add-hook 'server-done-hook 'delete-frame)

(require 'edit-server)
(edit-server-start)
(add-hook 'edit-server-start-hook 'markdown-mode)

(require 'tts)

;;(lambda nil 
;;  (let (server-buf) (setq server-buf (current-buffer)) 
;;       (bury-buffer) (switch-to-buffer-other- frame server-buf))))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default-ispell-program-name "aspell")
 '(edit-server-new-frame-alist (quote ((name . "xEmacs TEXTAREA") (width . 80) (height . 40) (minibuffer . t) (menu-bar-lines))))
 '(ispell-program-name "aspell")
 '(js-expr-indent-offset 2)
 '(js-indent-level 2)
 '(markdown-command "maruku")
 '(rspec-use-rake-flag t)
 '(rspec-use-rvm t)
 '(safe-local-variable-values (quote ((encoding . utf-8) (ruby-compilation-executable . "ruby") (ruby-compilation-executable . "ruby1.8") (ruby-compilation-executable . "ruby1.9") (ruby-compilation-executable . "rbx") (ruby-compilation-executable . "jruby"))))
 '(server-kill-new-buffers t)
 '(shoulda-use-rvm t))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;; (require 'ansi-color)
;; (defun colorize-compilation-buffer ()
;;   (toggle-read-only)
;;   (ansi-color-apply-on-region (point-min) (point-max))
;;   (toggle-read-only))
;; (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
;;(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
;;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(global-auto-revert-mode)
;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


;;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph       
;;; Takes a multi-line paragraph and makes it into a single line of text.       
(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(global-set-key (kbd "M-Q") 'unfill-paragraph)

(dolist (command '(yank yank-pop))
  (eval `(defadvice ,command (after indent-region activate)
           (and (not current-prefix-arg)
                (member major-mode '(emacs-lisp-mode lisp-mode
                                                     clojure-mode    scheme-mode
                                                     haskell-mode    ruby-mode
                                                     rspec-mode      python-mode
                                                     c-mode          c++-mode
                                                     objc-mode       latex-mode
                                                     plain-tex-mode))
                (let ((mark-even-if-inactive transient-mark-mode))
                  (indent-region (region-beginning) (region-end) nil))))))


