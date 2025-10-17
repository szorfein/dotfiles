return {
    foreground = '#F1DEDD',
    background = '#1A1111',
    cursor_bg = '#FFB3AE',
    cursor_fg = '#571D1C',
    cursor_border = '#a5b6cf',
    selection_fg = '#a5b6cf',
    selection_bg = '#151720',
    scrollbar_thumb = '#11131c',
    split = '#0f111a',

    ansi = {
        '#322827', -- black
        '#fb5c67', -- red
        '#edad74', -- green
        '#f37e4e', -- yellow
        '#d369cb', -- blue
        '#f46889', -- magenta
        '#c471e2', -- teal
        '#fcddf0', -- white
    },
    brights = {
        '#534342', -- black
        '#fe7378', -- red
        '#ebca7c', -- green
        '#ffad4f', -- yellow
        '#e878eb', -- blue
        '#f986af', -- magenta
        '#dd89fd', -- teal
        '#fccfe0', -- white
    },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = '#c296eb',
}
