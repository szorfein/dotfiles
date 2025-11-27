## Add few shorcuts:

Basic:

ALL shortcuts bellow are not yet implemented, maybe in futur. A lot come from
Emacs.

- C-x C-c: quit Neovim
- C-x u: undo

Minibuffer: where are display error message ? For session, search:

Windows (I don't thing implement this like this)

- C-x 0: delete active window
- C-x 1: delete other window
- C-x 2: split window bellow (v)
- C-x 3: split window right (h)
- C-x o: Switch active window

Directional window move (like windmove package)

- S-<left>
- S-<right>
- S-<up>
- S-<down>

Completing Word:

Manage bookmark and register (need a plugin -
https://github.com/tomasky/bookmarks.nvim ?)

- C-x r m: Set a bookmark
- C-x r l: List bookmark
- C-x r b: Jump to a bookmark

TAB completion

- TAB
- C-M-j or C-M-k: down or up
- C-n, C-p
- M-<: Begin completion list
- M->: End completion list

Indent (or align) a region , one of:

- C-M-\ and add the symbol for align, e.g: C-M-\ :
- C-x Tab: ?
- C-M-o: following by a symbol

Running one command

- M-!
- M-x shell Enter: create a shell in it's own buffer

Dired: ((see file hierarchy)

- C-x d: ((C-n go next, C-p prev, v preview))

### Keybinds Emacs

- https://github.com/sei40kr/nvimacs/blob/main/plugin/nvimacs.lua
- https://github.com/andrep/vimacs/blob/master/plugin/vimacs.vim
- https://github.com/tpope/vim-rsi/blob/master/plugin/rsi.vim
