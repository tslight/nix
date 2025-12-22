;;; General Settings
(use-package emacs
  :init
  (column-number-mode)
  (load-theme 'modus-vivendi)
  (set-frame-font "JetBrainsMono Nerd Font 13" nil t)
  (menu-bar-mode -1)
  (scroll-bar-mode -1)
  (tool-bar-mode -1)
  (tooltip-mode -1)
  (display-time)
  (display-battery-mode)
  (savehist-mode)
  (save-place-mode)
  (electric-pair-mode)
  :config
  (defun my/last-buffer ()
    "Switch back and forth between two buffers easily."
    (interactive)
    (switch-to-buffer (other-buffer (current-buffer) 1)))
  (defun my/indent-buffer ()
    "Indent the contents of a buffer."
    (interactive)
    (indent-region (point-min) (point-max)))
  :custom
  (backup-directory-alist '(("." . "~/.emacs.d/backups")))
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
  (use-package-always-defer t)
  :bind
  ("C-c b" . my/last-buffer)
  ("C-<escape>" . my/last-buffer)
  ("M-i" . my/indent-buffer)
  ("C-;" . comment-line)
  ("C-z" . zap-up-to-char))
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
  :init
  (setq display-line-numbers 'relative)
  :hook
  (prog-mode . display-line-numbers-mode)
  (sh-script-mode . display-line-numbers-mode))
;;; Org
(use-package org :custom (org-use-speed-commands t))
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
(use-package recentf :bind ("C-c r" . recentf))
;;; Which Key
(use-package which-key :config (which-key-mode))
;;; Whitespace
(use-package whitepace :hook (before-save . whitespace-cleanup))
;;; Eglot
(use-package eglot :hook (prog-mode . eglot-ensure))
;;; Ensures
;;;; Nix Mode
(use-package nix-mode :ensure)
;;;; Vundo
(use-package vundo :ensure :bind ("C-c u" . vundo))
;;;; Corfu
(use-package corfu :ensure
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  :hook
  (prog-mode . corfu-mode))
;;;; Magit
(use-package magit :ensure :bind* ("C-x g" . magit-status))
;;;; Timemachine
(use-package git-timemachine :ensure)
;;;; Markdown
(use-package markdown-mode :ensure)
(use-package markdown-ts-mode :ensure)
;;;; Lua
(use-package lua-mode :ensure)
(use-package lua-ts-mode :ensure)
;;;; Copilot
(use-package copilot :ensure)
(use-package copilot-chat :ensure)
;;;; KDL Mode
(use-package kdl-mode :ensure)
;;;; Vterm
(use-package vterm :ensure)
