require('formatter').setup {
}

require('lint').linters_by_ft = {
    python = { 'flake8' },
    rst = { 'rst' },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
