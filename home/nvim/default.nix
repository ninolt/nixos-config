{ inputs, pkgs, lib, ... }: {
  imports = [ inputs.nvchad4nix.homeManagerModule ];

  programs.nvchad = {
    enable = true;
  };
}
