;; Simple package system for Emacs
(require 'package)
;; Enable installation of packages from MELPA
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; refresh contents
;; (package-refresh-contents)

;; パッケージの自動インストール
(package-install 'use-package) ;; package controller
(package-install 'python-mode)
(package-install 'jedi)
(package-install 'company)
(package-install 'irony)
(package-install 'helm)
(package-install 'markdown-mode)
(package-install 'cmake-mode)
(package-install 'tabbar)

;; theme setting
(load-theme 'tsdh-light t)

;; Encoding settings
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; 細々としたセッティング
;; 対応する括弧を表示させる
(show-paren-mode 1)
;; 行が長くても自動的に折り返ししない
(auto-fill-mode 0)
(global-hl-line-mode 1)
(transient-mark-mode 1)
(line-number-mode 1)
(column-number-mode 1)
(ffap-bindings)
;;hide tooltip
;;menu-bar
(menu-bar-mode 0)
;; tool-bar
(tool-bar-mode 0)
;;メニューバーにファイルパスを表示する filepathファイル
(setq frame-title-format
      (format "%%f - Emacs@%s" (system-name)))
;; 幅、高さの設定
(set-frame-size (selected-frame) 90 35)
;; カッコ自動挿入
(electric-pair-mode 1)
;; スクロールステップ量
(setq scroll-conservatively 1)
;; スクロール時マージン
(setq scroll-margin 5)
;; マウスホイールによるスクロール時の行数
 ;;   Shift 少なめ、 Ctrl 多めに移動
 (setq mouse-wheel-scroll-amount
       '(5                              ; 通常
        ((shift) . 1)                   ; Shift
        ((control) . 40)                ; Ctrl
        ))

;; ;; タブの設定
(use-package tabbar
  :config
  (tabbar-mode)
  (tabbar-mwheel-mode nil)                  ;; マウスホイール無効
  (setq tabbar-buffer-groups-function nil)  ;; グループ無効
  (setq tabbar-use-images nil)              ;; 画像を使わない
  ;;----- キーに割り当てる
  (global-set-key (kbd "<C-tab>") 'tabbar-forward-tab)
  (global-set-key (kbd "<C-S-tab>") 'tabbar-backward-tab)
  ;;----- 左側のボタンを消す
  (dolist (btn '(tabbar-buffer-home-button
		 tabbar-scroll-left-button
		 tabbar-scroll-right-button))
    (set btn (cons (cons "" nil)
		   (cons "" nil))))
  ;;----- タブのセパレーターの長さ
  (setq tabbar-separator '(2.0))
  ;;----- タブの色（CUIの時。GUIの時は後でカラーテーマが適用）
  (set-face-attribute
   'tabbar-default nil
   :background "brightblue"
   :foreground "white"
   )
  (set-face-attribute
   'tabbar-selected nil
   :background "#ff5f00"
   :foreground "brightwhite"
   :box nil
   )
  (set-face-attribute
   'tabbar-modified nil
   :background "brightred"
   :foreground "brightwhite"
   :box nil
   )
  ;;----- 表示するバッファ
  (defun my-tabbar-buffer-list ()
    (delq nil
	  (mapcar #'(lambda (b)
		      (cond
		       ;; Always include the current buffer.
		       ((eq (current-buffer) b) b)
		       ((buffer-file-name b) b)
		       ((char-equal ?\  (aref (buffer-name b) 0)) nil)
		       ((equal "*scratch*" (buffer-name b)) b) ; *scratch*バッファは表示する
		       ((char-equal ?* (aref (buffer-name b) 0)) nil) ; それ以外の * で始まるバッファは表示しない
		       ((buffer-live-p b) b)))
		  (buffer-list))))
  (setq tabbar-buffer-list-function 'my-tabbar-buffer-list)
  )

;; <apt install emacs-mozc>が必須
(use-package mozc
  :config
  (setq default-input-method "japanese-mozc")
  (setq mozc-candidate-style 'echo-area))

;; No splash screen please ... jeez
(setq inhibit-startup-message t)

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

;; フォント設定
;; fc-listの出力、ファイル名じゃないアルファベットのところを書くっぽい
;; https://github.com/adobe-fonts/source-han-sans/raw/release/OTF/SourceHanSansHWJ.zip
;; これを落として、fc-cache、後でないと有効化されない
(set-default-font "Source Han Sans HW Regular 10")


;; Python mode config
(use-package python-mode
  :mode
  (("\\.py\\'" . python-mode))
  )
;; JEDI
;; vertual env のインストールが必要
;; インストール後: M-x jedi:install-server を実行する
(use-package jedi
  :config
  (add-hook 'python-mode-hook 'jedi:setup)
  (setq jedi:complete-on-dot t)
  )

;; 1. install llvm-dev, clang, libclang-dev, cmake
;; 2. company-mode, irony-mode, の導入
(use-package company ;;company settings
  :config
;;  (global-company-mode 1)
  (add-hook 'c-mode-common-hook 'company-mode)
  (add-hook 'c++-mode-hook 'company-mode)
  (add-hook 'cmake-mode-hook 'company-mode)
  (add-hook 'emacs-lisp-mode-hook 'company-mode)
  (global-set-key (kbd "C-M-i") 'company-complete)
  ;; (setq company-idle-delay nil) ; 自動補完をしない
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection))
(use-package irony ;;irony settings
  :config
  (progn
     (custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
     (add-to-list 'company-backends 'company-irony)
     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
     (add-hook 'c-mode-common-hook 'irony-mode)
     (add-hook 'c++-mode-hook 'irony-mode)
     )
  )

;; Helm settings
(use-package helm-config
  :config
  (global-set-key (kbd "C-x b") 'helm-mini)
  (setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-echo-input-in-header-line t)
  (setq helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match    t)
  (helm-mode 1)
  )

;; markdown-mode config
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package cmake-mode
  :mode (("\\.cmake\\'" . cmake-mode)
	 ("CMakeLists\\.txt\\'" . cmake-mode)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(irony-additional-clang-options (quote ("-std=c++11")))
 '(package-selected-packages (quote (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
