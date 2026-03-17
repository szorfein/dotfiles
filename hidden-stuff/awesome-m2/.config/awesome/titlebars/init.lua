local titlebar = require("util.titlebar")

if M.name == "miami" then
  require("titlebars.smart-border")
elseif M.name == "worker" then
  require("titlebars.internal-border")
elseif M.name == "morpho" then
  require("titlebars.hide")
else
  require("titlebars.default")
  titlebar.enable_rounding()
end
