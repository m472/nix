{ pkgs, config, ... }: {
  # install LSPs

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-path
      colorizer
      gruvbox-nvim
      gitsigns-nvim
      hardtime-nvim
      image-nvim
      lsp_lines-nvim
      lualine-nvim
      mason-lspconfig-nvim
      molten-nvim
      none-ls-nvim
      nvim-cmp
      nvim-surround
      nvim-tree-lua
      nvim-treesitter
      nvim-treesitter-context
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.bibtex
      nvim-treesitter-parsers.c
      nvim-treesitter-parsers.c_sharp
      nvim-treesitter-parsers.csv
      nvim-treesitter-parsers.dockerfile
      nvim-treesitter-parsers.fish
      nvim-treesitter-parsers.fortran
      nvim-treesitter-parsers.gitignore
      nvim-treesitter-parsers.go
      nvim-treesitter-parsers.haskell
      nvim-treesitter-parsers.html
      nvim-treesitter-parsers.hyprlang
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.julia
      nvim-treesitter-parsers.latex
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.make
      nvim-treesitter-parsers.markdown
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.query
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

    extraPackages = with pkgs; [ imagemagick ];

    extraLuaPackages = with pkgs.luajitPackages; [ magick ];

    extraPython3Packages = with pkgs.python311Packages; [
      # magma dependencies
      jupyter-client
      cairosvg
      pnglatex
      plotly
      pyperclip
      nbformat
      pillow
    ];
  };

  home = {
    file."${config.xdg.configHome}/nvim/init.lua" = {
      enable = true;
      text = builtins.readFile ./config/nvim/init.lua;
    };

    file."${config.xdg.configHome}/nvim/lua/" = {
      enable = true;
      recursive = true;
      source = ./config/nvim/lua;
    };

    packages = with pkgs; [
      R
      black
      csharp-ls
      ctags
      deadnix
      docker-ls
      fortls
      ghc
      go
      hadolint
      haskell-language-server
      haskellPackages.fourmolu
      isort
      jq-lsp
      ltex-ls
      lua-language-server
      luajitPackages.lua-lsp
      markdownlint-cli
      mypy
      nil
      python311Packages.python
      python311Packages.ipython
      python311Packages.python-lsp-server
      python311Packages.pynvim
      rPackages.formatR
      rstcheck
      ruff-lsp
      ruff-lsp
      rustc
      shellcheck
      statix
      stylelint
      stylua
      texlab
      wezterm
      yaml-language-server
      yamlfmt

    ];
  };
}
