{ config, pkgs, lib, ... }: {
  # Linking cursor theme to adequate directory
  home.file = {
    "${config.home.homeDirectory}/.icons/capitaine-cursors-gruvbox/index.theme".source = ./index.theme;
    "${config.home.homeDirectory}/.icons/capitaine-cursors-gruvbox/cursors".source = ./cursors;
  };

  wayland.windowManager.sway = {
    enable = true;

    package = pkgs.swayfx;
    checkConfig = false;

    extraConfig = ''
      input * {
        xkb_layout "fr"
      }

      input "1739:0:Synaptics_TM3139-001" {
        natural_scroll enabled
        tap enabled
      }

      client.unfocused #928374 #928374 #ffffff #928374 #928374
      client.focused #fbf1c7 #fbf1c7 #ffffff #fbf1c7 #fbf1c7

      shadows enable
      shadow_blur_radius 30
      shadow_color #000000ee

      corner_radius 15

      set $low_opacity 0.8
      set $medium_opacity 0.85
      set $high_opacity 0.95

      blur enable
      blur_radius 4

	  layer_effects "wofi" blur enable;	corner_radius 15

      for_window [app_id="discord"] opacity $medium_opacity
      for_window [app_id="@joplin/app-desktop"] opacity $medium_opacity
      for_window [app_id="Alacritty"] opacity $low_opacity
	  for_window [app_id="spotify"] opacity $low_opacity

      seat * xcursor_theme capitaine-cursors-gruvbox
    '';

    config = rec {
      modifier = "Mod4";

      terminal = "alacritty";

      startup = [
        { command = "swaymsg output \"*\" bg ${../wallpapers}/$(ls ${../wallpapers} | shuf | head -n 1) fill"; }
        { command = "firefox"; }
        { command = "discord"; }
		{ command = "spotify"; }
      ];

      defaultWorkspace = "workspace 1";

      gaps = {
        outer = 10;
        inner = 20;
      };

      window = {
        titlebar = false;

        border = 1;
      };

      bars = [ { command = "${pkgs.waybar}/bin/waybar"; } ];

      # Command for app_id : swaymsg -t get_tree
      assigns = {
        "2" = [
          { app_id = "firefox"; }
          { app_id = "Tor Browser"; }
        ];

        "3" = [
          { app_id = "discord"; }
		  { app_id = "signal"; }
        ];

		"4" = [
		  { app_id = "spotify"; }
		];

        "5" = [
          { app_id = "@joplin/app-desktop"; }
        ];
      };

      keybindings = lib.mkOptionDefault {
        "XF86MonBrightnessDown" = "exec --no-startup-id brightnessctl set 10%-";
        "XF86MonBrightnessUp" = "exec --no-startup-id brightnessctl set 10%+";

        "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
        "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
        "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";

        "${modifier}+d" = "exec --no-startup-id wofi --show drun";
		"${modifier}+Mod1+e" = ''exec wofi-emoji --style <(echo '#text { font-size: 40px; }')'';

		"${modifier}+s" = ''exec swaymsg [app_id="firefox"] focus && wtype -M ctrl t -m ctrl && sleep 0.05 && wtype "% "'';
        "${modifier}+e" = ''exec swaymsg [app_id="firefox"] focus && wtype -M ctrl t -m ctrl'';

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
