return {
  -- The default text color
  foreground = '#F1DEDD',
  -- The default background color
  background = '#1A1111',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '#FFB3AE',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = '#571D1C',
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = '#a5b6cf',

  -- the foreground color of selected text
  selection_fg = '#a5b6cf',
  -- the background color of selected text
  selection_bg = '#151720',

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#11131c',

  -- The color of the split lines between panes
  split = '#0f111a',

  ansi = {
    '#322827', -- black
    '#fb5c67', -- red
    '#9ea0d8', -- green
    '#f37e4e', -- yellow
    '#b969ad', -- blue
    '#f46889', -- magenta
    '#b9a1d2', -- teal
    '#cbced3', -- white
  },
  brights = {
    '#534342', -- black
    '#fe7378', -- red
    '#a7ace7', -- green
    '#ffad4f', -- yellow
    '#ec87dd', -- blue
    '#f986af', -- magenta
    '#907da4', -- teal
    '#F1DEDD', -- white
  },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = '#c296eb'
}
