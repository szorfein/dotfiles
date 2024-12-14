;;; doom-vamp-theme.el --- inspired by the popular Dracula theme -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Added: March 8, 2018 (1337e9b2c4bb)
;; Author: fuxialexander <https://github.com/fuxialexander>
;; Maintainer: hlissner <https://github.com/hlissner>
;; Source: https://vamptheme.com
;;
;;; Commentary:
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup doom-vamp-theme nil
  "Options for the `doom-vamp' theme."
  :group 'doom-themes)

(defcustom doom-vamp-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-vamp-theme
  :type 'boolean)

(defcustom doom-vamp-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-vamp-theme
  :type 'boolean)

(defcustom doom-vamp-colorful-headers nil
  "If non-nil, headers in org-mode will be more colorful; which is truer to the
original Dracula Emacs theme."
  :group 'doom-vamp-theme
  :type 'boolean)

(defcustom doom-vamp-comment-bg doom-vamp-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-vamp-theme
  :type 'boolean)

(defcustom doom-vamp-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-vamp-theme
  :type '(choice integer boolean))

;; Helper function that reads values from Xresources
(defun xresources-theme-color (name)
  "Read the color NAME (e.g. color5) from the X resources."
  (x-get-resource name ""))

(defconst xrbg (xresources-theme-color "background"))
(defconst xrfg (xresources-theme-color "foreground"))
(defconst  xr0 (xresources-theme-color "color0"))
(defconst  xr1 (xresources-theme-color "color1"))
(defconst  xr2 (xresources-theme-color "color2"))
(defconst  xr3 (xresources-theme-color "color3"))
(defconst  xr4 (xresources-theme-color "color4"))
(defconst  xr5 (xresources-theme-color "color5"))
(defconst  xr6 (xresources-theme-color "color6"))
(defconst  xr7 (xresources-theme-color "color7"))
(defconst  xr8 (xresources-theme-color "color8"))
(defconst  xr9 (xresources-theme-color "color9"))
(defconst xr10 (xresources-theme-color "color10"))
(defconst xr11 (xresources-theme-color "color11"))
(defconst xr12 (xresources-theme-color "color12"))
(defconst xr13 (xresources-theme-color "color13"))
(defconst xr14 (xresources-theme-color "color14"))
(defconst xr15 (xresources-theme-color "color15"))

(defconst xrbase0 (doom-lighten xrbg 0.02))
(defconst xrbase1 (doom-lighten xrbg 0.04))
(defconst xrbase2 (doom-lighten xrbg 0.06))
(defconst xrbase3 (doom-lighten xrbg 0.08))
(defconst xrbase4 (doom-lighten xr0 0.1))
(defconst xrbase5 (doom-lighten xr0 0.12))
(defconst xrbase6 (doom-lighten xr8 0.1))
(defconst xrbase7 (doom-lighten xr8 0.2))
(defconst xrbase8 (doom-lighten xr8 0.3))
(defconst bgcontainer (doom-darken xr5 0.50))

;;
;;; Theme definition

(def-doom-theme doom-vamp
  "A dark theme based on Dracula theme"

  ;; name        default   256       16
  ((bg         `(,xrbg "#262626" "black"        ))
   (bg-alt     `(,xr0 "#1c1c1c" "black"        ))
   (base0      `(,xrbase0 "#1c1c1c" "black"        ))
   (base1      `(,xrbase1 "#1e1e1e" "brightblack"  ))
   (base2      `(,xrbase3 "#2e2e2e" "brightblack"  ))
   (base3      `(,xrbase4 "#262626" "brightblack"  ))
   (base4      `(,xrbase5 "#3f3f3f" "brightblack"  ))
   (base5      `(,bgcontainer "#525252" "brightblack"  ))
   (base6      `(,xr8 "#bbbbbb" "brightblack"  ))
   (base7      `(,xrbase8 "#cccccc" "brightblack"  ))
   (base8      `(,xr7 "#dfdfdf" "white"        ))
   (fg         `(,xrfg "#ffffff" "white"        ))
   (fg-alt     `(,xr15 "#bfbfbf" "brightwhite"  ))

   (grey       base6)
   (red        `(,xr1 "#ff6655" "red"          ))
   (orange     `(,xr9 "#ffbb66" "brightred"    ))
   (green      `(,xr2 "#55ff77" "green"        ))
   (teal       `(,xr10 "#0088cc" "brightgreen"  ))
   (yellow     `(,xr3 "#ffff88" "yellow"       ))
   (blue       `(,xr12 "#66bbff" "brightblue"   ))
   (dark-blue  `(,xr4 "#0088cc" "blue"         ))
   (magenta    `(,xr5 "#ff77cc" "magenta"      ))
   (violet     `(,xr13 "#bb99ff" "brightmagenta"))
   (cyan       `(,xr14 "#88eeff" "brightcyan"   ))
   (dark-cyan  `(,xr6 "#88eeff" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      violet)
   (vertical-bar   (doom-darken base1 0.1))
   (selection      dark-blue)
   (builtin        orange)
   (comments       (if doom-vamp-brighter-comments dark-cyan base5))
   (doc-comments   (doom-lighten (if doom-vamp-brighter-comments dark-cyan base5) 0.25))
   (constants      cyan)
   (functions      green)
   (keywords       magenta)
   (methods        teal)
   (operators      violet)
   (type           violet)
   (strings        yellow)
   (variables      (doom-lighten magenta 0.6))
   (numbers        violet)
   (region         `(,(car base3) ,@(cdr base1)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (level1 magenta)
   (level2 violet)
   (level3 (if doom-vamp-colorful-headers green   (doom-lighten violet 0.35)))
   (level4 (if doom-vamp-colorful-headers yellow  (doom-lighten magenta 0.35)))
   (level5 (if doom-vamp-colorful-headers cyan    (doom-lighten violet 0.6)))
   (level6 (if doom-vamp-colorful-headers orange  (doom-lighten magenta 0.6)))
   (level7 (if doom-vamp-colorful-headers blue    (doom-lighten violet 0.85)))
   (level8 (if doom-vamp-colorful-headers magenta (doom-lighten magenta 0.85)))
   (level9 (if doom-vamp-colorful-headers violet  (doom-lighten violet 0.95)))

   (-modeline-bright doom-vamp-brighter-modeline)
   (-modeline-pad
    (when doom-vamp-padded-modeline
      (if (integerp doom-vamp-padded-modeline) doom-vamp-padded-modeline 4)))

   (region-alt `(,(car base3) ,@(cdr base4)))

   (modeline-fg     'unspecified)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        (doom-darken magenta 0.6)
      `(,(doom-darken (car bg) 0.05) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken  magenta 0.675)
      `(,(car bg) ,@(cdr base0))))
   (modeline-bg-inactive   `(,(doom-darken (car bg) 0.075) ,@(cdr base1)))
   (modeline-bg-inactive-l (doom-darken bg 0.1)))


  ;;;; Base theme face overrides
  (((line-number &override) :foreground base5)
   ((line-number-current-line &override) :foreground fg)
   ((font-lock-comment-face &override)
    :background (if doom-vamp-comment-bg (doom-lighten bg 0.05) 'unspecified))
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))

   ;;;; company
   (company-tooltip-selection     :background base3)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground violet)
   (css-property             :foreground violet)
   (css-selector             :foreground green)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   ;;;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")
   ;;;; helm
   (helm-bookmark-w3m :foreground violet)
   (helm-buffer-not-saved :foreground violet)
   (helm-buffer-process :foreground orange)
   (helm-buffer-saved-out :foreground fg)
   (helm-buffer-size :foreground fg)
   (helm-candidate-number :foreground bg :background fg)
   (helm-ff-directory :foreground green :weight 'bold)
   (helm-ff-executable :foreground dark-blue :inherit 'italic)
   (helm-ff-invalid-symlink :foreground magenta :weight 'bold)
   (helm-ff-prefix :foreground bg :background magenta)
   (helm-ff-symlink :foreground magenta :weight 'bold)
   (helm-grep-finish :foreground base2)
   (helm-grep-running :foreground green)
   (helm-header :foreground base2 :underline nil :box nil)
   (helm-moccur-buffer :foreground green)
   (helm-separator :foreground violet)
   (helm-source-go-package-godoc-description :foreground yellow)
   ((helm-source-header &override) :foreground magenta)
   (helm-time-zone-current :foreground orange)
   (helm-time-zone-home :foreground violet)
   (helm-visible-mark :foreground bg :background base3)
   ;;;; highlight-quoted-mode
   (highlight-quoted-symbol :foreground cyan)
   (highlight-quoted-quote  :foreground magenta)
   ;;;; js2-mode
   (js2-external-variable :foreground violet)
   (js2-function-param :foreground cyan)
   (js2-jsdoc-html-tag-delimiter :foreground yellow)
   (js2-jsdoc-html-tag-name :foreground dark-blue)
   (js2-jsdoc-value :foreground yellow)
   (js2-private-function-call :foreground cyan)
   (js2-private-member :foreground base7)
   ;;;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-darken 'bg 0.075))
   ;;;; outline <built-in>
   ((outline-1 &override) :foreground level1)
   (outline-2 :inherit 'outline-1 :foreground level2)
   (outline-3 :inherit 'outline-2 :foreground level3)
   (outline-4 :inherit 'outline-3 :foreground level4)
   (outline-5 :inherit 'outline-4 :foreground level5)
   (outline-6 :inherit 'outline-5 :foreground level6)
   (outline-7 :inherit 'outline-6 :foreground level7)
   (outline-8 :inherit 'outline-7 :foreground level8)
   ;;;; org <built-in>
   (org-agenda-date :foreground cyan)
   (org-agenda-dimmed-todo-face :foreground comments)
   (org-agenda-done :foreground base4)
   (org-agenda-structure :foreground violet)
   ((org-block &override) :background (doom-darken base1 0.125) :foreground violet)
   ((org-block-begin-line &override) :background (doom-darken base1 0.125))
   ((org-code &override) :foreground yellow)
   (org-column :background base1)
   (org-column-title :background base1 :bold t :underline t)
   (org-date :foreground cyan)
   ((org-document-info &override) :foreground blue)
   ((org-document-info-keyword &override) :foreground comments)
   (org-done :foreground green :background base2 :weight 'bold)
   (org-footnote :foreground blue)
   (org-headline-base :foreground comments :strike-through t :bold nil)
   (org-headline-done :foreground base4 :strike-through nil)
   ((org-link &override) :foreground orange)
   (org-priority :foreground cyan)
   ((org-quote &override) :background (doom-darken base1 0.125))
   (org-scheduled :foreground green)
   (org-scheduled-previously :foreground yellow)
   (org-scheduled-today :foreground orange)
   (org-sexp-date :foreground base4)
   ((org-special-keyword &override) :foreground yellow)
   (org-table :foreground violet)
   ((org-tag &override) :foreground (doom-lighten orange 0.3))
   (org-todo :foreground orange :bold 'inherit :background (doom-darken base1 0.02))
   (org-upcoming-deadline :foreground yellow)
   (org-warning :foreground magenta)
   ;;;; rjsx-mode
   (rjsx-tag :foreground magenta)
   (rjsx-attr :foreground green :slant 'italic :weight 'medium)
   ;;;; solaire-mode
   (solaire-hl-line-face :background base2)
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))
   (solaire-region-face :background region-alt)
   ;;;; web-mode
   (web-mode-builtin-face :foreground orange)
   (web-mode-css-selector-face :foreground green)
   (web-mode-html-attr-name-face :foreground green)
   (web-mode-html-tag-bracket-face :inherit 'default)
   (web-mode-html-tag-face :foreground magenta :weight 'bold)
   (web-mode-preprocessor-face :foreground orange))

  ;;;; Base theme variable overrides-
  ()
  )

;;; doom-vamp-theme.el ends here
