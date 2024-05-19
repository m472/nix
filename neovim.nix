{ pkgs, ... }: {
    # install LSPs
    home.packages = with pkgs;  [
        ruff-lsp
    ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      vim-sensible
      nvim-surround
      vim-repeat
      vim-commentary
      undotree
      gruvbox-nvim
      tagbar
      popup-nvim
      telescope-nvim
      plenary-nvim
      nvim-tree-lua
      nvim-treesitter
      nvim-treesitter-context
      nvim-treesitter-parsers.yaml
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.haskell
      nvim-treesitter-parsers.rust
      nvim-treesitter-parsers.toml
      nvim-treesitter-parsers.markdown
      nvim-treesitter-parsers.vim
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.fish
      nvim-treesitter-parsers.ssh_config
      nvim-treesitter-parsers.rst
      nvim-treesitter-parsers.r
      nvim-treesitter-parsers.make
      nvim-treesitter-parsers.latex
      nvim-treesitter-parsers.julia
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.dockerfile
      nvim-treesitter-parsers.csv
      nvim-treesitter-parsers.bibtex
      nvim-treesitter-parsers.bash
      lualine-nvim
      nvim-web-devicons
      mason-nvim
      mason-lspconfig-nvim
      trouble-nvim
      nvim-cmp
      cmp-path
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
    ];
  };
}
