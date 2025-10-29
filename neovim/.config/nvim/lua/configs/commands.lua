--local f = require('utils.functions')
--local r = require('utils.remaps')
local map = vim.keymap.set

-- move start, end line
map({ 'i', 'n' }, '<C-a>', '<Home>', { silent = true, desc = 'move begin line' })
map({ 'i', 'n' }, '<C-e>', '<End>', { silent = true, desc = 'move end line' })
map('i', '<C-j>', '<Down>', { desc = 'move down' })
map({ 'i', 'n' }, '<C-k>', '<Up>', { desc = 'move up' })

-- backward-word
map({ 'i', 'n' }, '<M-h>', '<C-Left>', { silent = true, desc = 'move backward-word' })

-- forward-word
map({ 'i', 'n' }, '<M-l>', '<C-Right>', { silent = true, desc = 'move forward-word' })

-- Buffers
-- docs about vim buffer: https://readmedium.com/neovim-for-beginners-managing-buffers-91367668ce7
map('n', '<C-x>k', ':bw<CR>', { silent = true, desc = 'kill current buffer' })
map('n', '<C-x><C-s>', ':w<CR>', { desc = 'save current buffer' })
map('n', '<C-x>s', ':wa<CR>', { desc = 'save all buffers' })
