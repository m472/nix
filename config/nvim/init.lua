require('vars')
require('opts')
require('keys')

if vim.env.HOME_MANAGER_MANAGES_NVIM == nil then
    require('plug')
    require('mason').setup{}
    require('mason-lspconfig').setup{}
end

require('plug-config')

require('lspconfig-config')
