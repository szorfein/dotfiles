return function(s)
  -- App drawer bar
  require("layouts.app_drawer")(s)

  -- Start Screen widget
  require("layouts.start_screen")(s)

  -- Monitor bar
  require("layouts.monitor_bar")(s)

  -- Nav drawer
  require("layouts.navigation-drawer")(s)

  -- Logout screen
  require("layouts.logout")(s)

  -- Settings screen
  require("layouts.settings")(s)

  -- Lock screen
  require("layouts.lock_screen")
end
