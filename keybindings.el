(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'hyper)

(defvar my-keys-minor-mode-map  (make-keymap) "my-keys-minor-mode keymap.")

(define-key my-keys-minor-mode-map  (kbd "H-x") 'kill-region)
(define-key my-keys-minor-mode-map  (kbd "H-c") 'kill-ring-save)
(define-key my-keys-minor-mode-map  (kbd "H-v") 'yank)
(define-key my-keys-minor-mode-map  (kbd "H-V") 'yank-pop)

(define-key my-keys-minor-mode-map  (kbd "H-z") 'undo)

(define-key my-keys-minor-mode-map  (kbd "H-g") 'keyboard-quit)
(define-key my-keys-minor-mode-map  (kbd "H-s") 'save-buffer)

;; search
(define-key my-keys-minor-mode-map  (kbd "H-f") 'isearch-forward)
(define-key my-keys-minor-mode-map  (kbd "H-g") 'isearch-repeat-forward)
(define-key my-keys-minor-mode-map  (kbd "H-S-f") 'isearch-backward)
(define-key my-keys-minor-mode-map  (kbd "H-r") 'isearch-query-replace-regexp)
(define-key my-keys-minor-mode-map  (kbd "H-F") 'rgrep)


;; buffer/file mangement
(define-key my-keys-minor-mode-map  (kbd "H-e") 'ido-switch-buffer)
(define-key my-keys-minor-mode-map  (kbd "H-N") 'ido-find-file)
(define-key my-keys-minor-mode-map  (kbd "H-w") 'ido-kill-buffer)

;; misc
(define-key my-keys-minor-mode-map  (kbd "H-S-<f8>") 'rspec-verify-single)

(define-key my-keys-minor-mode-map  (kbd "H-/") 'comment-or-uncomment-region)


;; Movement
(define-key my-keys-minor-mode-map  (kbd "H-<backspace>") 'backward-kill-word)

;; window managment
(define-key my-keys-minor-mode-map  (kbd "H-1") 'delete-other-windows)
(define-key my-keys-minor-mode-map  (kbd "H-o") 'other-window)


(global-set-key (kbd "C-c m") 'magit-status)
(global-set-key (kbd "C-c ^") 'join-line)

(define-minor-mode my-keys-minor-mode
  "A minor mode so that my key settings override annoying major modes."
  t "" my-keys-minor-mode-map )

(my-keys-minor-mode 1)

(defadvice load (after give-my-keybindings-priority)
  "Try to ensure that my keybindings always have priority."
  (if (not (eq (car (car minor-mode-map-alist)) 'my-keys-minor-mode))
      (let ((mykeys (assq 'my-keys-minor-mode minor-mode-map-alist)))
        (assq-delete-all 'my-keys-minor-mode minor-mode-map-alist)
        (add-to-list 'minor-mode-map-alist mykeys))))
(ad-activate 'load)
