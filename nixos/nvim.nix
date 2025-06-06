{ pkgs, ... } : {
  environment.systemPackages = [ pkgs.neovim ];
  programs.nvf = {
    enable = true;
    settings.vim = {
      undoFile.enable = true;
      autocomplete.nvim-cmp.enable = true;
      options = {
        tabstop = 2;
        shiftwidth = 2;
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
        formatOnSave = true;
        mappings = {
          hover = "K";
          codeAction = "L";
          goToDefinition = "gd";
        };
      };
      telescope = {
        enable = true;
        mappings.findFiles = "<C-P>";
      };
      filetree.nvimTree = {
        enable = true;
        openOnSetup = false;
        mappings.toggle = "<C-b>";
      };
    };
  };
}
