{ pkgs, ... }: {
  # install LSPs

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      gruvbox-nvim
      hardtime-nvim
      lualine-nvim
      mason-lspconfig-nvim
      mason-nvim
      nvim-cmp
      nvim-surround
      nvim-tree-lua
      nvim-treesitter
      nvim-treesitter-context
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.bibtex
      nvim-treesitter-parsers.csv
      nvim-treesitter-parsers.dockerfile
      nvim-treesitter-parsers.fish
      nvim-treesitter-parsers.haskell
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.julia
      nvim-treesitter-parsers.latex
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.make
      nvim-treesitter-parsers.markdown
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.r
      nvim-treesitter-parsers.rst
      nvim-treesitter-parsers.rust
      nvim-treesitter-parsers.ssh_config
      nvim-treesitter-parsers.toml
      nvim-treesitter-parsers.vim
      nvim-treesitter-parsers.yaml
      nvim-web-devicons
      plenary-nvim
      popup-nvim
      tagbar
      telescope-nvim
      trouble-nvim
      undotree
      vim-commentary
      vim-repeat
      vim-sensible
    ];
  };

  home.packages = with pkgs; [ ruff-lsp haskellPackages.ghcide ];
}
