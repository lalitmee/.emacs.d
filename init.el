;; stuff automatically added
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#000000" "#8b0000" "#00ff00" "#ffa500" "#7b68ee" "#dc8cc3" "#93e0e3" "#dcdccc"])
 '(cua-mode t nil (cua-base))
 '(custom-enabled-themes (quote (smart-mode-line-powerline)))
 '(custom-safe-themes
   (quote
    ("b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "d6922c974e8a78378eacb01414183ce32bc8dbf2de78aabcc6ad8172547cb074" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "67e998c3c23fe24ed0fb92b9de75011b92f35d3e89344157ae0d544d50a63a72" "ff7625ad8aa2615eae96d6b4469fcc7d3d20b2e1ebc63b761a349bebbb9d23cb" default)))
 '(display-time-mode t)
 '(fci-rule-color "#383838")
 '(meghanada-auto-start nil)
 '(package-selected-packages
   (quote
    (cyberpunk-theme package-build shut-up epl git commander f dash s dashboard zerodark-theme material-theme java-imports java-snippets meghanada google-c-style flymake-cursor flymake-google-cpplint ac-c-headers company-jedi company-c-headers cider ac-cider magit origami default-text-scale auctex dired+ dired-quick-sort irony fiplr multiple-cursors emmet-mode treemacs-evil treemacs ac-emacs-eclim company-emacs-eclim gradle-mode eclim cmake-ide hydra smart-mode-line-powerline-theme moe-theme powerline python-django dumb-jump geben-helm-projectile projectile-codesearch counsel-projectile projectile smartparens ggtags virtualenvwrapper better-shell web-mode iedit expand-region aggressive-indent hungry-delete beacon smart-mode-line all-the-icons neotree elpy jedi flycheck dracula counsel swiper lorem-ipsum tabbar ace-window org-bullets which-key try use-package)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "APPL" :slant normal :weight normal :height 120 :width normal))))
 '(aw-leading-char-face ((t (:inherit ace-jump-face-foreground :height 3.0))))
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))


;; Our stuff

(setq inhibit-startup-message t)

(setq user-full-name "Lalit Kumar"
      user-mail-address "lalitkumar.meena.lk@gmail.com")


(defun my:ac-c-header-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers)
  (add-to-list 'achead:include-directories '"/usr/lib/gcc/x86_64-linux-gnu/5/include"))

(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; Flymake Google cpp lint
(defun my:flymake-google-init ()
  (require 'flymake-google-cpplint)
  (custom-set-variables
   '(flymake-google-cpplint-command "/usr/local/bin/cpplint"))
  (flymake-google-cpplint-load))

(add-hook 'c-mode 'my:flymake-google-init)
(add-hook 'c++-mode 'my:flymake-google-init)


;; spaces
(setq sentence-end-double-space nil)


(tool-bar-mode -1)


(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)



(unless (assoc-default "org" package-archives)
  (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t))



;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))



(use-package try
	:ensure t)



(use-package which-key
	:ensure t
	:config
	(which-key-mode))


;; Org-mode stuff
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


(load-theme 'dracula)


(setq-default ido-enable-flex-matching t)
(setq-default ido-everywhere t)
(ido-mode 1)



(defalias 'list-buffers 'ibuffer)
;; (defalias 'list-buffers 'ibuffer-other-window)

; If you like a tabbar
;(use-package tabbar
;  :ensure t
;  :config
;  (tabbar-mode 1))


(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))


;; it looks like counsel is a requirement for swiper
(use-package counsel
  :bind
  (("M-y" . counsel-yank-pop)
   :map ivy-minibuffer-map
   ("M-y" . ivy-next-line)))



(use-package swiper
  :ensure t
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (global-set-key "\C-s" 'swiper)
    (global-set-key (kbd "C-c C-r") 'ivy-resume)
    (global-set-key (kbd "<f6>") 'ivy-resume)
    (global-set-key (kbd "M-x") 'counsel-M-x)
    (global-set-key (kbd "C-x C-f") 'counsel-find-file)
    (global-set-key (kbd "<f1> f") 'counsel-describe-function)
    (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
    (global-set-key (kbd "<f1> l") 'counsel-load-library)
    (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
    (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
    (global-set-key (kbd "C-c g") 'counsel-git)
    (global-set-key (kbd "C-c j") 'counsel-git-grep)
    (global-set-key (kbd "C-c k") 'counsel-ag)
    (global-set-key (kbd "C-x l") 'counsel-locate)
    (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))



(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))



(set-face-attribute 'default nil :height 160)



(use-package flycheck
  :ensure
  :init
  (global-flycheck-mode t))



(use-package auto-complete
  :ensure t
  :init
  (progn
    (ac-config-default)
    (global-auto-complete-mode t)
    ))



(setq-default py-python-command "python3")
(setq-default python-shell-interpreter "python3")

(use-package jedi
  :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))


(use-package elpy
  :ensure t
  :config
  (elpy-enable))

(use-package virtualenvwrapper
  :ensure t
  :config
  (venv-initialize-interactive-shells)
  (venv-initialize-eshell))



(use-package yasnippet
  :ensure
  :init
  (yas-global-mode 1))



(use-package better-shell
  :ensure t
  :bind (("C-'" . better-shell-shell)))

(electric-pair-mode 1)
(setq-default electric-pair-pairs '(
				    (?\" . ?\")
				    (?\{ . ?\})
				    ) )

;; for copy, paste, cut
(cua-mode 1)



;; turn on highlight current line
(global-hl-line-mode 1)



;;turn on bracket match highlight
(show-paren-mode 1)



;; remember cursor position. When file is opened, put cursor at last position
(if (version< emacs-version "25.0")
    (progn
      (require 'saveplace)
      (setq-default save-place t))
  (save-place-mode 1))



;; UTF-8 as default encoding
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)



(global-linum-mode 1)



(global-auto-revert-mode 1)



(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)


(global-visual-line-mode 1)



;; changing yes to y and no n
(defalias 'yes-or-no-p 'y-or-n-p)



(add-to-list 'load-path "/home/lalit/.emacs.d/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)



(setq neo-theme (if (display-graphic-p) 'icons 'arrow))


(use-package all-the-icons)


(display-time-mode 1)


(use-package beacon
  :ensure t
  :config
  (beacon-mode 1))



(use-package hungry-delete
  :ensure t
  :config
  (global-hungry-delete-mode))


(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode 1))


(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region))


(use-package iedit
  :ensure t)

(setq-default sml/theme 'powerline)
(setq-default sml/no-confirm-load-theme t)
(sml/setup)
(setq-default powerline-arrow-shape 'arrow)
(setq-default powerline-default-separator-dir '(right . left))



(setq save-interprogram-paste-before-kill t)
(setq-default auto-revert-verbose nil)
(global-set-key (kbd "<f5>") 'revert-buffer)


;; Web mode
(use-package web-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (setq web-mode-engines-alist
	'(("django"    . "\\.html\\'")))
  (setq web-mode-ac-sources-alist
	'(("css" . (ac-source-css-property))
	  ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

  (setq web-mode-enable-auto-closing t)
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-style-padding 1)
  (setq web-mode-script-padding 1)
  (setq web-mode-block-padding 0)
  (setq web-mode-comment-style 2)

  (setq web-mode-extra-snippets
	'(("erb" . (("toto" . "<% toto | %>\n\n<% end %>")))
	  ("php" . (("dowhile" . "<?php do { ?>\n\n<?php } while (|); ?>")
		    ("debug" . "<?php error_log(__LINE__); ?>")))
	  ))

  (setq web-mode-extra-auto-pairs
	'(("erb"  . (("beg" "end")))
	  ("php"  . (("beg" "end")
		     ("beg" "end")))
	  ))

  (setq web-mode-enable-auto-pairing t)
  (setq web-mode-enable-css-colorization t)
  (setq web-mode-enable-block-face t)
  (setq web-mode-enable-part-face t)
  (setq-default web-mode-enable-comment-keywords t)
  (setq web-mode-enable-heredoc-fontification t)
  (setq web-mode-enable-current-column-highlight t)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-ac-sources-alist
	'(("css" . (ac-source-css-property))
	  ("html" . (ac-source-words-in-buffer ac-source-abbrev))))
  (setq web-mode-ac-sources-alist
	'(("php" . (ac-source-yasnippet ac-source-php-auto-yasnippets))
	  ("html" . (ac-source-emmet-html-aliases ac-source-emmet-html-snippets))
	  ("css" . (ac-source-css-property ac-source-emmet-css-snippets))))
  
  (add-hook 'web-mode-before-auto-complete-hooks
	    '(lambda ()
	       (let ((web-mode-cur-language
		      (web-mode-language-at-pos)))
		 (if (string= web-mode-cur-language "php")
		     (yas-activate-extra-mode 'php-mode)
		   (yas-deactivate-extra-mode 'php-mode))
		 (if (string= web-mode-cur-language "css")
		     (setq emmet-use-css-transform t)
		   (setq emmet-use-css-transform nil)))))

  (add-hook 'local-write-file-hooks
            (lambda ()
	      (delete-trailing-whitespace)
	      nil))

  
  (setq web-mode-enable-auto-quoting t)) ; this fixes the quote problem I mentioned


;; C++ package

(use-package ggtags
  :ensure t
  :config
  (add-hook 'c-mode-common-hook
	    (lambda ()
	      (when (derived-mode-p 'c-mode 'c++-mode 'java-mode)
		(ggtags-mode 1))))
  )



;; projectile
(use-package projectile
  :ensure t
  :config
  (projectile-mode)
  (setq projectile-completion-system 'ivy))

(use-package counsel-projectile
  :ensure t
  :config
  (counsel-projectile-on))

(use-package smartparens
  :ensure t
  :config
  (use-package smartparens-config)
  (use-package smartparens-html)
  (use-package smartparens-python)
  (use-package smartparens-latex)
  (smartparens-global-mode t)
  (show-smartparens-global-mode t)
  :bind
  ( ("C-<down>" . sp-down-sexp)
    ("C-<up>"   . sp-up-sexp)
    ("M-<down>" . sp-backward-down-sexp)
    ("M-<up>"   . sp-backward-up-sexp)
    ("C-M-a" . sp-beginning-of-sexp)
    ("C-M-e" . sp-end-of-sexp)



    ("C-M-f" . sp-forward-sexp)
    ("C-M-b" . sp-backward-sexp)

    ("C-M-n" . sp-next-sexp)
    ("C-M-p" . sp-previous-sexp)

    ("C-S-f" . sp-forward-symbol)
    ("C-S-b" . sp-backward-symbol)

    ("C-<right>" . sp-forward-slurp-sexp)
    ("M-<right>" . sp-forward-barf-sexp)
    ("C-<left>"  . sp-backward-slurp-sexp)
    ("M-<left>"  . sp-backward-barf-sexp)

    ("C-M-t" . sp-transpose-sexp)
    ("C-M-k" . sp-kill-sexp)
    ("C-k"   . sp-kill-hybrid-sexp)
    ("M-k"   . sp-backward-kill-sexp)
    ("C-M-w" . sp-copy-sexp)

    ("C-M-d" . delete-sexp)

    ("M-<backspace>" . backward-kill-word)
    ("C-<backspace>" . sp-backward-kill-word)
    ([remap sp-backward-kill-word] . backward-kill-word)

    ("M-[" . sp-backward-unwrap-sexp)
    ("M-]" . sp-unwrap-sexp)

    ("C-x C-t" . sp-transpose-hybrid-sexp)

    ("C-c ("  . wrap-with-parens)
    ("C-c ["  . wrap-with-brackets)
    ("C-c {"  . wrap-with-braces)
    ("C-c '"  . wrap-with-single-quotes)
    ("C-c \"" . wrap-with-double-quotes)
    ("C-c _"  . wrap-with-underscores)
    ("C-c `"  . wrap-with-back-quotes)
    ))


(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config
  ;; (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
  :init
  (dumb-jump-mode)
  :ensure
  )



;; Dired+
(use-package dired+
  :ensure t
  :config (require 'dired+)
  )


(use-package dired-quick-sort
  :ensure t
  :config
  (dired-quick-sort-setup))


(global-set-key (kbd "C-x C-b") 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
	       ("dired" (mode . dired-mode))
	       ("org" (name . "^.*org$"))
	       
	       ("web" (or (mode . web-mode) (mode . js2-mode)))
	       ("shell" (or (mode . eshell-mode) (mode . shell-mode)))
	       ("mu4e" (or

			(mode . mu4e-compose-mode)
			(name . "\*mu4e\*")
			))
	       ("programming" (or
			       (mode . python-mode)
			       (mode . c++-mode)))
	       ("emacs" (or
			 (name . "^\\*scratch\\*$")
			 (name . "^\\*Messages\\*$")))
	       ))))
(add-hook 'ibuffer-mode-hook
	  (lambda ()
	    (ibuffer-auto-mode 1)
	    (ibuffer-switch-to-saved-filter-groups "default")))

;; don't show these
					;(add-to-list 'ibuffer-never-show-predicates "zowie")
;; Don't show filter groups if there are no buffers in that group
(setq ibuffer-show-empty-filter-groups nil)

;; Don't ask for confirmation to delete marked buffers
(setq ibuffer-expert t)


;; Emmet mode
(use-package emmet-mode
  :ensure t
  :config
  (add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'web-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
  (add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
  )



;; Multiple Cursors
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


;; Fiplr
(setq-default fiplr-root-markers '(".git" ".svn"))

(setq-default fiplr-ignored-globs '((directories (".git" ".svn"))
				    (files ("*.jpg" "*.png" "*.zip" "*~"))))

(global-set-key (kbd "C-x f") 'fiplr-find-file)



;; Irony for C/C++ language
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)



;; JavaScript Language setup
(use-package js2-mode
  :ensure t
  :ensure ac-js2
  :init
  (progn
    (add-hook 'js-mode-hook 'js2-minor-mode)
    (add-hook 'js2-mode-hook 'ac-js2-mode)
    ))

(use-package js2-refactor
  :ensure t
  :config
  (progn
    (js2r-add-keybindings-with-prefix "C-c C-m")
    ;; eg. extract function with `C-c C-m ef`.
    (add-hook 'js2-mode-hook #'js2-refactor-mode)))
(use-package tern
  :ensure tern
  :ensure tern-auto-complete
  :config
  (progn
    (add-hook 'js-mode-hook (lambda () (tern-mode t)))
    (add-hook 'js2-mode-hook (lambda () (tern-mode t)))
    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
    (tern-ac-setup)
    ))

;;(use-package jade
;;:ensure t
;;)

(use-package nodejs-repl
  :ensure t
  )

(add-hook 'js-mode-hook
          (lambda ()
            (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-sexp)
            (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
            (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
            (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)))



;; latex
(use-package tex
  :ensure auctex)

(defun tex-view ()
  (interactive)
  (tex-send-command "evince" (tex-append tex-print-file ".pdf")))



(use-package default-text-scale
  :ensure t
  :config
  (global-set-key (kbd "C-M-+") 'default-text-scale-increase)
  (global-set-key (kbd "C-M--") 'default-text-scale-decrease))


(use-package origami
  :ensure t)

;; Git version control
(use-package magit
  :ensure t
  :init
  (progn
    (bind-key "C-x g" 'magit-status)
    ))


(require 'meghanada)
(add-hook 'java-mode-hook
          (lambda ()
            ;; meghanada-mode on
            (meghanada-mode t)
            (setq c-basic-offset 2)
            ;; use code format
            (add-hook 'before-save-hook 'meghanada-code-beautify-before-save)))

;; to check magit

;;; INIT.EL ENDS HERE
