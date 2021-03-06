(defun speak-region (beg end)
  "Speak the region contents."
  (interactive "r")
  (let ((buffer-file-coding-system 'utf-8-unix)
        (tmp-file (make-temp-file "emacs-speech-" nil ".txt")))
    (write-region beg end tmp-file nil)
    (message "Invoking text-to-speech...")
    (setq mac-key-speech-process
          (start-process "text-to-speech" "*Text-to-Speech Output*"
                         "/usr/bin/say" "-f" tmp-file))
    ))

(defun speak-buffer ()
  "Speak buffer contents."
  (interactive)
  (mac-key-speak-region (point-min)(point-max)))

(defun speak-paragraph ()
  "Speak the paragraph under the point"
  (interactive)
  (speak-region (save-excursion 
                  (beginning-of-paragraph)
                  (point))
                (save-excursion
                  (end-of-paragraph)
                  (point))))

(defun beginning-of-paragraph ()
  "Return the beginning of paragraph"
  (let ((beginning (re-search-backward (lines-starting-with paragraph-start) nil t)))
    (if beginning
        (goto-char beginning)
      (beginning-of-buffer))))

(defun end-of-paragraph ()
  "Returns the end of the current paragraph"
  (let ((end  (or (re-search-forward (lines-starting-with paragraph-separate) nil t)
                  (re-search-forward (lines-starting-with paragraph-start) nil t))))
    (if end
        (goto-char end)
      (end-of-buffer))))

(defun lines-starting-with (pattern)
  (concat "^\\(" pattern "\\)"))

(defun stop-speaking ()
  "Terminate the text-to-speech subprocess, if it is running."
  (interactive)
  (let ((mybuffer (and mac-key-speech-process
                       (process-buffer mac-key-speech-process))))
    (when (buffer-live-p mybuffer)
      (kill-buffer mybuffer)
      (beep))
    ))


(provide 'tts)
