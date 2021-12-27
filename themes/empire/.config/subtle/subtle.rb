#
# Default options
#

set :increase_step, 5
set :border_snap, 10
set :default_gravity, :ct66
set :urgent_dialogs, false
set :honor_size_hints, false
set :gravity_tiling, true
set :click_to_focus, false
set :skip_pointer_warp, true 
set :skip_urgent_warp, true 
set :wmname, "Subtle"

#
# Screen & bar, we use polybar
#

screen 1 do
  top    [ ]
  bottom [ ]
end

#
# Styles
#

style :all do
  padding      0
  margin       0
  font        "-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
  border      "#ff3030", 0
  background  "#202020"
end

style :views do 
  style :focus do
    foreground "#ffec26"
  end
end

style :clients do
  foreground "#00ff00"
  padding      0
  margin_left  7
  margin_right   6
  margin_top   7
  margin_bottom   7
end

#
#  Gravities
#

# Center
gravity :center, [ 2, 5, 96, 93 ]
gravity :ct66, [ 25, 25, 50, 50 ]

# Gimp
gravity :gimp_image, [ 1, 5, 98, 93 ]
gravity :gimp_toolbox, [ 4, 5, 12, 93 ]
gravity :gimp_dock, [ 84, 5, 12, 93 ]

#
# Grabs
#

# Jump to view1, view2, ...
grab "W-S-1", :ViewJump1
grab "W-S-2", :ViewJump2
grab "W-S-3", :ViewJump3
grab "W-S-4", :ViewJump4
grab "W-S-5", :ViewJump5
grab "W-S-6", :ViewJump6

# Switch current view
grab "W-1", :ViewSwitch1
grab "W-2", :ViewSwitch2
grab "W-3", :ViewSwitch3
grab "W-4", :ViewSwitch4
grab "W-5", :ViewSwitch5
grab "W-6", :ViewSwitch6

# Move mouse to screen1, screen2, ...
grab "W-A-1", :ScreenJump1
grab "W-A-2", :ScreenJump2
grab "W-A-3", :ScreenJump3
grab "W-A-4", :ScreenJump4
grab "W-A-5", :ScreenJump5
grab "W-A-6", :ScreenJump6

# Force reload of config and sublets
grab "W-C-r", :SubtleReload

# Force restart of subtle
grab "W-C-S-r", :SubtleRestart

# Quit subtle
grab "W-C-q", :SubtleQuit

# Move current window
grab "W-B1", :WindowMove

# Resize current window
grab "W-B3", :WindowResize

# Toggle floating mode of window
grab "W-f", :WindowFloat

# Toggle fullscreen mode of window
grab "W-space", :WindowFull

# Toggle sticky mode of window (will be visible on all views)
grab "W-s", :WindowStick

# Toggle zaphod mode of window (will span across all screens)
grab "W-equal", :WindowZaphod

# Raise window
grab "W-r", :WindowRaise

# Lower window
grab "W-l", :WindowLower

# Select next windows
grab "W-Left",  :WindowLeft
grab "W-Down",  :WindowDown
grab "W-Up",    :WindowUp
grab "W-Right", :WindowRight

# Kill current window
grab "W-z", :WindowKill

# Cycle between given gravities
grab "W-F1", [ :d1 ]
grab "W-F2", [ :d2, :ct66 ]
grab "W-F3", [ :d3 ]
grab "W-F4", [ :center ]

# Exec programs
grab "W-Return", "#{ENV["TERMINAL"]}"
grab "W-p", "rofi -show run"

# Run Ruby lambdas
grab "S-F2" do |c|
  puts c.name
end

grab "S-F3" do
  puts Subtlext::VERSION
end

# custom grab
grab "C-A-Right", "mpc next"
grab "C-A-Left", "mpc prev"
grab "S-A-d", "mpc del 0"
grab "C-A-Up", "volume.sh -i 1"
grab "C-A-Down", "volume.sh -d 1"
grab "G-F9", "xbacklight +1"
grab "G-F8", "xbacklight -1"

#
# Tags
#

tag "terms" do
  match :instance => "xterm|[u]?rxvt|termite|kitty"
end

tag "browser" do
  match "uzbl|opera|firefox|navigator|vivaldi|brave"
  gravity :center
end

tag "fixed" do
  geometry [ 10, 10, 100, 100 ]
  stick    true
end

tag "resize" do
  match  "sakura|gvim"
  resize true
end

tag "gravity" do
  gravity :center
end

# Modes
tag "stick" do
  match "mplayer|mpv"
  float true
  stick true
end

tag "imgs" do
  match "sxiv|feh"
  gravity :ct66
end

tag "float" do
  match "display"
  float true
end

# Gimp
tag "gimp_image" do
  match   :role => "gimp-image-window"
  gravity :gimp_image
end

tag "gimp_toolbox" do
  match   :role => "gimp-toolbox-*"
  gravity :gimp_toolbox
end

tag "gimp_dock" do
  match   :role => "gimp-dock"
  gravity :gimp_dock
end

tag "gimp_scum" do
  match role: "gimp-.*|screenshot"
end

tag "vms" do
  match "virtualbox"
  float true
end

## programs on view console
gravity :term, [ 33, 5, 34, 20 ]
gravity :wee, [ 1, 13, 28, 79 ]
gravity :mus, [ 71, 13, 28, 40 ]
gravity :cav, [ 71, 53, 28, 39 ]
gravity :mai, [ 33, 32, 34, 66 ]

tag "pwd" do
  match "pwd"
  gravity :term
end

tag "chat" do
  match :instance => "weechat"
  gravity :wee
end

tag "music" do
  match :instance => "ncmpcpp"
  gravity :mus
end

tag "cava" do
  match :instance => "cava"
  gravity :cav
end

tag "mail" do
  match :instance => "mutt"
  gravity :mai
end

## programs on view dev 
gravity :d1, [ 2, 5, 47, 93 ]
gravity :d2, [ 51, 5, 47, 93 ]

tag "code_1" do
  match "code-1"
  gravity :d1
end

tag "code_2" do
  match "code-2"
  gravity :d2
end

## float gravity
gravity :fl_1, [ 11, 13, 27, 79 ]
gravity :fl_2, [ 38, 13, 49, 40 ]
gravity :fl_3, [ 38, 53, 49, 39 ]

#
# View
#

view "terms", "terms|imgs|default"
view "www",   "browser"
view "dev",   "code_.*"
view "console", "pwd|music|cava|chat|mail"
view "gimp",  "gimp_.*"
view "vm", "vms"

#
# Autorun
#

on :start do
  Subtlext::Client.spawn( "compton -b" )
  Subtlext::Client.spawn( "feh --bg-fill images/empire.jpg" )
  Subtlext::Client.spawn( "#{ENV["TERMINAL"]}" )
  Subtlext::Client.spawn( "sh ~/.config/polybar/launch.sh subtle" )
  Subtlext::Client.spawn( "sh ~/.config/subtle/init-console.sh" )
  Subtlext::Client.spawn( "sh ~/.config/subtle/init-dev.sh" )
  Subtlext::Client.spawn( "brave-sec" )
end

on :reload do
  Subtlext::Client.spawn( "~/.config/polybar/launch.sh subtle" )
end
