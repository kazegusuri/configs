(require 'auto-complete)
(require 'semantic-ia)

(defun ac-semantic-construct-candidates (tags)
   "Construct candidates from the list inside of tags."
   (apply 'append
		    (mapcar (lambda (tag)
					  (if (listp tag)
						  (let ((type (semantic-tag-type tag))
								  (class (semantic-tag-class tag))
								    (name (semantic-tag-name tag)))
							   (if (or (and (stringp type)
											(string= type "class"))
									      (eq class 'function)
										     (eq class 'variable))
								      (list (list name type class))))))
					  tags)))


(defvar ac-source-semantic-analysis nil)
(setq ac-source-semantic
  `((sigil . "b")
    (init . (lambda () (setq ac-source-semantic-analysis
                             (condition-case nil
                                             (ac-semantic-construct-candidates (semantic-fetch-tags))))))
    (candidates . (lambda ()
                    (if ac-source-semantic-analysis
                        (all-completions ac-target (mapcar 'car ac-source-semantic-analysis)))))))

(provide 'auto-complete-semantic)