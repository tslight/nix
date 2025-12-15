;;; General Emacs Settings
(use-package emacs
  :config
  (load-theme 'modus-vivendi)
  (set-frame-font "Monospace 12" nil t)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (display-time)
  (display-battery-mode)
  (defun my/indent-buffer ()
    "Indent the contents of a buffer."
    (interactive)
    (indent-region (point-min) (point-max)))
  :custom
  (custom-file (expand-file-name "custom.el" user-emacs-directory))
  (display-time-format "%H:%M %a %d/%m")
  (display-time-default-load-average 'nil)
  (inhibit-startup-screen t)
  (use-short-answers t)
  (auto-save-visited-mode t)
  (disabled-command-function nil)
  (completion-styles '(initials flex partial-completion))
  (package-archives
   '(("gnu" . "https://elpa.gnu.org/packages/")
     ("melpa" . "https://melpa.org/packages/")
     ("nongnu" . "https://elpa.nongnu.org/nongnu/")))
  (use-package-enable-imenu-support t)
  :bind
  ("M-i" . my/indent-buffer)
  ("C-;" . comment-line)
  ("C-z" . zap-up-to-char))
