return {
  -- The default text color
  foreground = '#E5E1E9',
  -- The default background color
  background = '#131318',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = '#a5b6cf',
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = '#0d0f18',
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = '#C6C0FF',

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
    '#DD5193', -- red
    '#5EB6D1', -- green
    '#fab387', -- yellow
    '#4383EB', -- blue
    '#B557F9', -- magenta
    '#79A5BE', -- teal
    '#CAB4F3', -- white
  },
  brights = {
    '#47464F', -- black
    '#F97AA5', -- red
    '#6CCEC9', -- green
    '#f9e2af', -- yellow
    '#86A9FB', -- blue
    '#BA9CED', -- magenta
    '#91C5E3', -- teal
    '#E5E1E9', -- white
  },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = '#c296eb'
}
