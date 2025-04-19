{ pkgs, config, ... }: {
  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";

    # Tab and indent settings
    opts = {
      tabstop = 4;
      shiftwidth = 4;
      softtabstop = 4;
      expandtab = true;
      smarttab = true;

      # Line numbers
      number = true;
      relativenumber = true;

      # Case-insensitive search unless uppercase
      ignorecase = true;
      smartcase = true;

      # Persistent undo
      undodir = "${config.home.homeDirectory}/.vim/undodir";
      undofile = true;

      # Disable swapfile
      swapfile = false;

      # Split behavior
      splitbelow = true;
      splitright = true;

      # UI
      scrolloff = 8;
      signcolumn = "yes";
      colorcolumn = "80";
    };
    clipboard.providers.wl-copy.enable = true;
    colorschemes.gruvbox.enable = true;
    dependencies.ripgrep.enable = true;

    keymaps = [
      # Escape insert mode with jf / fj
      {
        mode = "i";
        key = "jf";
        action = "<Esc>";
      }
      {
        mode = "i";
        key = "fj";
        action = "<Esc>";
      }

      # Navigation between splits
      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
      }

      # Leader mappings
      {
        mode = "n";
        key = "<Leader>nt";
        action = ":NvimTreeToggle<CR>";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<Leader>tb";
        action = ":TagbarToggle<CR>";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<Leader>fg";
        action = ":Telescope git_files<CR>";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<Leader>ff";
        action = ":Telescope find_files<CR>";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<Leader>fc";
        action = ":Telescope git_commits<CR>";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<Leader>fr";
        action = ":Telescope lsp_definitions<CR>";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<Leader>fs";
        action = ":Telescope lsp_dynamic_workspace_symbols<CR>";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<Leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<Leader>fm";
        action = "<cmd>lua vim.lsp.buf.format()<CR>";
        options.noremap = true;
      }
    ];

    plugins = {
      commentary.enable = true;
      gitsigns.enable = true;
      lsp-format.enable = true;
      lsp-lines.enable = true;
      lsp-status.enable = true;
      lualine.enable = true;
      nvim-surround.enable = true;
      nvim-tree.enable = true;
      web-devicons.enable = true;
      repeat.enable = true;
      tagbar.enable = true;
      telescope.enable = true;
      trouble.enable = true;
      undotree.enable = true;

      treesitter = {
        enable = true;
        settings.highlight.enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          agda
          bash
          bibtex
          c
          c_sharp
          csv
          dockerfile
          ebnf
          fish
          fortran
          gitignore
          gleam
          go
          haskell
          html
          hyprlang
          json
          julia
          just
          latex
          lua
          make
          markdown
          nix
          python
          query
          r
          rst
          rust
          ssh_config
          toml
          vim
          yaml
          zig
        ];
      };

      lsp = {
        enable = true;
        servers = {
          clangd.enable = true;
          csharp_ls.enable = true;
          dockerls.enable = true;
          fortls.enable = true;
          gleam.enable = true;
          gopls.enable = true;
          jqls.enable = true;
          lua_ls = {
            enable = true;
            settings.telemetry.enable = false;
          };
          nil_ls.enable = true;
          openscad_lsp.enable = true;
          pylsp.enable = true;
          ruff.enable = true;
          rust_analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
          texlab.enable = true;
          zls.enable = true;

          hls = {
            enable = true;
            installGhc = true;
            settings = { haskell.formattingProvider = "fourmolu"; };
          };
        };
      };

      none-ls = {
        enable = true;
        enableLspFormat = true;
        sources = {
          code_actions = {
            gitsigns.enable = true;
            refactoring.enable = true;
            statix.enable = true;
          };
          diagnostics = {
            deadnix.enable = true;
            fish.enable = true;
            hadolint.enable = true;
            markdownlint.enable = true;
            mypy.enable = true;
            rstcheck.enable = true;
            statix.enable = true;
            todo_comments.enable = true;
            yamllint.enable = true;
          };
          formatting = {
            black.enable = true;
            fish_indent.enable = true;
            format_r.enable = true;
            isort.enable = true;
            just.enable = true;
            nixfmt.enable = true;
            stylelint.enable = true;
            yamlfmt.enable = true;
          };
        };
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources =
          [ { name = "nvim_lsp"; } { name = "path"; } { name = "buffer"; } ];
      };
    };
  };
}
