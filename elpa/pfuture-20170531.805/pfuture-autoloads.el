;;; pfuture-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "pfuture" "pfuture.el" (22943 19940 315935
;;;;;;  545000))
;;; Generated autoloads from pfuture.el

(autoload 'pfuture-new "pfuture" "\
Create a new pfuture with process ARGS.
This will return a struct (as created by `cl-defstruct') with 2 fields:
'process' which is the process object that will be started and 'result', where
the process will be writing its output.

Note that ARGS must be a *list* of strings as demanded by `make-process'.
In other words
This is wrong: (pfuture-new \"git status\")
This is right: (pfuture-new \"git\" \"status\")

\(fn &rest ARGS)" nil nil)

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; pfuture-autoloads.el ends here
