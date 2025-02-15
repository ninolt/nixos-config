{ pkgs, ...}: {
  home = {
    keyboard.layout = "fr";

    packages = with pkgs; [
      firefox
      kitty
    ];

    username = "nino";
    homeDirectory = "/home/nino";

    stateVersion = "24.05";
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
        {command = "firefox";}
      ];
    };
  };

  programs.home-manager.enable = true;
}
