{ pkgs, ... } : {
  environment.systemPackages = with pkgs; [ 
    neovim wl-clipboard 
  ];

  programs.nvf = {
    enable = true;
    settings.vim = {
      undoFile.enable = true;
      autocomplete.nvim-cmp.enable = true;
      clipboard = {
        enable = true;
        registers = "unnamedplus";
      };
      options = {
        tabstop = 2;
        shiftwidth = 2;
        laststatus = 0;
        number = false;
        relativenumber = false;
      };
      theme = {
        transparent = true;
        enable = true;
        name = "gruvbox";
        style = "light";
      };
      languages = {
        enableTreesitter = true;
        dart.enable = true;
        nix.enable = true;
        ts.enable = true;
      };
      lsp = {
        enable = true;
        #formatOnSave = true;
        mappings = {
          hover = "K";
          codeAction = "L";
          goToDefinition = "gd";
          renameSymbol = "<leader>rn";
        };
      };
      telescope = {
        enable = true;
        mappings.findFiles = "<C-P>";
      };
      filetree.neo-tree.enable = true;
      keymaps = [{
        key = "<C-B>";
        mode = "n";
        silent = true;
        action = ":Neotree toggle";
      }];
    };
  };
}
