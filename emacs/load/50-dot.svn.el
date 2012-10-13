;; svn
(require 'dsvn)

(defun starts-with-p (string1 string2)
 (string= (substring string1 0 (min (length string1) (length
string2))) string2))

(defun dont-backup-commit-files-p (filename)
 (let ((filename-part (file-name-nondirectory filename)))
   (if (or (starts-with-p filename-part "svn-commit")
           (starts-with-p filename-part "bzr_log"))
       nil
     (normal-backup-enable-predicate filename))))

(setq backup-enable-predicate 'dont-backup-commit-files-p)

;; avoid msg "symbolic link to SVN-controlled source file"
(setq vc-follow-symlinks t)
