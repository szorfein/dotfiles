--local f = require('utils.functions')
--local r = require('utils.remaps')
local map = vim.keymap.set

-- move start, end line
map({ 'i', 'n' }, '<C-a>', '<Home>', { silent = true, desc = 'move begin line' })
map({ 'i', 'n' }, '<C-e>', '<End>', { silent = true, desc = 'move end line' })
map('i', '<C-j>', '<Down>', { desc = 'move down' })
map({ 'i', 'n' }, '<C-k>', '<Up>', { desc = 'move up' })

-- backward-word
map({ 'i', 'n' }, '<C-h>', '<C-Left>', { silent = true, desc = 'move backward-word' })

-- forward-word
map({ 'i', 'n' }, '<C-l>', '<C-Right>', { silent = true, desc = 'move forward-word' })
