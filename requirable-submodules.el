(defun string/starts-with (s arg)
  "returns non-nil if string S starts with ARG.  Else nil."
  (cond ((>= (length s) (length arg))
         (string-equal (substring s 0 (length arg)) arg))
        (t nil)))

(defun directory-dirs (dir &optional exclude-hidden)
  "Find directories in DIR."
  (unless (file-directory-p dir)
    (error "Not a directory `%s'" dir))
  (let ((dir (directory-file-name dir))
        (dirs '())
        (files (directory-files dir nil nil nil)))
    (dolist (file files)
      (unless (or (member file '("." ".."))
                  (and exclude-hidden
                       (string/starts-with file ".")))
        (let ((file (concat dir "/" file)))
          (when (file-directory-p file)
            (setq dirs (push file dirs))))))
    dirs))

;; Add all subdirectories of .emacs.d to load path
(mapc (lambda (dir) (add-to-ordered-list 'load-path  dir))
      (directory-dirs "~/.emacs.d" t))