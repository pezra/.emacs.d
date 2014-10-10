(setenv "PATH" (concat (getenv "HOME") "/.rbenv/shims:"
                       (getenv "HOME") "/.rbenv/bin:"
                       "/usr/local/bin:"
                       (getenv "PATH")))

(setq exec-path (cons (concat (getenv "HOME") "/.rbenv/shims")
                      (cons
                       (concat (getenv "HOME") "/.rbenv/bin") exec-path)))

(add-to-list 'load-path "~/.emacs.d")

(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://github.com/dimitri/el-get/raw/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(setq
 el-get-sources
 '((:name rspec-mode
       :type git
       :url "git://github.com/pezra/rspec-mode.git"
       :features rspec-mode
       :compile "rspec-mode.el")
))

(setq my:el-get-packages
      '(el-get))

(setq my:el-get-packages
      (append
       my:el-get-packages
       (loop for src in el-get-sources collect (el-get-source-name src))))


(el-get 'sync my:el-get-packages)

;;(set-default-font "-apple-inconsolata-medium-r-normal--17-130-72-72-m-130-iso10646-1")
;;(set-default-font "-apple-envy code r-medium-r-normal--20-130-72-72-m-130-iso10646-1")
(set-default-font "-apple-source code pro-medium-r-normal--22-130-72-72-m-130-iso10646-1")

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder$" . ruby-mode))

(add-to-list 'auto-mode-alist '("\\.yml\\.example$" . yaml-mode))

(require 'uniquify)

(add-hook 'after-init-hook
  (lambda () 
     (global-auto-highlight-symbol-mode t)

     (add-hook 'feature-mode-hook (lambda () (nlinum-mode t)))
     (add-hook 'ruby-mode-hook (lambda () (nlinum-mode t)))
     (ido-mode t)
     (global-auto-revert-mode t)

     (add-hook 'markdown-mode-hook (lambda () (flyspell-mode t)))
     (add-hook 'text-mode-hook (lambda () (flyspell-mode t)))
     (add-hook 'feature-mode-hook (lambda () (flyspell-mode t)))
     (add-hook 'ruby-mode-hook (lambda () (flyspell-prog-mode)))


     (load "keybindings.el")
))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector (vector "#52676f" "#c60007" "#728a05" "#a57705" "#2075c7" "#c61b6e" "#259185" "#fcf4dc"))
 '(auto-save-default t)
 '(auto-save-interval 20)
 '(auto-save-timeout 1)
 '(auto-save-visited-file-name t)
 '(blink-cursor-mode t)
 '(blink-matching-paren nil)
 '(create-lockfiles nil)
 '(css-indent-offset 2)
 '(cursor-in-non-selected-windows t)
 '(custom-enabled-themes (quote (sanityinc-tomorrow-blue)))
 '(custom-safe-themes (quote ("31bfef452bee11d19df790b82dea35a3b275142032e06c6ecdc98007bf12466c" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" default)))
 '(default-frame-alist (quote ((vertical-scroll-bars) (font . "source code pro-22"))))
 '(edit-server-default-major-mode (quote markdown-mode))
 '(edit-server-new-frame-alist (quote ((name . "Edit with Emacs FRAME") (width . 80) (height . 200) (minibuffer . t) (menu-bar-lines) (font . "source code pro-22"))))
 '(fci-rule-color "#e9e2cb")
 '(global-edit-server-edit-mode t)
 '(grep-find-ignored-directories (quote ("SCCS" "RCS" "CVS" "MCVS" ".svn" ".git" ".hg" ".bzr" "_MTN" "_darcs" "{arch}" "bower_components")))
 '(ido-create-new-buffer (quote always))
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(ido-use-filename-at-point (quote guess))
 '(indent-tabs-mode nil)
 '(initial-frame-alist (quote ((vertical-scroll-bars))))
 '(ispell-program-name "/usr/local/bin/aspell")
 '(js-indent-level 2)
 '(kill-do-not-save-duplicates t)
 '(markdown-command "/usr/local/bin/markdown")
 '(ns-antialias-text t)
 '(rspec-spec-command "rspec")
 '(rspec-use-bundler-when-possible t)
 '(rspec-use-rake-when-possible nil)
 '(safe-local-variable-values (quote ((rspec-use-opts-file-when-available) (encoding . utf-8))))
 '(save-interprogram-paste-before-kill t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(tool-bar-mode nil)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map (quote ((20 . "#c60007") (40 . "#bd3612") (60 . "#a57705") (80 . "#728a05") (100 . "#259185") (120 . "#2075c7") (140 . "#c61b6e") (160 . "#5859b7") (180 . "#c60007") (200 . "#bd3612") (220 . "#a57705") (240 . "#728a05") (260 . "#259185") (280 . "#2075c7") (300 . "#c61b6e") (320 . "#5859b7") (340 . "#c60007") (360 . "#bd3612"))))
 '(vc-annotate-very-old-color nil)
 '(word-wrap t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 220 :width normal :foundry "apple" :family "Source_Code_Pro"))))
 '(trailing-whitespace ((t (:background "Yellow" :foreground "Yellow" :inverse-video t :underline nil)))))

(eval-after-load "ruby-mode"
'(defadvice ruby-indent-line (after line-up-args activate)
  (let (indent prev-indent arg-indent)
    (save-excursion
      (back-to-indentation)
      (when (zerop (car (syntax-ppss)))
        (setq indent (current-column))
        (skip-chars-backward " \t\n")
        (when (eq ?, (char-before))
          (ruby-backward-sexp)
          (back-to-indentation)
          (setq prev-indent (current-column))
          (skip-syntax-forward "w_.")
          (skip-chars-forward " ")
          (setq arg-indent (current-column)))))
    (when prev-indent
      (let ((offset (- (current-column) indent)))
        (cond ((< indent prev-indent)
               (indent-line-to prev-indent))
              ((= indent prev-indent)
               (indent-line-to arg-indent)))
        (when (> offset 0) (forward-char offset)))))))
