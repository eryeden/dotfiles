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
(package-install 'use-package)

;; Encoding settings
(set-default-coding-systems 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "Japanese")

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




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
