-- https://m3.material.io/components/snackbar/specs

local naughty = require("naughty")
local helpers = require('lib/helpers')

--naughty.config.defaults['position'] = 'bottom-middle'

local snackbar = {}

function snackbar.debug(args)
  naughty.notify({ preset = naughty.config.presets.debug,
                   title = args.title,
                   text = args.text,
                   bg = md.sys.color.inverse_surface,
                   fg = md.sys.color.inverse_on_surface,
                   font = md.sys.typescale.body_medium.font,
                   position = 'bottom_middle',
                   shape = helpers.rrect(dpi(4)),
                   max_height = dpi(48)
  })
end

function snackbar.critical(args)
  naughty.notify({ preset = naughty.config.presets.critical,
                   title = args.title,
                   text = args.text,
                   bg = md.sys.color.inverse_surface .. md.sys.elevation.level3,
                   fg = md.sys.color.inverse_primary,
                   font = md.sys.typescale.label_large.font,
                   position = 'top_middle'
  })
end

return snackbar
