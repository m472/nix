local map = vim.api.nvim_set_keymap

vim.g.mapleader = ' '

-- escape from insert mode using jf or fj
map('i', 'jf', '<Esc>', {})
map('i', 'fj', '<Esc>', {})

-- navigation between splits using Ctrl+hjkl
map('n', '<C-h>', '<C-w>h', {})
map('n', '<C-j>', '<C-w>j', {})
map('n', '<C-k>', '<C-w>k', {})
map('n', '<C-l>', '<C-w>l', {})

-- leader mappings
map('n', '<Leader>nt', ':NvimTreeToggle<CR>', { noremap = true })
map('n', '<Leader>tb', ':TagbarToggle<CR>', { noremap = true })
map('n', '<Leader>fg', ':Telescope git_files<CR>', { noremap = true })
map('n', '<Leader>ff', ':Telescope find_files<CR>', { noremap = true })
map('n', '<Leader>fc', ':Telescope git_commits<CR>', { noremap = true })
map('n', '<Leader>fr', ':Telescope lsp_definitions<CR>', { noremap = true })
map('n', '<Leader>fs', ':Telescope lsp_dynamic_workspace_symbols<CR>', { noremap = true })
map('n', '<Leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap = true })

-- coc
--map('i', '<Tab>', 'coc#pu', { noremap = true, silent = true, expr = true })
