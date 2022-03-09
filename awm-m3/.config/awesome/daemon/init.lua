require('daemon.mpd')
require('daemon.mpc')
require('daemon.mem')
require('daemon.cpu')
require('daemon.brightness')
if is_pulse then
  require('daemon.volume-pulse')
else
  require('daemon.volume-alsa')
end
require('daemon.geoloc')
require('daemon.disk')
