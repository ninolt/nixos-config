{ pkgs, ...}: {
  home = {
    keyboard.layout = "fr";

    packages = with pkgs; [
      # IHM
      swaybg

      # General app
      kitty

      # User app
      firefox
    ];

    username = "nino";
    homeDirectory = "/home/nino";

    stateVersion = "24.11";
  };
  
  wayland.windowManager.sway = {
    enable = true;

    extraConfig = ''
      input * {
        xkb_layout "fr"
      }
    '';

    config = rec {
      modifier = "Mod4";

      terminal = "kitty";

      startup = [
        { command = "swaybg -m fill -i ./wallpapers/cherry-blossom.png"; }
        { command = "firefox"; }
      ];
    };
  };

  programs.home-manager.enable = true;
}
