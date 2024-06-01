require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
    },
})
require("nvim-tree").setup({})
require("gitsigns").setup({})
require("lualine").setup({})
require("nvim-surround").setup({})
require("cinnamon").setup({
    default_delay = 10,
    extra_keymaps = true,
    max_length = 300,
    scroll_limit = -1,
})
