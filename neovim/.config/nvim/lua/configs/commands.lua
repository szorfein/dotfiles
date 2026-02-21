--local f = require('utils.functions')
--local r = require('utils.remaps')
local map = vim.keymap.set

-- Reload configuration without restart nvim
map('n', '<leader>r', ':so %<CR>')

-- Change split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K') -- change vertical to horizontal
map('n', '<leader>th', '<C-w>t<C-w>H') -- change horizontal to vertical

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
map('n', '<C-x>k', ':bw<CR>', { silent = true, desc = 'Kill current buffer' })
map('n', '<C-x><C-s>', ':w<CR>', { desc = 'Save current buffer' })
map('n', '<C-x>s', ':wa<CR>', { desc = 'Save all buffers' })

-- Close all windows and exit from Neovim with <C-x><C-c>
map('n', '<C-x><C-c>', ':qa!<CR>', { desc = 'Quit Neovim' })

-- open terminal: https://inv.nadeko.net/watch?v=ooTcnx066Do&listen=false
