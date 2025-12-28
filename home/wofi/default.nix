{ config, pkgs, lib, ...}: {
  # Adding some power entries to wofi
  home.file = {
    "${config.home.homeDirectory}/.local/share/icons/logout.png".source = ./logout.png;
    "${config.home.homeDirectory}/.local/share/icons/reboot.png".source = ./reboot.png;
    "${config.home.homeDirectory}/.local/share/icons/shutdown.png".source = ./shutdown.png;
    "${config.home.homeDirectory}/.local/share/icons/kleopatra.png".source = ./kleopatra.png;
  };

  xdg.desktopEntries = {
    logout = {
      name = "Logout";
      exec = ''sh -c "loginctl terminate-session \\$XDG_SESSION_ID"'';
      icon = "${config.home.homeDirectory}/.local/share/icons/logout.png";
      terminal = false;
      categories = [ "System" ];
    };

    shutdown = {
      name = "Shutdown";
      exec = "systemctl poweroff";
      icon = "${config.home.homeDirectory}/.local/share/icons/shutdown.png";
      terminal = false;
      categories = [ "System" ];
    };

    reboot = {
      name = "Reboot";
      exec = "systemctl reboot";
      icon = "${config.home.homeDirectory}/.local/share/icons/reboot.png";
      terminal = false;
      categories = [ "System" ];
    };

	"org.kde.kleopatra" = {
      name = "Kleopatra";
      exec = "kleopatra";
      icon = "${config.home.homeDirectory}/.local/share/icons/kleopatra.png";
	  comment = "Certificate manager and cryptography app";
	  type = "Application";
      categories = [ "Qt" "KDE" "Utility" ];
    };
  };

  programs.wofi = {
    enable = true;

    settings = {
      width = "25%";
      prompt = "Applications:";
      insensitive = true;
      hide_scroll = true;
      allow_images = true;
      no_actions = true;
      content_halign = "start";
    };

    style = ''
	  @define-color bg rgba(60, 48, 47, 0.6);
      @define-color fg #fbf1c7;
      @define-color selection-bg #fbf1c7;
      @define-color selection-fg #3c302f;
  
      * {
        background-color: transparent;
        border: none;
        margin: 0;
        padding: 0;
        font-family: "JetBrains Mono";
      }
  
      *:focus {
        outline: none;
        box-shadow: none;
      }
  
      #window {
        background-color: transparent;
      }
  
      #outer-box {
        padding: 20px;
        border-radius: 15px;
		background: radial-gradient(
		  circle, 
          rgba(60, 48, 47, 0.95) 0%,
		  rgba(60, 48, 47, 0.80) 30%,
          rgba(60, 48, 47, 0.40) 60%,
          rgba(60, 48, 47, 0.15) 85%,
          rgba(60, 48, 47, 0.0) 100%
        );
      }
  
      #input {
        border: 3px solid @fg;
        border-radius: 10px;
        padding: 8px;
        color: @fg;
        margin-bottom: 10px;
      }
  
      #input image {
        margin-right: 10px;
        color: @fg;
      }
  
      #inner-box {
        margin: 10px 0;
      }
  
      #entry {
        padding: 10px;
        border-radius: 10px;
        color: @fg;
      }
  
      #entry:selected {
        background-color: @selection-bg;
      }
  
      #entry:selected #text {
        color: @selection-fg;
      }
  
      #entry:selected #img {
        background-color: transparent;
      }
  
      #text {
        padding: 0 10px;
        color: @fg;
      }
    '';
  };
}
