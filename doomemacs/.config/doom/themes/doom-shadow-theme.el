;;; doom-shadow-theme.el --- inspired by Atom One Dark -*- no-byte-compile: t; -*-
(require 'doom-themes)

;;
(defgroup doom-shadow-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-shadow-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'doom-shadow-theme
  :type 'boolean)

(defcustom doom-shadow-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'doom-shadow-theme
  :type 'boolean)

(defcustom doom-shadow-comment-bg doom-shadow-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'doom-shadow-theme
  :type 'boolean)

(defcustom doom-shadow-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-shadow-theme
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
(defconst xrbase3 (doom-lighten xr0 0.08))
(defconst xrbase4 (doom-lighten xr0 0.1))
(defconst xrbase5 (doom-lighten xr0 0.12))
(defconst xrbase6 (doom-lighten xr8 0.1))
(defconst xrbase7 (doom-lighten xr8 0.2))
(defconst xrbase8 (doom-lighten xr8 0.3))

;;
(def-doom-theme doom-shadow
  "A dark theme inspired by Atom One Dark"

  ;; name        default   256       16
  ((bg         `(,xrbg nil       nil            ))
   (bg-alt     `(,xr0 nil       nil            ))
   (base0      `(,xrbase0 "black"   "black"        ))
   (base1      `(,xrbase1 "brightblack"  ))
   (base2      `(,xrbase2 "brightblack"  ))
   (base3      `(,xr0 "brightblack"  ))
   (base4      `(,xrbase4 "brightblack"  ))
   (base5      `(,xr8 "#525252" "brightblack"  ))
   (base6      `(,xrbase6 "#6b6b6b" "brightblack"  ))
   (base7      `(,xrbase7 "#979797" "brightblack"  ))
   (base8      `(,xrbase8 "#dfdfdf" "white"        ))
   (fg         `(,xrfg "#bfbfbf" "brightwhite"  ))
   (fg-alt     `(,xr15 "#2d2d2d" "white"        ))

   (grey       `(,xr8))
   (red        `(,xr1 "#ff6655" "red"          ))
   (orange     `(,xr11 "#dd8844" "brightred"    ))
   (green      `(,xr2 "#99bb66" "green"        ))
   (teal       `(,xr10 "#44b9b1" "brightgreen"  ))
   (yellow     `(,xr3 "#ECBE7B" "yellow"       ))
   (blue       `(,xr4 "#51afef" "brightblue"   ))
   (dark-blue  `(,xr12 "#2257A0" "blue"         ))
   (magenta    `(,xr5 "#c678dd" "brightmagenta"))
   (violet     `(,xr13 "#a9a1e1" "magenta"      ))
   (cyan       `(,xr6 "#46D9FF" "brightcyan"   ))
   (dark-cyan  `(,xr14 "#5699AF" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base2 0.1))
   (selection      dark-blue)
   (builtin        magenta)
   (comments       (if doom-shadow-brighter-comments dark-cyan base8))
   (doc-comments   (doom-lighten (if doom-shadow-brighter-comments dark-cyan base5) 0.25))
   (constants      violet)
   (functions      magenta)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        green)
   (variables      (doom-lighten magenta 0.4))
   (numbers        orange)
   (region         `(,(doom-lighten (car bg-alt) 0.15) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright doom-shadow-brighter-modeline)
   (-modeline-pad
    (when doom-shadow-padded-modeline
      (if (integerp doom-shadow-padded-modeline) doom-shadow-padded-modeline 4)))

   (modeline-fg     fg)
   (modeline-fg-alt base5)

   (modeline-bg
    (if -modeline-bright
        (doom-darken blue 0.475)
      `(,(doom-darken (car bg-alt) 0.15) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken blue 0.45)
      `(,(doom-darken (car bg-alt) 0.1) ,@(cdr base0))))
   (modeline-bg-inactive   `(,(doom-darken (car bg-alt) 0.1) ,@(cdr bg-alt)))
   (modeline-bg-inactive-l `(,(car bg-alt) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   (evil-goggles-default-face :inherit 'region :background (doom-blend region bg 0.5))

   ((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)

   (font-lock-comment-face
    :foreground comments
    :background (if doom-shadow-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; Doom modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :inherit 'mode-line-emphasis :weight 'bold)
   (doom-modeline-buffer-project-root :foreground green :weight 'bold)

   ;; ivy-mode
   (ivy-current-match :background dark-blue :distant-foreground base0 :weight 'normal)

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; LaTeX-mode
   (font-latex-math-face :foreground green)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :foreground hidden)
   (solaire-org-hide-face :foreground hidden)

   ;; lsp-mode
   (lsp-headerline-breadcrumb-separator-face :foreground green)

   ;; rjsx
   (rjsx-tag :foreground red)
   (rjsx-attr :foreground orange))

  ;; --- extra variables ---------------------
  ()
  )

;;; doom-shadow-theme.el ends here
