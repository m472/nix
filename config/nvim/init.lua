require('vars')
require('opts')
require('keys')

if vim.env.HOME_MANAGER_MANAGES_NVIM == nil then
    require('plug')
end

require('nvim-treesitter.configs').setup{
    highlight = {
        enable = true
    }
}
require('nvim-tree').setup{}
require('nvim-surround').setup{}

if vim.env.HOME_MANAGER_MANAGES_NVIM == nil then
    require('mason').setup{}
    require('mason-lspconfig').setup{}
end

require('lspconfig-config')
