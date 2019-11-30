;;Default window size
(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
	    '(
	      (tool-bar-lines . 0)
	      (width . 80)
	      (height . 40)))
      (setq default-frame-alist
	    '(
	      (tool-bar-lines . 0)
	      (width . 80)
	      (height . 40))))
      (progn
	(setq initial-frame-alist '( (tool-bar-lines . 0)))
	(setq default-frame-alist '( (tool-bar-lines . 0)))))
  

;;Disable tool bar
(tool-bar-mode -1)

;;Disable menu bar
(menu-bar-mode -1)

;;Disable scroll bar
(scroll-bar-mode -1)

;;Enable line numbers on all buffers
(global-linum-mode 1)

;;Switch between files and buffers easily
(ido-mode 1)
(setq ido-enable-flex-matching t)

;;Disable splash
(setq inhibit-startup-message t)
inhibit-startup-echo-area-message

;;Auto indent
(define-key global-map (kbd "RET") 'newline-and-indent)

;;Disable bell
(setq ring-bell-function 'ignore)

;;Line highlighting
(global-hl-line-mode t)

;;Desktop save mode
(desktop-save-mode 1)

;;Enable company-mode for all buffers
(add-hook 'after-init-hook 'global-company-mode)

;;Rename open buffer file name
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

;;init shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

(use-package which-key
	      :ensure t
	      :init
	      (which-key-mode))

;;lsp configs
(use-package lsp-mode
  :commands lsp
  :ensure t
  :diminish lsp-mode
  :hook
  (elixir-mode . lsp)
  :init
  (add-to-list 'exec-path "/Users/eddiefowler/elixir-ls"))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

(require 'flycheck-mix)
(flycheck-mix-setup)

;;(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

(use-package lsp-ui
 :after (lsp-mode)
 :ensure t)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)

;;(use-package lsp-ui :commands lsp-ui-mode)
(use-package company-lsp :commands company-lsp)
;(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
;(remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)

;;(add-hook 'lsp-mode-hook 'lsp-ui-mode)

(set 'lsp-print-io t)
(set 'lsp-auto-configure t)

;;Set Scheme
(set-variable (quote scheme-program-name) "/usr/local/Cellar/mit-scheme/9.2_1/bin/mit-scheme")

;;Speedbar
(use-package speedbar)

;;Disable semi-colon warning
(setq js2-strict-missing-semi-warning nil)

;;run elixir mix format on save
;;(add-hook 'elixir-mode-hook
;;	  (lambda () (add-hook 'before-save-hook 'elixir-format nil t)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
   (quote
    (neotree flycheck-mix flycheck-color-mode-line company-lsp lsp-ui lsp-mode web-mode json-mode js2-mode bug-hunter lsp-elixir exec-path-from-shell company vue-mode which-key spacemacs-theme use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "nil" :family "Menlo")))))
(put 'upcase-region 'disabled nil)
(put 'erase-buffer 'disabled nil)
