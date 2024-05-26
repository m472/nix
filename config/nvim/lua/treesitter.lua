require('nvim-treesitter.configs').setup{
    ensure_installed =
    { 'python', 'lua', 'yaml', 'json', 'julia', 'bash', 'c_sharp',
    'html', 'fish', 'bibtex', 'latex', 'markdown', 'rst', 'toml', 'vim' },
    highlight = {
        enable = true
    }
}
