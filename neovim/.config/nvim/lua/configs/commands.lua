--local f = require('utils.functions')
--local r = require('utils.remaps')
local map = vim.keymap.set

-- move start, end line
map('n', '<C-a>', '<Home>', { silent = true, desc = 'move begin line' })
map('n', '<C-e>', '<End>', { silent = true, desc = 'move end line' })
map('i', '<C-a>', '<Home>', { silent = true, desc = 'move begin line' })
map('i', '<C-e>', '<End>', { silent = true, desc = 'move end line' })
