(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-for-comint-mode-on nil)
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "medium-blue" "magenta3" "DeepSkyBlue" "gray60"])
 '(custom-enabled-themes '(deeper-blue))
 '(global-hl-line-mode 1)
 '(global-linum-mode 1)
 '(global-visual-line-mode 1)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(package-selected-packages '(cmake-mode plantuml-mode))
 '(scroll-bar-mode nil)
 '(set-face-background 'hi-line t)
 '(tool-bar-mode nil)
 '(tooltip-mode nil)
 '(visible-bell nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Consolas" :foundry "outline" :slant normal :weight normal :height 125 :width normal))))
 '(font-lock-builtin-face ((t (:foreground "#859900"))))
 '(font-lock-comment-face ((t (:foreground "snow4" :italic t))))
 '(font-lock-constant-face ((t (:foreground "#2aa198"))))
 '(font-lock-doc-face ((t (:foreground "dim gray"))))
 '(font-lock-function-name-face ((t (:foreground "#268bd2"))))
 '(font-lock-keyword-face ((t (:foreground "#859900"))))
 '(font-lock-other-type-face ((t (:foreground "dark green"))))
 '(font-lock-string-face ((t (:foreground "pale green"))))
 '(font-lock-type-face ((t (:foreground "#b58900"))))
 '(font-lock-variable-name-face ((t (:foreground "#268bd2"))))
 '(font-lock-warning-face ((t (:foreground "red4" :bold t)))))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)

;;(setq org-plantuml-jar-path (expand-file-name "D:\\Dependencies\\plantuml-1.2023.7.jar"))
;;(add-to-list 'org-src-lang-modes '("plantuml" . plantuml))
;;(org-babel-do-load-languages 'org-babel-load-languages '((plantuml . t)))

(split-window-horizontally)

(setq display-time t)

(put 'upcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")

(setq source-directory "D:\\Emacs\\x86_64\\src")

(setq split-height-threshold nil)


(setq c-default-style "linux"
      c-basic-offset 4
      tab-width 4
      indent-tabs-mode nil)
(c-set-offset 'case-label '+)

(setq auto-mode-alist
      (append
       '(("\\.cpp$" . c++-mode)
	 ("\\.hpp$" . c++-mode)
	 ("\\.c$" . c++-mode)
	 ("\\.cc$" . c++-mode)
	 ("\\.h$" . c++-mode)
	 ("\\.txt$" . indented-text-mode)
	 ("\\.emacs$" . emacs-lisp-mode)
	 ("\\.md$" . org-mode)
	 ) auto-mode-alist))

(defun switch-header-source-file ()
  (interactive)
  (let (file-name (buffer-file-name))
    (if (string-match "\\.cpp$" file-name)
        (find-file (replace-regexp-in-string "\\.cpp$" "\\.h$" file-name)))
    (if (string-match "\\.h$" file-name)
        (find-file (replace-regexp-in-string "\\.h$" "\\.cpp$" file-name)))
    ))

(global-set-key [f12] 'switch-header-source-file)
     
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "M-n") 'forward-paragraph)

(add-hook 'c++-mode-hook
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(public slots\\):" 1
                                       font-lock-keywords-face t))))
          (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(singals\\):" 1
                                       font-lock-keywords-face t))))
	  (lambda ()
            (font-lock-add-keywords nil
                                    '(("\\<\\(emit\\):" 1
                                       font-lock-keywords-face t))))
	  )

(defun metax-header-info ()
  "Format the given file as a header file"
  (interactive)
  (setq base_file_name (file-name-sans-extension (file-name-nondirectory buffer-file-name)))
  (insert "#if !defined(")
  (push-mark)
  (insert base_file_name)
  (upcase-region (mark) (point))
  (pop-mark)
  (insert "_HPP)\n")
  (insert "#define ")
  (push-mark)
  (insert base_file_name)
  (upcase-region (mark) (point))
  (pop-mark)
  (insert "_HPP\n")
  (insert "/* ==========================================================================\n\n")
  (insert "    $File: ")
  (insert base_file_name)
  (insert ".hpp  $\n")
  (insert "    $Date:   $\n")
  (insert "    $Revision:   $\n")
  (insert "    $Author: Meta-X  $\n")
  (insert "    $Notice: (C) Copyright 2023 by Meta-X. All Rights Reserved.  $\n")  
  (insert "\n")
  (insert "   ========================================================================== */\n\n")
  (insert "#endif //")
  (push-mark)
  (insert base_file_name)
  (insert "_H\n")
  (upcase-region (mark) (point))
  (pop-mark))

(defun metax-source-info ()
  "Format the given file as a source file"
  (interactive)
  (setq base_file_name (file-name-sans-extension (file-name-nondirectory buffer-file-name)))
  (insert "/* ==========================================================================\n\n")
  (insert "    $File: ")
  (insert base_file_name)
  (insert ".cpp  $\n")
  (insert "    $Date:   $\n")
  (insert "    $Revision:   $\n")
  (insert "    $Author: Meta-X  $\n")
  (insert "    $Notice: (C) Copyright 2023 by Meta-X. All Rights Reserved.  $\n")  
  (insert "\n")
  (insert "   ========================================================================== */\n\n"))

(defun metax-function-info ()
  "Format the function comment"
  (interactive)
  (insert "/* ==========================================================================\n\n")
  (insert "    $Function:   $\n")
  (insert "    $Input:   $\n")
  (insert "    $Output:   $\n")
  (insert "    $Comment:   $\n")  
  (insert "    $Author: Meta-X  $\n")
  (insert "\n")
  (insert "   ============================================================================= */\n\n"))
