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
    options = {
        mode = "cursor",
        delay = 30,
        max_delta = {
            line = false,
            column = false,
            time = 300,
        },
    },
    keymaps = {
        basic = true,
        extra = true,
    },
})
