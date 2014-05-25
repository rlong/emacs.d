;
; version: 2014-05-06
;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; load groovy support 
;;
;;


(load "~/.emacs.d/emacs-groovy-mode-init.el")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; print current date / current time 
;;
;; reference: http://stackoverflow.com/questions/251908/how-can-i-insert-current-date-and-time-into-a-file-using-emacs


;; current date

; old-format: "%a %b %d %H:%M:%S %Z %Y"
(defvar insert-current-date-format "%Y-%m-%d"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defun insert-current-date ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
       ;(insert "==========\n")
       ;(insert (let () (comment-start)))
       (insert (format-time-string insert-current-date-format (current-time)))
       ;(insert "\n")
       )


(global-set-key "\C-c\C-i\C-c\C-d" 'insert-current-date)

;; current time


; old-format: "%a %H:%M:%S"
(defvar insert-current-time-format "%H:%M "
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string insert-current-time-format (current-time)))
       ;(insert "\n")
       )


(global-set-key "\C-c\C-i\C-c\C-t" 'insert-current-time)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 
;; ascii table support 
;;
;; reference: http://www.emacswiki.org/AsciiTable



(defun ascii-table ()
    "Display basic ASCII table (0 thru 128)."
    (interactive)
    (setq buffer-read-only nil)        ;; Not need to edit the content, just read mode (added)
    (local-set-key "q" 'bury-buffer)   ;; Nice to have the option to bury the buffer (added)
    (switch-to-buffer "*ASCII*")
    (erase-buffer)
    (setq lower32 '("nul" "soh" "stx" "etx" "eot" "enq" "ack" "bel"
		    "bs" "ht" "nl" "vt" "np" "cr" "so" "si"
		    "dle" "dc1" "dc2" "dc3" "dc4" "nak" "syn" "etb"
		    "can" "em" "sub" "esc" "fs" "gs" "rs" "us"
		    ))
    (save-excursion (let ((i -1))
      (insert "ASCII characters 0 thru 127.\n\n")
      (insert " Hex  Dec  Char|  Hex  Dec  Char|  Hex  Dec  Char|  Hex  Dec  Char\n")
      (while (< i 31)
        (insert (format "%4x %4d %4s | %4x %4d %4s | %4x %4d %4s | %4x %4d %4s\n"
                        (setq i (+ 1  i)) i (elt lower32 i)
                        (setq i (+ 32 i)) i (single-key-description i)
                        (setq i (+ 32 i)) i (single-key-description i)
                        (setq i (+ 32 i)) i (single-key-description i)))
        (setq i (- i 96))))))

(global-set-key "\C-c\C-a\C-t" 'ascii-table)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; vvv http://stackoverflow.com/questions/9878623/how-can-i-disable-auto-fill-mode-in-emacs

(auto-fill-mode -1)
(remove-hook 'text-mode-hook #'turn-on-auto-fill)

; ^^^ http://stackoverflow.com/questions/9878623/how-can-i-disable-auto-fill-mode-in-emacs

; vvv http://stackoverflow.com/questions/1850292/emacs-23-1-and-mac-os-x-problem-with-files-drag-and-drop


(setq ns-pop-up-frames nil)

; vvv http://stackoverflow.com/questions/1850292/emacs-23-1-and-mac-os-x-problem-with-files-drag-and-drop


; vvv http://www.gnu.org/software/emacs/emacs-lisp-intro/html_node/Keybindings.html


;;; Rebind `C-x C-b' from `buffer-list` to  `buffer-menu'
(global-set-key "\C-x\C-b" 'buffer-menu)


; ^^^  http://www.gnu.org/software/emacs/emacs-lisp-intro/html_node/Keybindings.html

; vvv http://stackoverflow.com/questions/916797/emacs-global-set-key-to-c-tab


(global-set-key (kbd "<C-tab>") 'previous-buffer)
(global-set-key (kbd "<C-S-tab>") 'next-buffer)

; ^^^ http://stackoverflow.com/questions/916797/emacs-global-set-key-to-c-tab


; enable CUA mode ...
; vvv http://www.emacswiki.org/CuaMode

(cua-mode t)
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t) ;; Standard Windows behaviour

; ^^^ http://www.emacswiki.org/CuaMode


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
