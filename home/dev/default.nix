{ inputs, pkgs, lib, ... }: {
  imports = [ inputs.nix4nvchad.homeManagerModule ];

  programs.nvchad = {
    enable = true;

    extraPlugins = ''
      return {
        {"Myriad-Dreamin/tinymist"}
      }
    '';
  };

  programs.zsh.shellAliases.vim = "nvim";
}

