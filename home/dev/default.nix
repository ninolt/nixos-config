{ pkgs, lib, ... }: {
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    plugins = [
      pkgs.vimPlugins.gruvbox
      {
        plugin = pkgs.vimPlugins.lightline-vim;
	    config = "let g:lightline = {'colorscheme':'gruvbox',}";
      }

      pkgs.vimPlugins.nvim-lspconfig
	  pkgs.vimPlugins.nvim-cmp
    ];

    extraConfig = ''
      set number relativenumber
      set colorcolumn=80,120

      set termguicolors
      colorscheme gruvbox
      set noshowmode

      set shiftwidth=4
      set tabstop=4
    '';

	extraLuaConfig = ''
	  vim.lsp.enable('pylsp')
	'';
  };
}

