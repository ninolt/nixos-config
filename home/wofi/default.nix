{ config, pkgs, lib, ...}: {
  # Adding some power entries to wofi
  home.file = {
    "${config.home.homeDirectory}/.local/share/icons/logout.png".source = ./logout.png;
    "${config.home.homeDirectory}/.local/share/icons/reboot.png".source = ./reboot.png;
    "${config.home.homeDirectory}/.local/share/icons/shutdown.png".source = ./shutdown.png;
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
      @define-color bg #3c302f;
      @define-color bg-alt #504945;
      @define-color fg #fbf1c7;
      @define-color fg-alt #d5c4a1;

      * {
        background-color: @bg;

        border: 0;
        margin: 0;
        padding: 0;
      }

      *:focus {
        outline: none;
        box-shadow: none;
      }

      #window {
        border-radius: 10px;
        font-family: "JetBrains Mono";
      }

      #outer-box {
        margin: 20px;
        border: none;
        border-radius: 10px;
        background: @bg;
      }

      #input {
        border: 3px solid @fg;
        border-radius: 10px;
        padding: 5px;
        color: @fg;
      }

      #input image {
        margin: 5px;
      }

      #input:focus image  {
        color: @fg;
      }

      #inner-box {
        margin: 20px 0;
      }

      #entry {
        padding: 8px;
        color: @fg-alt;
        border: none;
        background: @bg;
      }

      #entry:selected {
        border-radius: 10px;
        background: @fg;
        border: none;
      }

      #entry:selected #img {
        background: @fg;
      }

      #text {
        padding: 0 10px;
        color: @fg;
      }

      #text:selected {
        background: @fg;
        color: @bg;
      }
    '';
  };
}
