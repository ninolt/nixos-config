{ pkgs, lib, ... }: {
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
        { command = "${pkgs.librewolf}/bin/librewolf"; }
        { command = "discord"; }
      ];

      gaps = {
        outer = 10;
        inner = 20;
      };

      window = {
        titlebar = false;

        border = 0;
      };

      bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];

      assigns = {
        "2" = [
          { app_id = "librewolf"; }
          { app_id = "Tor Browser"; }
        ];

        "3" = [
          { app_id = "discord"; }
        ];
      };

      keybindings = lib.mkOptionDefault {
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 10%-";
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set 10%+";

        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";

        "${modifier}+d" = "exec --no-startup-id wofi --show drun";

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
}
