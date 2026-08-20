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

	# ./email
    ./joplin
    ./nextcloud.nix
	./firefox
	./spotify.nix
  ];

  services = {
	kdeconnect.enable = true;
  };

  home = {
    keyboard.layout = "fr";

    packages = with pkgs; [
      brightnessctl
      alacritty
      htop
	  nmap
      (busybox.override {
        extraConfig = "CONFIG_HOSTNAME n";
      })
	  wtype # For typing in Firefox's search bar
	  wofi-emoji

	  # For screenshots
	  grim
	  slurp
	  wl-clipboard

      tor-browser
      discord
	  signal-desktop
	  gimp3
	  tenacity
	  vlc
	  veracrypt
      ###
      libreoffice-qt
      hunspell
      hunspellDicts.fr-any
      hunspellDicts.en_GB-large
      ###
      kdePackages.okular
	  kdePackages.kleopatra
    ];

    sessionVariables = {
      EDITOR = "nvim";
      TERMINAL = "alacritty";
    };

    username = "nino";
    homeDirectory = "/home/nino";

    stateVersion = "26.05";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = "org.kde.okular.desktop";
    };
  };
  
  programs.home-manager.enable = true;
}
