return {
  -- The default text color
  foreground = '#E5E1E9',
  -- The default background color
  background = '#131318',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '#C6C0FF',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = '#2E295F',
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
    '#2A292F', -- black
    '#F059B7', -- red
    '#20B0B3', -- green
    '#FFBFA5', -- yellow
    '#7F93FF', -- blue
    '#C781F8', -- magenta
    '#7DD9FF', -- teal
    '#cbced3', -- white
  },
  brights = {
    '#47464F', -- black
    '#F97AA5', -- red
    '#00C6CD', -- green
    '#f9e2af', -- yellow
    '#84B4F3', -- blue
    '#C590FF', -- magenta
    '#5DC7E7', -- teal
    '#E5E1E9', -- white
  },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = '#c296eb'
}
