;;; my-evil-config.el --- My evil-mode emacs config -*- lexical-binding: t; -*-

;; Loading other files
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'load-path user-emacs-directory)

(require 'keybinds)
(require 'my-functions)
(require 'my-faces)
(require 'treesit-highlight)

;; major modes
(add-to-list 'major-mode-remap-alist '(java-mode . java-ts-mode) t)
(add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode) t)

(use-package js2-mode
  :mode "\\.js\\'"
  :config
  (add-to-list 'major-mode-remap-alist '(js-ts-mode . js2-mode) t)
  (add-to-list 'major-mode-remap-alist '(javascript-mode . js2-mode) t))
(use-package zig-mode
  :mode "\\.zig\\'"
  :custom
  (zig-format-on-save nil)
  :config
  (zig-format-on-save-mode -1))
(use-package arduino-mode)
(add-to-list 'auto-mode-alist '("\\.lua\\'" . lua-mode))
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ino\\'" . arduino-mode))
(add-to-list 'auto-mode-alist '("\\.c3\\'" . c3-ts-mode))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(zig-mode . ("zls")))
  (add-to-list 'eglot-server-programs
               '((python-mode python-ts-mode) . ("basedpyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs
               '(gdscript-ts-mode . ("127.0.0.1" 6005))))
;; (add-to-list 'treesit-language-source-alist
;;              '(c3 "https://github.com/c3lang/tree-sitter-c3" "v0.8.3"))
;; (add-to-list 'treesit-language-source-alist
;;              '(gdscript "https://github.com/PrestonKnopp/tree-sitter-gdscript"))
(add-to-list 'load-path "~/.emacs.d/external-packages/c3-ts-mode/")
(require 'c3-ts-mode)

;; eglot
(require 'eglot-java)
(add-hook 'java-ts-mode-hook #'eglot-java-mode)

(use-package eglot
  :hook ((js2-mode . eglot-ensure)
;;          (typescript-mode . eglot-ensure)
;;          (python-ts-mode . eglot-ensure)
;;          (arduino-mode . eglot-ensure)
         (zig-mode . eglot-ensure)
         (java-mode . eglot-ensure)
          ;; (c-ts-mode . eglot-ensure)
          )
  )

(use-package treesit-auto
  :config
  ;; (setq treesit-auto-install 'prompt)
  (setq treesit-auto-install t)
  (setq treesit-font-lock-level 4)
  (setq treesit-auto-langs nil)
  (treesit-auto-add-to-auto-mode-alist '(java c))
  (global-treesit-auto-mode))
(add-hook 'treesit-auto-mode-hook #'treesit-inspect-mode)
;; folding hooks
(add-hook 'emacs-lisp-mode-hook #'outline-minor-mode)
(add-hook 'lisp-interaction-mode-hook #'hs-minor-mode) ; scratch
(add-hook 'lisp-mode-hook #'outline-minor-mode)
(add-hook 'conf-mode-hook #'outline-minor-mode)
(add-hook 'markdown-mode-hook #'outline-minor-mode)
(add-hook 'diff-mode-hook #'outline-minor-mode)

;; Systems and General Purpose
(add-hook 'zig-mode-hook #'hs-minor-mode)
(add-hook 'c-mode-hook #'hs-minor-mode)
(add-hook 'c++-mode-hook #'hs-minor-mode)
(add-hook 'java-mode-hook #'hs-minor-mode)
(add-hook 'rust-mode-hook #'hs-minor-mode)
(add-hook 'go-mode-hook #'hs-minor-mode)
(add-hook 'ruby-mode-hook #'hs-minor-mode)
(add-hook 'php-mode-hook #'hs-minor-mode)
(add-hook 'perl-mode-hook #'hs-minor-mode)

;; Web and Frontend
(add-hook 'js-mode-hook #'hs-minor-mode)
(add-hook 'typescript-mode-hook #'hs-minor-mode)
(add-hook 'css-mode-hook #'hs-minor-mode)

;; Scripting, Data, and Infrastructure
(add-hook 'sh-mode-hook #'hs-minor-mode) ; for bash/shell scripts
(add-hook 'json-mode-hook #'hs-minor-mode)
(add-hook 'lua-mode-hook #'hs-minor-mode)
(add-hook 'nxml-mode-hook #'hs-minor-mode)
(add-hook 'html-mode-hook #'hs-minor-mode)  ;; mhtml and html

;; auto insert stuff
(auto-insert-mode 1)
(setq auto-insert-query nil)
(setq auto-insert-directory
      (expand-file-name "~/programming/templates/"))

;; (define-auto-insert
;;   '("\\.js\\'")
;;   "javascript-prompt-sync.js")

;; (define-auto-insert
;;   '("\\.zig\\'")
;;   "zig-std-import-template-and-main.zig")

;; Setting up completion package
(use-package yasnippet
  :ensure t
  :config (yas-global-mode 1))
(use-package yasnippet-snippets
  :ensure t
  :after yasnippet)
(use-package vertico
  :ensure t
  :init
  (vertico-mode))
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))
(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  (corfu-auto t)                 ;; Enable auto completion
  (corfu-auto-prefix 2)          ;; Minimum length of prefix for auto completion.
  (corfu-popupinfo-mode t)       ;; Enable popup information
  (corfu-popupinfo-delay 0.5)    ;; Lower popup info delay to 0.5 seconds from 2 seconds
  (corfu-separator ?\s)          ;; Orderless field separator, Use M-SPC to enter separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin
  (completion-ignore-case t)

  ;; Enable indentation+completion using the TAB key.
  ;; `completion-at-point' is often bound to M-TAB.
  (tab-always-indent 'complete)

  (corfu-preview-current nil) ;; Don't insert completion without confirmation
  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))

(use-package nerd-icons-corfu
  :after corfu
  :init (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

(electric-pair-mode 1)
 (setq electric-pair-pairs '(
                             (?\{ . ?\})
;;                             (?\( . ?\))
                             (?\[ . ?\])
;;                             (?\" . ?\")
                             ))
(add-hook 'js2-mode-hook
          (lambda ()
            (electric-indent-mode 1)))  ; Ensures proper indentation on newline

(setq completion-styles '(orderless basic))

;; Terminal things
(use-package eat
  :ensure t
  :config
  (evil-set-initial-state 'eat-mode 'insert))

;; Load autothemer
(use-package autothemer
  :ensure t)

;; Load my theme
;(use-package base16-theme
;  :ensure t
;  :config
;  (load-theme 'base16-tokyo-night-moon t))

;; (load-theme 'my-tokyo-night-moon t)

(load-theme 'Shion-Valorheart :no-confirm)

(global-eldoc-mode -1)
(setq-default eldoc-mode nil)
(add-hook 'eglot-managed-mode-hook (lambda () (eldoc-mode -1)))
