local app = require("util.app")

app.run_once({'picom -b'})
app.run_once({'ncmpcpp'}, true, 'music_n')
app.run_once({'cava'}, true, 'music_c')
app.run_once({'tmux'}, true, 'music_t')
app.run_once({'weechat'}, true, 'chat')
app.run_once({'neomutt'}, true, 'mail')
