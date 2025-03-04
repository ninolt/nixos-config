{ pkgs, lib, ...}: {
  home = {
    keyboard.layout = "fr";

    packages = with pkgs; [
      # System app
      brightnessctl

      # General app
      kitty

      # User app
      mullvad-browser
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

      input "1739:0:Synaptics_TM3139-001" {
        natural_scroll enabled
        tap enabled
      }
    '';

    config = rec {
      modifier = "Mod4";

      terminal = "kitty";

      startup = [
        { command = "swaymsg output \"*\" bg ${./wallpapers}/$(ls ${./wallpapers} | sort -R | head -n 1) fill"; }
        { command = "mullvad-browser"; }
      ];

      gaps = {
        outer = 10;
        inner = 20;
      };

      window = {
        titlebar = false;
      };

      bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];

      keybindings = lib.mkOptionDefault {
        "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
        "XF86MonBrightnessUp" = "exec brightnessctl set 10%+";

        "${modifier}+ampersand" = "workspace 1";
        "${modifier}+eacute" = "workspace 2";
        "${modifier}+quotedbl" = "workspace 3";
        "${modifier}+apostrophe" = "workspace 4";
        "${modifier}+parenleft" = "workspace 5";
        "${modifier}+minus" = "workspace 6";
        "${modifier}+egrave" = "workspace 7";
        "${modifier}+underscore" = "workspace 8";
        "${modifier}+ccedilla" = "workspace 9";
        "${modifier}+agrave" = "workspace 10";

        "${modifier}+Shift+ampersand" = "move container to workspace 1";
        "${modifier}+Shift+eacute" = "move container to workspace 2";
        "${modifier}+Shift+quotedbl" = "move container to workspace 3";
        "${modifier}+Shift+apostrophe" = "move container to workspace 4";
        "${modifier}+Shift+parenleft" = "move container to workspace 5";
        "${modifier}+Shift+minus" = "move container to workspace 6";
        "${modifier}+Shift+egrave" = "move container to workspace 7";
        "${modifier}+Shift+underscore" = "move container to workspace 8";
        "${modifier}+Shift+ccedilla" = "move container to workspace 9";
        "${modifier}+Shift+agrave" = "move container to workspace 10";
      };
    };
  };

  programs = {
    home-manager.enable = true;

    waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;

          modules-center = [ "sway/workspaces" ];
          modules-right = [ "battery" "clock" ];

          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
          };

          "battery" = {
            interval = 30;
            states = {
              "good" = 95;
              "warning" = 30;
              "critical" = 20;
            };
            format = "{capacity}%";
          };

          "clock" = {
            interval = 5;
            format = "{:%H:%M}";
            timezone = "Europe/Paris";
            tooltip-format = "<tt>{calendar}</tt>";
            calendar.format.today = "<b>{}</b>";
          };
        };
      };
    };
  };
}
