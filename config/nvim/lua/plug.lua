return require('packer').startup(function()
	--[Plugin Manager]
	use 'wbthomason/packer.nvim'

	--[General]
	use {
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons'
	}
	use 'tpope/vim-sensible'
	use 'tpope/vim-surround'
	use 'tpope/vim-repeat'
	use 'tpope/vim-commentary'
	use 'mbbill/undotree'
	use 'preservim/tagbar'
	use 'ellisonleao/gruvbox.nvim'
	use 'nvim-lua/popup.nvim'
	use {
        'nvim-telescope/telescope.nvim',
        requires = 'nvim-lua/plenary.nvim'
    }
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/nvim-treesitter-context'
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

    use { 'JuliaEditorSupport/julia-vim' }

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    }

    use { 'mfussenegger/nvim-dap' }
    use { 'mfussenegger/nvim-lint' }
    use { 'mhartington/formatter.nvim' }
    use { 'neovim/nvim-lspconfig' }
    use { 'hrsh7th/cmp-nvim-lsp' }
    use { 'hrsh7th/cmp-buffer' }
    use { 'hrsh7th/cmp-path' }
    use { 'hrsh7th/cmp-cmdline' }
    use { 'hrsh7th/nvim-cmp' }

    -- CoC
    --use {
        --'neoclide/coc.nvim',
        --branch = 'master',
        --run = 'yarn install --frozen-lockfile'
    --}
    if packer_bootstrap then
        require('packer').sync()
    end
end)
