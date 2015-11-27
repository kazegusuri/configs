;; load environment variables
(let ((envs '("PATH" "VIRTUAL_ENV" "GOROOT" "GOPATH" "RBENV_ROOT" "NDENV_ROOT")))
  (exec-path-from-shell-copy-envs envs))
(setenv "LANG" "ja_JP.UTF-8")
