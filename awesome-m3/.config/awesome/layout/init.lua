return function(s)
  require('layout.dashboard')(s)
  require('layout.logout')(s)
  require('layout.app-drawer')(s)
  require('layout.panel')(s)
end
