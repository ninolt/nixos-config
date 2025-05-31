{ pkgs, lib, ...}: {
  imports = [
    ./sway
    ./wofi
    ./alacritty
    ./waybar.nix

    ./dev

    ./joplin.nix
    ./nextcloud.nix
  ];

  home = {
    keyboard.layout = "fr";

    packages = with pkgs; [
      brightnessctl
      alacritty

      firefox
      tor-browser
      discord
      ###
      libreoffice-qt
      hunspell
      hunspellDicts.fr-any
      hunspellDicts.en_GB-large
      ###
      kdePackages.okular
    ];

    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "alacritty";
    };

    username = "nino";
    homeDirectory = "/home/nino";

    stateVersion = "24.11";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.kde.okular.desktop";
    };
  };
  
  programs.home-manager.enable = true;
}
