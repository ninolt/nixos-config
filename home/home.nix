{ pkgs, lib, ...}: {
  imports = [
    ./sway.nix
    ./wofi.nix
    ./waybar.nix

    ./dev

    ./librewolf.nix
    ./joplin.nix
    ./nextcloud.nix
  ];

  home = {
    keyboard.layout = "fr";

    packages = with pkgs; [
      brightnessctl
      kitty
      tor-browser
      discord
    ];

    username = "nino";
    homeDirectory = "/home/nino";

    stateVersion = "24.11";
  };
  
  programs.home-manager.enable = true;
}
