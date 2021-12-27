set :increase_step, 5
set :border_snap, 10
set :default_gravity, :center66
set :urgent_dialogs, false
set :honor_size_hints, false
set :gravity_tiling, true 
set :click_to_focus, false
set :skip_pointer_warp, true
set :skip_urgent_warp, false
set :wmname, "Subtle"

#
# == Screen
#

screen 1 do
  top    [ ]
  bottom [ ]
end

# Example for a second screen:
#screen 2 do
#  top    [ ]
#  bottom [ ]
#end

#
# == Styles
#

# Style for all style elements
style :all do
  background  "#000000"
  icon        "#000000"
  border      "#000000", 2
  padding     0, 0
  font        "-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
end

# Style for the all views
style :views do
  foreground  "#000000"
end

# Style for active/inactive windows
style :clients do
  active    "#3f2859", 1
  inactive  "#241733", 1
  # need -1 bellow, maybe because my res (1366)
  # margin arg: top/bottom, left/right
  margin_top 0
  margin_right 0
  margin_left 0
  margin_bottom 0
end

# Style for subtle
style :subtle do
  margin      0, 0, 0, 0
  panel       "#000000"
  background  "#000000"
  stipple     "#000000"
end

#
# == Gravities
#

# Left
gravity :left23, [ 0, 4, 67, 96 ]

# Center
gravity :center,         [   0,   4, 100, 96 ]
gravity :center66,       [  25,  25,  50,  50 ]
gravity :center33,       [  33,  33,  33,  33 ]

# Gimp
gravity :gimp_image,     [  10,   4,  80, 96 ]
gravity :gimp_toolbox,   [   0,   4,  10, 96 ]
gravity :gimp_dock,      [  90,   4,  10, 96 ]

#
# == Grabs
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

# Select next and prev view */
grab "W-Tab", :ViewNext
grab "W-Tab", :ViewPrev

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
grab "W-F1", [ :c1, :left23 ]
grab "W-F2", [ :c2, :center66, :center ]
grab "W-F3", [ :c3 ]

# Exec programs
grab "W-Return", "#{ENV["TERMINAL"]}"
grab "W-p", "~/bin/launcher"

# Run Ruby lambdas
grab "S-F2" do |c|
  puts c.name
end

grab "S-F3" do
  puts Subtlext::VERSION
end

# Custom grab
grab "C-A-Right", "mpc next"
grab "C-A-Left", "mpc prev"
grab "S-A-d", "mpc del 0"
grab "C-A-Up", "volume.sh -i 1"
grab "C-A-Down", "volume.sh -d 1"
grab "G-F9", "xbacklight +1"
grab "G-F8", "xbacklight -1"

#
# == Tags
#

# Simple tags
tag "terms" do
    match :instance => "xterm|[u]?rxvt|termite|kitty"
end

tag "browser" do
  match "uzbl|opera|firefox|navigator|vivaldi|brave"
  gravity :center
end

tag "popup" do
  match :role => "pop-up"
  float true
end

# Placement
tag "fixed" do
  geometry [ 10, 10, 100, 100 ]
  stick    true
end

tag "resize" do
  match  "sakura|gvim|virtualbox"
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
    stick true
    gravity :center66
end

tag "float" do
  match "display"
  float true
end

tag "wine" do
  match class: "Wine"
  gravity :center
end

tag "pdf" do
  match class: "[Zz]{1}athura"
  gravity :center
end

## programs on view dev [3]
gravity :c1, [ 0, 4, 33, 96 ]
gravity :c2, [ 33, 4, 34, 96 ]
gravity :c3, [ 67, 4, 33, 96 ]

tag "code_1" do
    match "code-1"
    gravity :center
end

tag "code_2" do
    match "code-2"
    gravity :c2
end

tag "code_3" do
    match "code-3"
    gravity :c3
end

tag "code_4" do
    match "code-4"
    gravity :c1
end

tag "code_5" do
    match "code-5"
    gravity :c2
end

tag "code_6" do
    match "code-6"
    gravity :c3
end
## End programs on view dev [3]

## Programs on view console [4]
tag "pwd" do
    match "pwd"
    gravity :c1
end

tag "chat" do
    match :instance => "weechat"
    gravity :c3
end

tag "music" do
    match :instance => "ncmpcpp"
    gravity :c1
end

tag "cava" do
    match :instance => "cava"
    gravity :c1
end

tag "mail" do
    match :instance => "mutt"
    gravity :c2
end
## End Programs on view console [4]

# Gimp
tag "gimp_image" do
  match   :role => "gimp-image-window"
  gravity :gimp_image
end

tag "gimp_toolbox" do
  match   :role => "gimp-toolbox$"
  gravity :gimp_toolbox
end

tag "gimp_dock" do
  match   :role => "gimp-dock"
  gravity :gimp_dock
end

tag "gimp_scum" do
  match role: "gimp-.*|screenshot"
end

tag "vms_manager" do
  match "virtualbox"
  float true
end

#
# == Views
#

view "terms", "terms|imgs|wine|pdf|default"
view "www",   "browser|popup"
view "dev",   "code_.*"
view "console",   "pwd|music|cava|chat|mail"
view "gimp",  "gimp_.*"
view "ctf",  "vms_.*"

#
# Autorun
#

on :start do
    Subtlext::Client.spawn( "compton -b" )
    Subtlext::Client.spawn( "feh --bg-fill images/sombra.png" )
    Subtlext::Client.spawn( "#{ENV["TERMINAL"]}" )
    Subtlext::Client.spawn( "~/.config/polybar/launch.sh subtle" )
    Subtlext::Client.spawn( "~/.config/subtle/init-dev.sh" )
    Subtlext::Client.spawn( "~/.config/subtle/init-console.sh" )
    Subtlext::Client.spawn( "brave-sec" )
end

on :reload do
    Subtlext::Client.spawn( "~/.config/polybar/launch.sh subtle" )
end
