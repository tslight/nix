;;; Outline
(use-package outline
  :custom
  (outline-minor-mode-cycle t)
  :hook
  (emacs-lisp-mode . outline-minor-mode))

;;; Icomplete
(use-package icomplete
  :custom
  (fido-vertical-mode t)
  (icomplete-compute-delay 0)
  :bind (:map icomplete-fido-mode-map
	      ("<tab>" . icomplete-forward-completions)
	      ("<backtab>" . icomplete-backward-completions)
	      ("M-j" . exit-minibuffer)))

;;; Line Numbers
(use-package display-line-numbers
  :config
  (setq display-line-numbers 'relative)
  :hook
  (prog-mode . display-line-numbers-mode)
  (sh-script-mode . display-line-numbers-mode))

;;; Org
(use-package org
  :custom
  (org-use-speed-commands t))

;;; Dired
(use-package dired
  :custom
  (delete-by-moving-to-trash t)
  :config
  (defun my/dired-up-directory ()
    (interactive)
    (find-alternate-file ".."))
  :bind (:map dired-mode-map
	      ("b" . my/dired-up-directory)
	      ("f" . 'dired-find-alternate-file)))

;;; Recentf
(use-package recentf
  :bind
  ("C-c r" . recentf))

;;; Which Key
(use-package which-key
  :config (which-key-mode))

;;; Nix Mode
(use-package nix-mode :ensure)

;;; Whitespace
(use-package whitepace
  :hook
  (before-save . whitespace-cleanup))

;;; Code Completion
;;;; Eglot
(use-package eglot
  :hook
  (prog-mode . eglot-ensure))

;;;; Corfu
(use-package corfu :ensure
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  :hook
  (prog-mode . corfu-mode))

;;; Git
;;;; Magit
(use-package magit :ensure
  :bind*
  ("C-x g" . magit-status))
;;;; Timemachine
(use-package git-timemachine :ensure)
