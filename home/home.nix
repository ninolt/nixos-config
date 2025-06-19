{ pkgs, lib, ...}: {
  imports = [
    ./sway
    ./zsh.nix
    ./fastfetch
    ./wofi
    ./dunst.nix
    ./alacritty
    ./waybar.nix

    ./dev

	./email
    ./joplin.nix
    ./nextcloud.nix
  ];

  home = {
    keyboard.layout = "fr";

    packages = with pkgs; [
      brightnessctl
      alacritty
      htop

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
