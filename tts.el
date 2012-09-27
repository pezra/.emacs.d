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