{ pkgs, lib, ...}: {
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

    librewolf = {
      enable = true;
      languagePacks = [ "fr-FR" "en-GB" ];

      settings = {
        "webgl.disabled" = false;
        "browser.theme.content-theme" = 0;
        "browser.theme.toolbar-theme" = 0;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
      };
    };

    waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;

          modules-center = [ "sway/workspaces" ];
          modules-right = [ "pulseaudio" "battery" "clock" ];

          "sway/workspaces" = {
            disable-scroll = true;
            all-outputs = true;
          };

          "pulseaudio" = {
            format = "{volume}%";
            format-bluetooth = "{volume}%";
            format-muted = "{volume}%";
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
